# library(testthat); library(beachmat.tiledb); source("test-loadIntoMemory.R")

library(TileDBArray)
y0 <- matrix(round(rnorm(1000) * 10), ncol=20, nrow=50)

test_that("memory loading works correctly for dense arrays", {
    for (itype in c("INT8", "UINT8", "INT16", "UINT16", "INT32", "UINT32", "FLOAT32")) {
        y <- if (startsWith(itype, "UINT")) abs(y0) else y0
        z <- writeTileDBArray(y, storagetype=itype)

        ptr <- loadIntoMemory(z)
        expect_false(beachmat::tatami.is.sparse(ptr))

        expect_identical(beachmat::tatami.dim(ptr), dim(y))
        expect_identical(beachmat::tatami.row(ptr, 1), y[1,])
        expect_identical(beachmat::tatami.column(ptr, 2), y[,2])
    }
})

library(Matrix)
sy0 <- round(rsparsematrix(50, 20, density=0.2))

test_that("memory loading works correctly for sparse arrays", {
    for (dtype in c("INT16", "INT32")) {
        for (itype in c("INT8", "UINT8", "INT16", "UINT16", "INT32", "UINT32", "FLOAT32")) {
            sy <- if (startsWith(itype, "UINT")) abs(sy0) else sy0
            sz <- writeTileDBArray(sy, storagetype=itype, dimtype=dtype)

            ptr <- initializeCpp(sz)
            expect_true(beachmat::tatami.is.sparse(ptr))

            expect_identical(beachmat:::tatami.dim(ptr), dim(sy))
            expect_identical(beachmat:::tatami.row(ptr, 1), sy[1,])
            expect_identical(beachmat:::tatami.column(ptr, 2), sy[,2])
        }
    }
})
