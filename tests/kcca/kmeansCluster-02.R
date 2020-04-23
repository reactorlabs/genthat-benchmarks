.Random.seed <<- .ext.seed

distmat <- .ext.1
kcca:::kmeansCluster(n = 2, distmat = distmat)
