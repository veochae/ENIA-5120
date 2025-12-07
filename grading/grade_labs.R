#!/usr/bin/env Rscript
# Placeholder script showing how lab grading could work.

library(testthat)
library(yaml)

root <- normalizePath(file.path(dirname(__file__), ".."))
submissions_dir <- file.path(root, "submissions", "labs")
out_path <- file.path(root, "grading", "lab_grades.csv")

sessions <- list.dirs(submissions_dir, recursive = FALSE, full.names = TRUE)

results <- data.frame()

for (session_path in sessions) {
  submissions <- list.files(session_path, full.names = TRUE)
  session_name <- basename(session_path)
  session_meta <- yaml::read_yaml(file.path(root, "sessions", session_name, "lab", "lab_rubric.yaml"))
  for (submission in submissions) {
    env <- new.env(parent = globalenv())
    tryCatch({
      source(submission, local = env)
      score <- session_meta$total_points  # placeholder: full credit
      results <- rbind(results, data.frame(
        session = session_name,
        submission = basename(submission),
        score = score,
        comment = "Auto-graded placeholder"
      ))
    }, error = function(e) {
      results <- rbind(results, data.frame(
        session = session_name,
        submission = basename(submission),
        score = 0,
        comment = paste("Execution error:", e$message)
      ))
    })
  }
}

write.csv(results, out_path, row.names = FALSE)
