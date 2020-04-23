.Random.seed <<- .ext.seed

test_that("computeClusterSim", {
    distmat <- .ext.1
    cluster <- list(.ext.2, .ext.3)
    kcca:::computeClusterSim(distmat = distmat, cluster = cluster)
})
