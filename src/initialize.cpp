#include "Rcpp.h"
#include "Rtatami.h"
#include "tatami_tiledb/tatami_tiledb.hpp"
#include <string>

//[[Rcpp::export(rng=false)]]
SEXP initialize_from_tiledb_sparse(std::string file, std::string attribute, int cache_size) {
    tatami_tiledb::SparseMatrixOptions opt;
    opt.maximum_cache_size = cache_size;
    auto output = Rtatami::new_BoundNumericMatrix();
    output->ptr.reset(new tatami_tiledb::SparseMatrix<double, int>(file, std::move(attribute), opt));
    return output;
}

//[[Rcpp::export(rng=false)]]
SEXP initialize_from_tiledb_dense(std::string file, std::string attribute, int cache_size) {
    tatami_tiledb::DenseMatrixOptions opt;
    opt.maximum_cache_size = cache_size;
    auto output = Rtatami::new_BoundNumericMatrix();
    output->ptr.reset(new tatami_tiledb::DenseMatrix<double, int>(file, std::move(attribute), opt));
    return output;
}
