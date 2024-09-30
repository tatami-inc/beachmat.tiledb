#' Initialize TileDB-backed matrices
#'
#' Initialize C++ representations of TileDB-backed matrices based on their \pkg{TileDBArray} representations.
#'
#' @param x A \pkg{TileDBArray} seed object.
#' @param ... Further arguments, ignored.
#' @param memorize Logical scalar specifying whether to load the matrix data in \code{x} into memory, if it has not already been loaded.
#' See \code{\link{checkMemoryCache}} for details.
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
setMethod("initializeCpp", "TileDBArraySeed", function(x, ..., memorize=FALSE) {
    if (memorize) {
        checkMemoryCache("beachmat.tiledb", paste(x@path, x@attr, sep=":"), function() loadIntoMemory(x))
    } else {
        if (x@sparse) {
            initialize_from_tiledb_sparse(x@path, x@attr, cache_size=getAutoBlockSize())
        } else {
            initialize_from_tiledb_dense(x@path, x@attr, cache_size=getAutoBlockSize())
        }
    }
})
