.Random.seed <<- .ext.seed

x <- .ext.1
distmat <- .ext.2
kcca:::kmeansCluster(x = x, distmat = distmat)
