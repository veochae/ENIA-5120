library(testthat)

run_lab08_tests <- function(env) {
  required_objs <- c(
    "abalone_raw", "abalone_df", "abalone_numeric", "abalone_scaled",
    "wcss_df", "chosen_k", "kmeans_final", "kmeans_plot_df",
    "centroid_plot_df", "abalone_dist", "hc_complete", "hc_clusters",
    "hier_plot_df", "type_compare_kmeans", "type_compare_hclust"
  )

  for (obj in required_objs) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste0(obj, " not found"))
    })
  }

  test_that("abalone raw data looks correct", {
    df <- get("abalone_raw", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c(
      "Type", "LongestShell", "Diameter", "Height", "WholeWeight",
      "ShuckedWeight", "VisceraWeight", "ShellWeight", "Rings"
    ) %in% names(df)))
  })

  test_that("numeric clustering data excludes Type", {
    df <- get("abalone_numeric", envir = env)
    expect_s3_class(df, "data.frame")
    expect_false("Type" %in% names(df))
    expect_true(all(vapply(df, is.numeric, logical(1))))
  })

  test_that("scaled data has expected dimensions", {
    scaled <- get("abalone_scaled", envir = env)
    numeric_df <- get("abalone_numeric", envir = env)
    expect_equal(dim(scaled), dim(as.matrix(numeric_df)))
  })

  test_that("elbow table has k and wcss", {
    tbl <- get("wcss_df", envir = env)
    expect_s3_class(tbl, "data.frame")
    expect_true(all(c("k", "wcss") %in% names(tbl)))
    expect_true(nrow(tbl) >= 5)
  })

  test_that("chosen_k is a reasonable integer", {
    k <- get("chosen_k", envir = env)
    expect_true(is.numeric(k))
    expect_true(length(k) == 1)
    expect_true(k >= 2 && k <= 8)
  })

  test_that("kmeans final object matches chosen_k", {
    km <- get("kmeans_final", envir = env)
    k <- get("chosen_k", envir = env)
    expect_s3_class(km, "kmeans")
    expect_equal(nrow(km$centers), as.integer(k))
  })

  test_that("plot data includes PCs and clusters", {
    plot_df <- get("kmeans_plot_df", envir = env)
    cent_df <- get("centroid_plot_df", envir = env)
    expect_true(all(c("PC1", "PC2", "cluster", "Type") %in% names(plot_df)))
    expect_true(all(c("PC1", "PC2", "cluster") %in% names(cent_df)))
  })

  test_that("hierarchical clustering objects are valid", {
    d <- get("abalone_dist", envir = env)
    hc <- get("hc_complete", envir = env)
    cl <- get("hc_clusters", envir = env)
    raw_df <- get("abalone_raw", envir = env)
    expect_s3_class(d, "dist")
    expect_s3_class(hc, "hclust")
    expect_equal(length(cl), nrow(raw_df))
  })

  test_that("comparison tables are contingency tables", {
    km_tab <- get("type_compare_kmeans", envir = env)
    hc_tab <- get("type_compare_hclust", envir = env)
    expect_true(is.matrix(km_tab) || is.table(km_tab))
    expect_true(is.matrix(hc_tab) || is.table(hc_tab))
    expect_equal(ncol(km_tab), 3)
    expect_equal(ncol(hc_tab), 3)
  })
}
