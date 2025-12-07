"""Upload session materials to Canvas based on metadata files."""

from __future__ import annotations

import argparse
import logging
import pathlib
from typing import Dict, List

import yaml

from .canvas_client import CanvasClient, load_client_from_config

LOGGER = logging.getLogger(__name__)
PROJECT_ROOT = pathlib.Path(__file__).resolve().parents[1]
SESSIONS_ROOT = PROJECT_ROOT / "sessions"
CONFIG_PATH = pathlib.Path(__file__).with_name("config.yaml")


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
        display = spec.get("display_name") or pathlib.Path(rel_path).name
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
        url = info.get("url") or info.get("preview_url")
        display = info.get("display_name") or info.get("filename")
        items.append(f'<li><a href="{url}">{display}</a></li>')
    return "<ul>" + "".join(items) + "</ul>"


def sync_session(client: CanvasClient, session_dir: pathlib.Path, default_folder: str) -> None:
    meta = load_metadata(session_dir)
    LOGGER.info("Syncing %s", session_dir.name)
    # Slides
    slides_meta = meta.get("slides")
    if slides_meta:
        rendered = session_dir / slides_meta.get("rendered", "slides.html")
        if not rendered.exists():
            LOGGER.warning("Skipped slides for %s (missing %s)", session_dir, rendered)
        else:
            slides_upload = client.upload_file(
                rendered,
                display_name=f"{meta['title']} Slides",
                folder=f"{default_folder}/{session_dir.name}/slides",
            )
            body = """
<h2>{title}</h2>
<p>Latest slide deck:</p>
<ul>
  <li><a href="{url}">Download / View slides</a></li>
</ul>
""".format(title=meta["title"], url=slides_upload.get("url"))
            page_title = slides_meta.get("page_title", meta["title"])
            client.upsert_page(page_title, body)

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
        assignment = section.get("assignment")
        if assignment:
            client.ensure_assignment(
                name=assignment["name"],
                points=assignment.get("points", 0),
                submission_types=assignment.get("submission_types", ["online_upload"]),
                published=assignment.get("published", True),
                description=description,
            )


def main(config_path: pathlib.Path = CONFIG_PATH) -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    client = load_client_from_config(config_path)
    config = yaml.safe_load(config_path.read_text())
    default_folder = config.get("default_folder_path", "Course Files")
    for session_dir in sorted(SESSIONS_ROOT.glob("session*")):
        sync_session(client, session_dir, default_folder)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sync ENIA-5120 materials to Canvas")
    parser.add_argument(
        "--config",
        type=pathlib.Path,
        default=CONFIG_PATH,
        help="Path to Canvas config file",
    )
    args = parser.parse_args()
    main(args.config)
