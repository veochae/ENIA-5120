# ENIA-5120 – Intro to Data Science and Analytics

This repository is the instructor-facing source of truth for ENIA-5120. It keeps lectures, labs, homework, grading automation, and Canvas syncing in one reproducible place.

## Repository layout

```
sessions/           # Session-specific materials (slides, lab, homework)
  session00/
    metadata.yaml   # Canvas + file mapping for automation
    slides.qmd      # Quarto slide deck for the session
    lab/
      lab_spec.md
      lab_template.Rmd
      lab_tests.R
      lab_rubric.yaml
    homework/
      hw_prompt.md
      hw_rubric.yaml
canvas/
  config.yaml           # Canvas API base URL, course id, env var for token
  sync_to_canvas.py     # Upload slides/specs/prompts to Canvas
  fetch_submissions.py  # Download submissions from Canvas
  upload_grades.py      # Push grades/comments back to Canvas (stub)
grading/
  grade_labs.R
  grade_homework.py
submissions/        # gitignored cache of Canvas downloads
```

Each session directory is self-contained, which means adding a new session is as simple as copying a folder and updating `metadata.yaml`.

## Automation overview

1. **Push to `main` → Sync to Canvas**
   - `.github/workflows/canvas-sync.yml` renders every `slides.qmd` with Quarto, then runs `canvas/sync_to_canvas.py` to upload slide HTML/PDF plus lab/homework files referenced in each session’s metadata file.

2. **Scheduled/manual submission fetch**
   - `.github/workflows/fetch-submissions.yml` runs on-demand or nightly to pull student submissions for labs and homework via the Canvas API into `submissions/`.

3. **Grading hooks**
   - Placeholder scripts in `grading/` show where to bolt on hard-coded tests plus LLM evaluation. Their outputs (CSV/JSON) feed `canvas/upload_grades.py` to return scores/comments to Canvas.

Store your Canvas API token as a GitHub Actions secret named `CANVAS_API_TOKEN`. The scripts read the secret via the env var defined in `canvas/config.yaml`.

## Getting started locally

1. Install [Quarto](https://quarto.org/), R, and Python 3.11+.
2. Copy `canvas/config.sample.yaml` to `canvas/config.yaml` (already done here with placeholders) and update course details.
3. Customize the sample session materials, then run:

```bash
cd sessions/session00
quarto render slides.qmd
```

4. Commit + push to `main` to trigger the Canvas sync workflow.

See inline comments inside `canvas/*.py` for the Canvas API endpoints used and how to extend them.
