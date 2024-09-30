#' Initialize TileDB-backed matrices
#'
#' Initialize C++ representations of TileDB-backed matrices based on their \pkg{TileDBArray} representations.
#'
#' @param x A \pkg{TileDBArray} seed object.
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
#' @import methods
#' @rdname initializeCpp
#' @importFrom TileDBArray TileDBArraySeed
#' @importFrom beachmat initializeCpp
#' @importFrom Rcpp sourceCpp
#' @useDynLib beachmat.tiledb
#' @importFrom DelayedArray getAutoBlockSize
setMethod("initializeCpp", "TileDBArraySeed", function(x, ...) {
    if (x@sparse) {
        initialize_from_tiledb_sparse(x@path, x@attr, cache_size=getAutoBlockSize())
    } else {
        initialize_from_tiledb_dense(x@path, x@attr, cache_size=getAutoBlockSize())
    }
})
