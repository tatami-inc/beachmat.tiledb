// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// initialize_from_tiledb_sparse
SEXP initialize_from_tiledb_sparse(std::string file, std::string attribute, int cache_size);
RcppExport SEXP _beachmat_tiledb_initialize_from_tiledb_sparse(SEXP fileSEXP, SEXP attributeSEXP, SEXP cache_sizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< std::string >::type file(fileSEXP);
    Rcpp::traits::input_parameter< std::string >::type attribute(attributeSEXP);
    Rcpp::traits::input_parameter< int >::type cache_size(cache_sizeSEXP);
    rcpp_result_gen = Rcpp::wrap(initialize_from_tiledb_sparse(file, attribute, cache_size));
    return rcpp_result_gen;
END_RCPP
}
// initialize_from_tiledb_dense
SEXP initialize_from_tiledb_dense(std::string file, std::string attribute, int cache_size);
RcppExport SEXP _beachmat_tiledb_initialize_from_tiledb_dense(SEXP fileSEXP, SEXP attributeSEXP, SEXP cache_sizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< std::string >::type file(fileSEXP);
    Rcpp::traits::input_parameter< std::string >::type attribute(attributeSEXP);
    Rcpp::traits::input_parameter< int >::type cache_size(cache_sizeSEXP);
    rcpp_result_gen = Rcpp::wrap(initialize_from_tiledb_dense(file, attribute, cache_size));
    return rcpp_result_gen;
END_RCPP
}
// load_dense
SEXP load_dense(std::string uri, std::string attribute, int cache_size, int num_threads);
RcppExport SEXP _beachmat_tiledb_load_dense(SEXP uriSEXP, SEXP attributeSEXP, SEXP cache_sizeSEXP, SEXP num_threadsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< std::string >::type uri(uriSEXP);
    Rcpp::traits::input_parameter< std::string >::type attribute(attributeSEXP);
    Rcpp::traits::input_parameter< int >::type cache_size(cache_sizeSEXP);
    Rcpp::traits::input_parameter< int >::type num_threads(num_threadsSEXP);
    rcpp_result_gen = Rcpp::wrap(load_dense(uri, attribute, cache_size, num_threads));
    return rcpp_result_gen;
END_RCPP
}
// load_sparse
SEXP load_sparse(std::string uri, std::string attribute, int cache_size, int num_threads);
RcppExport SEXP _beachmat_tiledb_load_sparse(SEXP uriSEXP, SEXP attributeSEXP, SEXP cache_sizeSEXP, SEXP num_threadsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< std::string >::type uri(uriSEXP);
    Rcpp::traits::input_parameter< std::string >::type attribute(attributeSEXP);
    Rcpp::traits::input_parameter< int >::type cache_size(cache_sizeSEXP);
    Rcpp::traits::input_parameter< int >::type num_threads(num_threadsSEXP);
    rcpp_result_gen = Rcpp::wrap(load_sparse(uri, attribute, cache_size, num_threads));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_beachmat_tiledb_initialize_from_tiledb_sparse", (DL_FUNC) &_beachmat_tiledb_initialize_from_tiledb_sparse, 3},
    {"_beachmat_tiledb_initialize_from_tiledb_dense", (DL_FUNC) &_beachmat_tiledb_initialize_from_tiledb_dense, 3},
    {"_beachmat_tiledb_load_dense", (DL_FUNC) &_beachmat_tiledb_load_dense, 4},
    {"_beachmat_tiledb_load_sparse", (DL_FUNC) &_beachmat_tiledb_load_sparse, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_beachmat_tiledb(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
