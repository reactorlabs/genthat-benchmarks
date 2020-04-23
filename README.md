# genthat-benchmarks

This repository contains benchmarks that were automatically extracted by
[genthat](https://github.com/PRL-PRG/genthat).

genthat records all function arguments, return values, and seed values, and
generates tests in the testthat format. In the future, genthat may be able to
generate tests in different formats -- for now, we manually edit the tests to
bypass testthat.

Sometimes, test values cannot be serialized into the test file. Instead, they
are serialized into a binary file, and then loaded into the test as `.ext.N`
variables.


## Prerequisites

You will need R 3.5.0 or newer.

Install the benchmark as a package. Since genthat works on packages, the
benchmark code (originally an R script) has been converted to a package, and
included in the `pkgs` directory.

```
/path/to/custom/R CMD INSTALL pkgs/[package name]
```


## Running

```
/path/to/custom/Rscript runner.R tests/[path]/[some test].R [iterations]
```

bash one-liner to run all tests in a directory:

```
ls tests/[path]/*.R | sort | while read line; do /path/to/custom/Rscript runner.R $line; done
```
