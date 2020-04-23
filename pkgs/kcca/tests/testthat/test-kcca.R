test_that("multiplication works", {
  k <- 10 # <------ customize here
  set.seed(123)

  data_file <- system.file("data.csv", package="kcca")
  data <- read.csv(data_file, header=F, sep=" ")
  km <- kcca(data, k=k, iter.max=10)

  cat("SSE:", km$sse, "\n")
  cat("Iterations:", km$iter, "\n")

  expect_equal(km$iter, 10)
})
