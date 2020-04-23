.Random.seed <<- .ext.seed

test_that("summarizeCenters", {
    x <- .ext.1
    centers <- .ext.2
    kcca:::summarizeCenters(x = x, centers = centers)
})
