"""Upload session materials to Canvas based on metadata files."""

from __future__ import annotations

import argparse
import logging
import pathlib
from datetime import datetime, timedelta
from typing import Any, Dict, List, Optional

import yaml

from .canvas_client import CanvasClient, load_client_from_config

LOGGER = logging.getLogger(__name__)
PROJECT_ROOT = pathlib.Path(__file__).resolve().parents[1]
SESSIONS_ROOT = PROJECT_ROOT / "sessions"
CONFIG_PATH = pathlib.Path(__file__).with_name("config.yaml")
SCHEDULE_PATH = PROJECT_ROOT / "course_schedule.yaml"


def load_metadata(session_dir: pathlib.Path) -> Dict:
    meta_path = session_dir / "metadata.yaml"
    if not meta_path.exists():
        raise FileNotFoundError(f"Missing metadata for {session_dir.name}")
    return yaml.safe_load(meta_path.read_text())


def upload_files(
    client: CanvasClient,
    session_dir: pathlib.Path,
    file_specs: List[Dict],
    folder_prefix: str,
) -> List[Dict]:
    uploads = []
    for spec in file_specs:
        rel_path = spec["path"]
        filename = pathlib.Path(rel_path).name
        display = spec.get("display_name") or filename
        # Keep the file extension so downloads open in the right app.
        if pathlib.Path(display).suffix == "" and pathlib.Path(filename).suffix:
            display = f"{display}{pathlib.Path(filename).suffix}"
        file_path = session_dir / rel_path
        folder = f"{folder_prefix}/{session_dir.name}"
        LOGGER.info("Uploading %s", file_path)
        uploaded = client.upload_file(file_path, display_name=display, folder=folder)
        uploaded["display_name"] = display
        uploads.append(uploaded)
    return uploads


def build_links_html(uploaded_files: List[Dict]) -> str:
    if not uploaded_files:
        return "<p>No resources yet.</p>"
    items = []
    for info in uploaded_files:
        url = ensure_download_url(info)
        display = info.get("display_name") or info.get("filename")
        items.append(f'<li><a href="{url}">{display}</a></li>')
    return "<ul>" + "".join(items) + "</ul>"


def ensure_download_url(info: Dict) -> str:
    """Canvas' preview strips JS; use forced download links instead."""
    url = info.get("url") or info.get("preview_url") or info.get("download_url")
    if not url:
        return "#"
    if "download_frd=1" not in url:
        sep = "&" if "?" in url else "?"
        url = f"{url}{sep}download_frd=1"
    return url


def load_schedule(schedule_path: pathlib.Path) -> Dict:
    if not schedule_path.exists():
        LOGGER.warning("Schedule file %s not found; using empty schedule", schedule_path)
        return {}
    return yaml.safe_load(schedule_path.read_text()) or {}


def build_session_date_map(schedule: Dict) -> Dict[str, str]:
    dates = {}
    for entry in schedule.get("sessions", []):
        sid = entry.get("id")
        date = entry.get("date")
        if sid and date:
            dates[sid] = date
    return dates


def lookup_assignment(schedule: Dict, section: str, key: Optional[str]) -> Optional[Dict]:
    if not key:
        return None
    bucket = "homework" if section == "homework" else f"{section}s"
    for entry in schedule.get(bucket, []):
        if entry.get("key") == key:
            return entry
    LOGGER.warning("Assignment key '%s' not found in schedule for %s", key, section)
    return None


def compute_unlock_at(session_id: str, session_dates: Dict[str, str]) -> Optional[str]:
    date_str = session_dates.get(session_id)
    if not date_str:
        return None
    try:
        session_dt = datetime.fromisoformat(date_str)
    except ValueError:
        try:
            session_dt = datetime.strptime(date_str, "%Y-%m-%d")
        except ValueError:
            LOGGER.warning("Could not parse date '%s' for %s", date_str, session_id)
            return None
    unlock_dt = session_dt - timedelta(days=7)
    # Ensure ISO 8601 string (assume UTC if naive)
    if unlock_dt.tzinfo is None:
        return unlock_dt.isoformat() + "Z"
    return unlock_dt.isoformat()


def sync_session(
    client: CanvasClient,
    session_dir: pathlib.Path,
    default_folder: str,
    schedule: Dict,
    session_dates: Dict[str, str],
) -> None:
    meta = load_metadata(session_dir)
    LOGGER.info("Syncing %s", session_dir.name)
    module_meta = meta.get("module", {})
    module_name = module_meta.get("name") or meta.get("title")
    module_position = module_meta.get("position")
    if module_position is None:
        try:
            module_position = int(meta.get("session"))
        except (TypeError, ValueError):
            module_position = None
    module_obj = None
    unlock_at = compute_unlock_at(session_dir.name, session_dates)
    if module_name:
        module_obj = client.ensure_module(module_name, position=module_position, unlock_at=unlock_at)
        module_description = module_meta.get("description")
        if module_obj and module_description:
            desc_text = " ".join(module_description.strip().split())
            client.ensure_module_subheader(module_obj["id"], desc_text)

    # Slides
    slides_meta = meta.get("slides")
    if slides_meta:
        rendered = session_dir / slides_meta.get("rendered", "slides.html")
        if not rendered.exists():
            LOGGER.warning("Skipped slides for %s (missing %s)", session_dir, rendered)
        else:
            page_title = slides_meta.get("page_title", meta["title"])
            page_slug = CanvasClient._slugify(page_title)
            slides_upload = client.upload_file(
                rendered,
                display_name=slides_meta.get("display_name") or rendered.name,
                folder=f"{default_folder}/{session_dir.name}/slides",
            )
            body = """
<h2>{title}</h2>
<p>Latest slide deck:</p>
<ul>
  <li><a href="{url}">Download / View slides</a></li>
</ul>
""".format(title=meta["title"], url=ensure_download_url(slides_upload))
            client.upsert_page(page_title, body)
            if module_obj:
                client.ensure_module_page_item(module_obj["id"], page_title, page_slug)

    for section_name in ["lab", "homework"]:
        section = meta.get(section_name)
        if not section:
            continue
        files = section.get("files", [])
        uploads = upload_files(
            client,
            session_dir,
            files,
            folder_prefix=f"{default_folder}/{section_name}",
        )
        description = section.get("description", "") + build_links_html(uploads)
        assignment_data: Dict[str, Any] = {}
        if section.get("assignment"):
            assignment_data.update(section["assignment"])
        schedule_entry = lookup_assignment(schedule, section_name, section.get("assignment_key"))
        if schedule_entry:
            assignment_data.update(schedule_entry)
        if not assignment_data:
            LOGGER.warning(
                "No assignment details found for %s in %s; skipping Canvas assignment update",
                section_name,
                session_dir.name,
            )
            continue
        client.ensure_assignment(
            name=assignment_data["name"],
            points=assignment_data.get("points", 0),
            submission_types=assignment_data.get("submission_types", ["online_upload"]),
            published=assignment_data.get("published", True),
            description=description,
            due_at=assignment_data.get("due_at"),
        )


def sync_quizzes(client: CanvasClient, schedule: Dict) -> None:
    for quiz in schedule.get("quizzes", []):
        client.ensure_assignment(
            name=quiz["name"],
            points=quiz.get("points", 0),
            submission_types=quiz.get("submission_types", ["online_quiz"]),
            published=quiz.get("published", True),
            description=quiz.get("description", ""),
            due_at=quiz.get("due_at"),
        )


def main(config_path: pathlib.Path = CONFIG_PATH, schedule_path: pathlib.Path = SCHEDULE_PATH) -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    client = load_client_from_config(config_path)
    config = yaml.safe_load(config_path.read_text())
    schedule = load_schedule(schedule_path)
    session_dates = build_session_date_map(schedule)
    default_folder = config.get("default_folder_path", "Course Files")
    for session_dir in sorted(SESSIONS_ROOT.glob("session*")):
        sync_session(client, session_dir, default_folder, schedule, session_dates)
    sync_quizzes(client, schedule)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sync ENIA-5120 materials to Canvas")
    parser.add_argument(
        "--config",
        type=pathlib.Path,
        default=CONFIG_PATH,
        help="Path to Canvas config file",
    )
    parser.add_argument(
        "--schedule",
        type=pathlib.Path,
        default=SCHEDULE_PATH,
        help="Path to central course schedule file",
    )
    args = parser.parse_args()
    main(args.config, args.schedule)
