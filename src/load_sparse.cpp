#include "Rtatami.h"
#include "tatami_tiledb/tatami_tiledb.hpp"
#include <tiledb/tiledb.h>
#include <string>
#include <cstdint>

template<typename StoredIndex_>
std::shared_ptr<tatami::Matrix<double, int> > create_sparse(const tatami::Matrix<double, int>& source, tiledb_datatype_t attr_type, int num_threads) {
    std::shared_ptr<tatami::Matrix<double, int> > output;

    switch (attr_type) {
        case TILEDB_UINT8:   output = tatami::convert_to_compressed_sparse<double, int, uint8_t , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_INT8:    output = tatami::convert_to_compressed_sparse<double, int, int8_t  , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_UINT16:  output = tatami::convert_to_compressed_sparse<double, int, uint16_t, StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_INT16:   output = tatami::convert_to_compressed_sparse<double, int, int16_t , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_UINT32:  output = tatami::convert_to_compressed_sparse<double, int, uint32_t, StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_INT32:   output = tatami::convert_to_compressed_sparse<double, int, int32_t , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        case TILEDB_FLOAT32: output = tatami::convert_to_compressed_sparse<double, int, float   , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
        default:             output = tatami::convert_to_compressed_sparse<double, int, double  , StoredIndex_>(&source, source.prefer_rows(), /* two_pass = */ true, num_threads); break;
    }

    return output;
}

//[[Rcpp::export(rng=false)]]
SEXP load_sparse(std::string uri, std::string attribute, int cache_size, int num_threads, int concurrency_level) {
    tiledb::Context ctx;
    tiledb::Array arr(ctx, uri, TILEDB_READ);
    auto schema = arr.schema();
    auto attr = schema.attribute(attribute);
    auto attr_type = attr.type();

    tatami_tiledb::SparseMatrixOptions opt;
    opt.maximum_cache_size = cache_size;

    tiledb::Config config;
    if (concurrency_level > 0) {
        config["sm.compute_concurrency_level"] = concurrency_level;
    }

    tatami_tiledb::SparseMatrix<double, int> source(uri, std::move(attribute), tiledb::Context(config), opt);

    auto output = Rtatami::new_BoundNumericMatrix();
    int non_target_dim = (source.prefer_rows() ? source.ncol() : source.nrow());
    if (non_target_dim <= 65535) {
        output->ptr = create_sparse<uint16_t>(source, attr_type, num_threads);
    } else {
        output->ptr = create_sparse<int>(source, attr_type, num_threads);
    }

    return output;
}
