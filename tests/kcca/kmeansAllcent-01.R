.Random.seed <<- .ext.seed

test_that("kmeansAllcent", {
    x <- .ext.1
    k <- 10L
    cluster <- .ext.2
    kcca:::kmeansAllcent(x = x, cluster = cluster, k = k)
})
