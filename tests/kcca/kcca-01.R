.Random.seed <<- .ext.seed

test_that("kcca", {
    k <- 10
    data <- structure(list(V1 = .ext.1, V2 = .ext.2, V3 = .ext.3, V4 = .ext.4, V5 = .ext.5, V6 = .ext.6, V7 = .ext.7, V8 = .ext.8), 
        class = "data.frame", row.names = c(NA, -110250L))
    kcca:::kcca(x = data, k = k, iter.max = 10)
})
