library(testthat)

run_lab05_tests <- function(env) {
  for (obj in c("hist_plot", "box_plot", "scatter_plot")) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env))
      plt <- get(obj, envir = env)
      expect_s3_class(plt, "ggplot")
    })
  }
}
