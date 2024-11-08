#' Options for TileDB matrices
#'
#' Options for initializing TileDB matrices in \code{\link[beachmat.tiledb]{initializeCpp}}.
#'
#' @param option String specifying the name of the option.
#' @param value Value of the option.
#'
#' @details
#' The following options are supported:
#' \itemize{
#' \item \code{realize}, a logical scalar specifying whether to load the matrix data from TileDB into memory with \code{\link{loadIntoMemory}},
#' and then cache it for future calls with \code{\link[beachmat]{checkMemoryCache}}. 
#' This avoids time-consuming disk I/O when performing multiple passes through the matrix, at the expense of increased memory usage.
#' \item \code{realize.num.threads}, an integer scalar specifying the number of threads to use for \code{\link{loadIntoMemory}}.
#' This is only relevant when \code{realize=TRUE}.
#' \item \code{concurrency.level}, an integer scalar specifying the number of threads to use within all calls to the TileDB library.
#' Alternatively \code{NULL}, in which case TileDB's defaults are used.
#' }
#'
#' @return If \code{value} is missing, the current setting of \code{option} is returned.
#'
#' If \code{value} is supplied, it is used to set the option, and the previous value of the option is invisibly returned.
#'
#' @author Aaron Lun
#' @examples
#' initializeOptions("realize")
#' old <- initializeOptions("realize", TRUE) # setting to a new value
#' initializeOptions("realize") # new option takes affect
#' initializeOptions("realize", old) # setting it back
#'
#' @export
#' @name initializeOptions
initializeOptions <- function(option, value) {
    old <- get(option, envir=cached.options, inherits=FALSE)
    if (missing(value)) {
        return(old)
    }
    assign(option, value, envir=cached.options)
    invisible(old)
}

cached.options <- new.env()
cached.options$realize <- FALSE
cached.options$realize.num.threads <- 1L
cached.options$concurrency.level <- NULL
