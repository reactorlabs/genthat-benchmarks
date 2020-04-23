.Random.seed <<- .ext.seed

x <- .ext.1
k <- 10L
cluster <- .ext.2
kcca:::kmeansAllcent(x = x, cluster = cluster, k = k)
