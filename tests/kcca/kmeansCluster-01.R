library(testthat)

.Random.seed <<- .ext.seed

test_that("kmeansCluster", {
    x <- .ext.1
    distmat <- .ext.2
    kcca:::kmeansCluster(x = x, distmat = distmat)
})
