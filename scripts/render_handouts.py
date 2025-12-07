"""Render PDF handouts from lab/homework Markdown + rubric YAML files."""

from __future__ import annotations

import argparse
import pathlib
import subprocess
from typing import Iterable

import yaml

ROOT = pathlib.Path(__file__).resolve().parents[1]
SESSIONS = ROOT / "sessions"


def run_pandoc(args: list[str], *, input_text: str | None = None) -> None:
    subprocess.run(
        ["pandoc", *args],
        check=True,
        input=input_text.encode() if input_text else None,
    )


def convert_markdown(md_path: pathlib.Path) -> pathlib.Path:
    pdf_path = md_path.with_suffix(".pdf")
    run_pandoc([str(md_path), "-o", str(pdf_path)])
    return pdf_path


def convert_rubric(yaml_path: pathlib.Path) -> pathlib.Path:
    data = yaml.safe_load(yaml_path.read_text()) or {}
    title = yaml_path.stem.replace("_", " ").title()
    total = data.get("total_points", "-")
    criteria = data.get("criteria", [])

    lines = [f"# {title} Rubric", "", f"**Total points:** {total}", ""]
    if criteria:
        lines.append("| Criterion | Description | Max Points |")
        lines.append("| --- | --- | --- |")
        for crit in criteria:
            crit_id = crit.get("id", "-")
            desc = crit.get("description", "")
            max_pts = crit.get("max_points", "")
            desc = desc.replace("|", "\\|")
            lines.append(f"| {crit_id} | {desc} | {max_pts} |")
    else:
        lines.append("_No criteria defined._")
    markdown = "\n".join(lines)
    pdf_path = yaml_path.with_suffix(".pdf")
    run_pandoc(["-f", "markdown", "-o", str(pdf_path)], input_text=markdown)
    return pdf_path


def iter_targets(patterns: Iterable[str]) -> Iterable[pathlib.Path]:
    for session_dir in sorted(SESSIONS.glob("session*/")):
        for rel_pattern in patterns:
            yield from session_dir.glob(rel_pattern)


def main() -> None:
    parser = argparse.ArgumentParser(description="Render PDF handouts for students")
    parser.parse_args()

    md_patterns = ["lab/*.md", "homework/*.md"]
    yaml_patterns = ["lab/*.yaml", "lab/*.yml", "homework/*.yaml", "homework/*.yml"]

    for md_path in iter_targets(md_patterns):
        convert_markdown(md_path)

    for yaml_path in iter_targets(yaml_patterns):
        convert_rubric(yaml_path)


if __name__ == "__main__":
    main()
