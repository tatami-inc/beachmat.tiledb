#' Load a TileDB matrix into memory
#'
#' Load a TileDB-backed matrix into memory as an external pointer to a \pkg{tatami}-compatible representation.
#' This differs from the (default) behavior of \code{\link{initializeCpp}}, which only loads slices of the matrix on request.
#'
#' @param x A \pkg{TileDBArray}-derived matrix or seed object.
#' @param cache.size Integer scalar specifying the size of the cache in bytes during data extraction from a TileDB matrix.
#' @param concurrency.level See the \code{concurrency.level} option in \code{\link{initializeOptions}}.
#' @param num.threads Integer scalar specifying the number of threads to use for loading.
#' 
#' @return An external pointer that can be used in \pkg{tatami}-based functions.
#'
#' @author Aaron Lun
#' @examples
#' library(TileDBArray)
#' y <- matrix(runif(1000), ncol=20, nrow=50)
#' z <- as(y, "TileDBArray")
#' ptr <- loadIntoMemory(z)
#'
#' @export
#' @import methods
#' @importFrom TileDBArray TileDBArraySeed
#' @importFrom DelayedArray getAutoBlockSize
loadIntoMemory <- function(x, cache.size=getAutoBlockSize(), num.threads=1, concurrency.level=initializeOptions("concurrency.level")) {
    if (is(x, "DelayedArray")) {
        x <- x@seed
    }
    if (is.null(concurrency.level)) {
        concurrency.level <- 0L
    }
    if (x@sparse) {
        load_sparse(x@path, x@attr, cache_size=cache.size, num_threads=num.threads, concurrency_level=concurrency.level)
    } else {
        load_dense(x@path, x@attr, cache_size=cache.size, num_threads=num.threads, concurrency_level=concurrency.level)
    }
}
