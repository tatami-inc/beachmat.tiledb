#' Load a TileDB matrix into memory
#'
#' Load a TileDB-backed matrix into memory as an external pointer to a \pkg{tatami}-compatible representation.
#' This differs from the (default) behavior of \code{\link{initializeCpp}}, which only loads slices of the matrix on request.
#'
#' @param x A \pkg{TileDBArray}-derived matrix or seed object.
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
loadIntoMemory <- function(x, num.threads=1) {
    if (is(x, "DelayedArray")) {
        x <- x@seed
    }
    if (x@sparse) {
        load_sparse(x@path, x@attr, cache_size=getAutoBlockSize(), num_threads=1)
    } else {
        load_dense(x@path, x@attr, cache_size=getAutoBlockSize(), num_threads=1)
    }
}

