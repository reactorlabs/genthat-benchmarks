.Random.seed <<- .ext.seed

test_that("clusinfo", {
    cluster <- list(.ext.1, .ext.2)
    cldist <- .ext.3
    kcca:::clusinfo(cluster = cluster[[1]], cldist = cldist)
})
