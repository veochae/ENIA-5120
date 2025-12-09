library(testthat)

run_lab11_tests <- function(env) {
  test_that("characters_tbl exists", {
    expect_true(exists("characters_tbl", envir = env))
    tbl <- get("characters_tbl", envir = env)
    expect_s3_class(tbl, c("tbl_df", "tbl"))
  })

  test_that("books_tbl exists", {
    expect_true(exists("books_tbl", envir = env))
    tbl <- get("books_tbl", envir = env)
    expect_s3_class(tbl, "data.frame")
  })
}
