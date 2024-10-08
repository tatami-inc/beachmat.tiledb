% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/initializeCpp.R
\name{initializeCpp}
\alias{initializeCpp}
\alias{initializeCpp,TileDBArraySeed-method}
\title{Initialize TileDB-backed matrices}
\usage{
\S4method{initializeCpp}{TileDBArraySeed}(x, ..., memorize = FALSE)
}
\arguments{
\item{x}{A \pkg{TileDBArray} seed object.}

\item{...}{Further arguments, ignored.}

\item{memorize}{Logical scalar specifying whether to load the matrix data in \code{x} into memory, if it has not already been loaded.
See \code{\link{checkMemoryCache}} for details.}
}
\value{
An external pointer that can be used in any \pkg{tatami}-compatible function.
}
\description{
Initialize C++ representations of TileDB-backed matrices based on their \pkg{TileDBArray} representations.
}
\examples{
library(TileDBArray)
y <- matrix(runif(1000), ncol=20, nrow=50)
z <- as(y, "TileDBArray")
ptr <- initializeCpp(z)

}
\author{
Aaron Lun
}
