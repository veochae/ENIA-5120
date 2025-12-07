"""Upload grades + comments from CSV back to Canvas."""

from __future__ import annotations

import argparse
import csv
import logging
import pathlib

from .canvas_client import load_client_from_config

LOGGER = logging.getLogger(__name__)
CONFIG_PATH = pathlib.Path(__file__).with_name("config.yaml")


def upload_grades(csv_path: pathlib.Path, assignment_name: str, config_path: pathlib.Path) -> None:
    client = load_client_from_config(config_path)
    assignment_id = client.find_assignment_id(assignment_name)
    if not assignment_id:
        raise RuntimeError(f"Assignment '{assignment_name}' not found")
    with csv_path.open() as handle:
        reader = csv.DictReader(handle)
        for row in reader:
            user_id = row["user_id"]
            score = row["score"]
            comment = row.get("comment", "")
            LOGGER.info("Posting grade for user %s", user_id)
            path = f"/api/v1/courses/{client.course_id}/assignments/{assignment_id}/submissions/{user_id}"
            payload = {
                "submission[posted_grade]": score,
                "comment[text_comment]": comment,
            }
            client._request("PUT", path, data=payload)


def main() -> None:
    parser = argparse.ArgumentParser(description="Upload grades to Canvas from CSV")
    parser.add_argument("csv", type=pathlib.Path, help="CSV with columns user_id,score,comment")
    parser.add_argument("assignment", help="Canvas assignment name")
    parser.add_argument(
        "--config", type=pathlib.Path, default=CONFIG_PATH, help="Canvas config path"
    )
    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    upload_grades(args.csv, args.assignment, args.config)


if __name__ == "__main__":
    main()
