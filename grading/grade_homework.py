"""Stub for homework pre-grading via LLM."""

import csv
import json
import pathlib

OUTPUT_PATH = pathlib.Path(__file__).with_name("hw_grades.csv")


def main():
    rows = [
        {"user_id": "12345", "score": 15, "comment": "Placeholder"},
    ]
    with OUTPUT_PATH.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=["user_id", "score", "comment"])
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


if __name__ == "__main__":
    main()
