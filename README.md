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
scripts/
  render_handouts.py # Generates PDF copies of prompts/rubrics for Canvas
course_schedule.yaml # Central control for points/due dates
```

Each session directory is self-contained, which means adding a new session is as simple as copying a folder and updating `metadata.yaml`.

### Central grading schedule

`course_schedule.yaml` is the single source of truth for all graded work:

- Update a lab/homework entry there to change Canvas assignment names, points, or due dates.
- Each session’s metadata simply references an `assignment_key`, so you never have to duplicate the settings.
- Quiz placeholders also live in the same file; when you know the dates, adjust the `due_at` values (ISO-8601 strings) and the automation will update Canvas on the next push.

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
3. Customize the sample session materials, then render slides locally if you want to preview HTML (the workflow also renders before uploading). Run `python scripts/render_handouts.py` if you want to preview the PDF versions of any `.md`/`.yaml` instructions or rubrics locally before pushing.

```bash
cd sessions/session00
quarto render slides.qmd
python ../../scripts/render_handouts.py
```

4. Commit + push to `main` to trigger the Canvas sync workflow.

During CI the rendered `.html` files live only in the workflow run (they remain gitignored locally), but the sync script uploads those HTML artifacts to Canvas so the downloaded files are standard web pages.

See inline comments inside `canvas/*.py` for the Canvas API endpoints used and how to extend them.
