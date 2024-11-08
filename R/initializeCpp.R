#' Initialize TileDB-backed matrices
#'
#' Initialize C++ representations of TileDB-backed matrices based on their \pkg{TileDBArray} representations.
#'
#' @param x A \pkg{TileDBArray} seed object.
#' @param tiledb.cache.size Integer scalar specifying the size of the cache in bytes during data extraction from a TileDB matrix.
#' Larger values reduce disk I/O during random access to the matrix, at the cost of increased memory usage.
#' @param tiledb.realize See the \code{realize} option in \code{\link{initializeOptions}}.
#' @param tiledb.realize.num.threads See the \code{realize.num.threads} option in \code{\link{initializeOptions}}.
#' @param tiledb.concurrency.level See the \code{concurrency.level} option in \code{\link{initializeOptions}}.
#' @param ... Further arguments, ignored.
#'
#' @return An external pointer that can be used in any \pkg{tatami}-compatible function.
#'
#' @examples
#' library(TileDBArray)
#' y <- matrix(runif(1000), ncol=20, nrow=50)
#' z <- as(y, "TileDBArray")
#' ptr <- initializeCpp(z)
#'
#' @author Aaron Lun
#' @name initializeCpp
NULL

#' @export
#' @rdname initializeCpp
#' @importFrom TileDBArray TileDBArraySeed
#' @importFrom beachmat initializeCpp checkMemoryCache
#' @importFrom DelayedArray getAutoBlockSize
setMethod("initializeCpp", "TileDBArraySeed", function(
    x,
    tiledb.cache.size=getAutoBlockSize(),
    tiledb.realize=initializeOptions("realize"),
    tiledb.realize.num.threads=initializeOptions("realize.num.threads"),
    tiledb.concurrency.level=initializeOptions("concurrency.level"),
    ...)
{
    if (tiledb.realize) {
        checkMemoryCache("beachmat.tiledb", paste(x@path, x@attr, sep=":"), function() {
            loadIntoMemory(x, cache.size=tiledb.cache.size, num.threads=tiledb.realize.num.threads, concurrency.level=tiledb.concurrency.level)
        })
    } else {
        if (is.null(tiledb.concurrency.level)) {
            tiledb.concurrency.level <- 0
        }
        if (x@sparse) {
            initialize_from_tiledb_sparse(x@path, x@attr, cache_size=tiledb.cache.size, concurrency_level=tiledb.concurrency.level)
        } else {
            initialize_from_tiledb_dense(x@path, x@attr, cache_size=tiledb.cache.size, concurrency_level=tiledb.concurrency.level)
        }
    }
})
