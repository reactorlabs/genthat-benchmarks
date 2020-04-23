# Adapted from genthat::test_generated_file
# https://github.com/PRL-PRG/genthat/blob/43c7b4b/R/run-generated-tests.R#L3L14
loadEnv <- function(test) {
    test_env <- function() {
        new.env(parent = globalenv())
    }

    ext_file <- file.path(dirname(test), paste0(tools::file_path_sans_ext(basename(test)), ".ext"))
    env <- if (file.exists(ext_file)) {
        ext <- readRDS(ext_file)
        parent.env(ext) <- test_env()
        ext
    } else {
        test_env()
    }
    env
}

# Adapted from testthat::source_file
# https://github.com/r-lib/testthat/blob/9d6ae66/R/source.R#L15L45
test_file <- function(path, env) {
    stopifnot(file.exists(path))
    stopifnot(is.environment(env))

    lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
    srcfile <- srcfilecopy(path, lines, file.info(path)[1, "mtime"], isFile = TRUE)

    ## We need to parse from a connection, because parse() has a bug,
    ## and converts the input to the native encoding, if the text arg is used
    con <- textConnection(lines, encoding = "UTF-8")
    on.exit(try(close(con), silent = TRUE), add = TRUE)
    exprs <- parse(con, n = -1, srcfile = srcfile, encoding = "UTF-8")

    n <- length(exprs)
    if (n == 0L) return(invisible())

    old_dir <- setwd(dirname(path))
    on.exit(setwd(old_dir), add = TRUE)

    invisible(eval(exprs, new.env(parent = env)))
}

runTest <- function(test, iterations, warmup) {
    env <- loadEnv(test)

    # warmup
    for (i in 1:warmup) {
        test_file(test, env = env)
    }

    # benchmark and time
    inner <- function(iterations) {
        for (i in 1:iterations) {
            test_file(test, env = env)
        }
    }
    system.time(inner(iterations))[[3]] * 1000
}

run <- function(args) {
    if (length(args) < 1 || length(args) > 3) {
        stop(printUsage())
    }

    path <- args[[1]]
    iterations <- 15
    warmup <- 5

    if (length(args) >= 2) {
        iterations <- strtoi(args[[2]])
    }
    if (length(args) >= 3) {
        warmup <- strtoi(args[[3]])
    }

    time <- runTest(path, iterations, warmup)
    cat(sprintf("%50s    %9.0f ms\n", path, time))
}

printUsage <- function() {
    cat("runner.R test [iterations] [warmup]\n")
    cat("\n")
    cat("    test       - path to the test file; if path is a directory, run\n")
    cat("                 all tests in that directory\n")
    cat("    iterations - number of iterations to run the test, default: 15\n")
    cat("    warmup     - number of iterations for warmup, default: 5\n")
    cat("\n")
}

run(commandArgs(trailingOnly = TRUE))
