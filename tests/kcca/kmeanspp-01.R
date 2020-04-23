.Random.seed <<- .ext.seed

x <- .ext.1
na.omit <- stats::na.omit
k <- 10L
kcca:::kmeanspp(x = na.omit(unique(x)), k = k)
