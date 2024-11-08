# library(testthat); library(beachmat.tiledb); source("test-initializeCpp.R")

library(TileDBArray)
y <- matrix(runif(1000), ncol=20, nrow=50)
z <- as(y, "TileDBArray")

test_that("initialization works correctly for dense TileDB arrays", {
    ptr <- initializeCpp(z)
    expect_false(beachmat::tatami.is.sparse(ptr))

    expect_identical(beachmat::tatami.dim(ptr), dim(y))
    expect_identical(beachmat::tatami.row(ptr, 1), y[1,])
    expect_identical(beachmat::tatami.column(ptr, 2), y[,2])

    expect_identical(beachmat::tatami.row.sums(ptr, 2), rowSums(y))
    expect_identical(beachmat::tatami.column.sums(ptr, 2), colSums(y))

    # Trying some other options. 
    cptr <- initializeCpp(z, tiledb.concurrency.level=2)
    expect_identical(beachmat::tatami.row.sums(cptr, 2), rowSums(y))
    expect_identical(beachmat::tatami.column.sums(cptr, 2), colSums(y))
})

test_that("initialization works correctly with dense memorization", {
    ptr <- initializeCpp(z, tiledb.realize=TRUE)
    expect_false(beachmat::tatami.is.sparse(ptr))

    expect_identical(beachmat::tatami.dim(ptr), dim(y))
    expect_identical(beachmat::tatami.row(ptr, 1), y[1,])
    expect_identical(beachmat::tatami.column(ptr, 2), y[,2])

    expect_identical(beachmat::tatami.row.sums(ptr, 2), rowSums(y))
    expect_identical(beachmat::tatami.column.sums(ptr, 2), colSums(y))
})

library(Matrix)
sy <- rsparsematrix(50, 20, density=0.2)
sz <- as(sy, "TileDBArray")

test_that("initialization works correctly for sparse TileDB arrays", {
    ptr <- initializeCpp(sz)
    expect_true(beachmat::tatami.is.sparse(ptr))

    expect_identical(beachmat:::tatami.dim(ptr), dim(sy))
    expect_identical(beachmat:::tatami.row(ptr, 1), sy[1,])
    expect_identical(beachmat:::tatami.column(ptr, 2), sy[,2])

    expect_identical(beachmat:::tatami.row.sums(ptr, 2), Matrix::rowSums(sy))
    expect_identical(beachmat:::tatami.column.sums(ptr, 2), Matrix::colSums(sy))

    # Trying some other options. 
    cptr <- initializeCpp(sz, tiledb.concurrency.level=2)
    expect_identical(beachmat::tatami.row.sums(cptr, 2), Matrix::rowSums(sy))
    expect_identical(beachmat::tatami.column.sums(cptr, 2), Matrix::colSums(sy))
})

test_that("initialization works correctly with sparse memorization", {
    ptr <- initializeCpp(sz, tiledb.realize=TRUE)
    expect_true(beachmat::tatami.is.sparse(ptr))

    expect_identical(beachmat:::tatami.dim(ptr), dim(sy))
    expect_identical(beachmat:::tatami.row(ptr, 1), sy[1,])
    expect_identical(beachmat:::tatami.column(ptr, 2), sy[,2])

    expect_identical(beachmat:::tatami.row.sums(ptr, 2), Matrix::rowSums(sy))
    expect_identical(beachmat:::tatami.column.sums(ptr, 2), Matrix::colSums(sy))
})
