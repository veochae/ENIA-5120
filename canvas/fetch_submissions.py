"""Download lab/homework submissions from Canvas assignments."""

from __future__ import annotations

import argparse
import logging
import pathlib
from typing import Dict

import yaml

from .canvas_client import load_client_from_config

LOGGER = logging.getLogger(__name__)
PROJECT_ROOT = pathlib.Path(__file__).resolve().parents[1]
SESSIONS_ROOT = PROJECT_ROOT / "sessions"
SUBMISSIONS_ROOT = PROJECT_ROOT / "submissions"
CONFIG_PATH = pathlib.Path(__file__).with_name("config.yaml")


def load_metadata(session_dir: pathlib.Path) -> Dict:
    meta_path = session_dir / "metadata.yaml"
    return yaml.safe_load(meta_path.read_text())


def fetch_for_assignment(client, assignment_name: str, dest_dir: pathlib.Path) -> None:
    assignment_id = client.find_assignment_id(assignment_name)
    if not assignment_id:
        LOGGER.warning("Assignment '%s' not found; skipping", assignment_name)
        return
    submissions = client.get_submissions(assignment_id)
    LOGGER.info("Found %s submissions for %s", len(submissions), assignment_name)
    for submission in submissions:
        attachments = submission.get("attachments") or []
        user_id = submission.get("user_id")
        attempt = submission.get("attempt") or 1
        for attachment in attachments:
            filename = attachment.get("filename")
            dest_path = dest_dir / f"{user_id}_attempt{attempt}_{filename}"
            LOGGER.info("Downloading %s to %s", filename, dest_path)
            client.download_attachment(attachment["url"], dest_path)


def main(config_path: pathlib.Path = CONFIG_PATH) -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    client = load_client_from_config(config_path)
    for session_dir in sorted(SESSIONS_ROOT.glob("session*")):
        meta = load_metadata(session_dir)
        for section_name in ["lab", "homework"]:
            section = meta.get(section_name)
            if not section:
                continue
            assignment = section.get("assignment")
            if not assignment:
                continue
            dest_dir = SUBMISSIONS_ROOT / f"{section_name}s" / session_dir.name
            dest_dir.mkdir(parents=True, exist_ok=True)
            fetch_for_assignment(client, assignment["name"], dest_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch Canvas submissions for ENIA-5120")
    parser.add_argument(
        "--config",
        type=pathlib.Path,
        default=CONFIG_PATH,
        help="Path to Canvas config file",
    )
    args = parser.parse_args()
    main(args.config)
