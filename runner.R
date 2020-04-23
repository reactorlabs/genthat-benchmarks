library(testthat)

# Adapted from genthat::test_generated_file
# https://github.com/PRL-PRG/genthat/blob/43c7b4b/R/run-generated-tests.R#L3L14
loadEnv <- function(test) {
    ext_file <- file.path(dirname(test), paste0(tools::file_path_sans_ext(basename(test)), ".ext"))
    env <- if (file.exists(ext_file)) {
        ext <- readRDS(ext_file)
        parent.env(ext) <- testthat::test_env()
        ext
    } else {
        testthat::test_env()
    }
    env
}

runTest <- function(test, iterations, warmup) {
    env <- loadEnv(test)

    # warmup
    for (i in 1:warmup) {
        testthat::source_dir(test, env=env)
    }

    # benchmark and time
    inner <- function(iterations) {
        for (i in 1:iterations) {
            testthat::source_dir(test, env=env)
        }
    }
    system.time(inner(iterations))[[3]] * 1000
}

# TODO: simplify test running, try to bypass testthat
run <- function(args) {
    if (length(args) < 1 || length(args) > 3) {
        stop(printUsage())
    }

    path <- args[[1]]
    iterations <- 100
    warmup <- 5

    if (length(args) >= 2) {
        iterations <- strtoi(args[[2]])
    }
    if (length(args) >= 3) {
        warmup <- strtoi(args[[3]])
    }

    time <- runTest(path, iterations, warmup)
    cat(sprintf("%50s    %9.2f ms\n", path, time))
}

printUsage <- function() {
    cat("runner.R test [iterations] [warmup]\n")
    cat("\n")
    cat("    test       - path to the test file; if path is a directory, run\n")
    cat("                 all tests in that directory\n")
    cat("    iterations - number of iterations to run the test, default: 100\n")
    cat("    warmup     - number of iterations for warmup, default: 5\n")
    cat("\n")
}

run(commandArgs(trailingOnly = TRUE))
