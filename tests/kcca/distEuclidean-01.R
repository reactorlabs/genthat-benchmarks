.Random.seed <<- .ext.seed

test_that("distEuclidean", {
    x <- .ext.1
    centers <- .ext.2
    kcca:::distEuclidean(x = x, centers = centers)
})
