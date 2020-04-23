library(testthat)

.Random.seed <<- .ext.seed

test_that("kmeansCluster", {
    distmat <- .ext.1
    kcca:::kmeansCluster(n = 2, distmat = distmat)
})
