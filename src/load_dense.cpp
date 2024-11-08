#include "Rtatami.h"
#include "tatami_tiledb/tatami_tiledb.hpp"
#include <tiledb/tiledb.h>
#include <string>
#include <cstdint>

//[[Rcpp::export(rng=false)]]
SEXP load_dense(std::string uri, std::string attribute, int cache_size, int num_threads, int concurrency_level) {
    tiledb::Context ctx;
    tiledb::Array arr(ctx, uri, TILEDB_READ);
    auto schema = arr.schema();
    auto attr = schema.attribute(attribute);
    auto attr_type = attr.type();

    tatami_tiledb::DenseMatrixOptions opt;
    opt.maximum_cache_size = cache_size;

    tiledb::Config config;
    if (concurrency_level > 0) {
        config["sm.compute_concurrency_level"] = concurrency_level;
    }

    tatami_tiledb::DenseMatrix<double, int> source(uri, std::move(attribute), tiledb::Context(config), opt);

    // TODO: better way of respecting the tile extent. This should be achievable by making
    // tatami_chunked use actual Matrix objects in their internal structure.
    auto output = Rtatami::new_BoundNumericMatrix();
    switch (attr_type) {
        case TILEDB_UINT8:   output->ptr = tatami::convert_to_dense<double, int, uint8_t >(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_INT8:    output->ptr = tatami::convert_to_dense<double, int, int8_t  >(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_UINT16:  output->ptr = tatami::convert_to_dense<double, int, uint16_t>(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_INT16:   output->ptr = tatami::convert_to_dense<double, int, int16_t >(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_UINT32:  output->ptr = tatami::convert_to_dense<double, int, uint32_t>(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_INT32:   output->ptr = tatami::convert_to_dense<double, int, int32_t >(&source, source.prefer_rows(), num_threads); break;
        case TILEDB_FLOAT32: output->ptr = tatami::convert_to_dense<double, int, float   >(&source, source.prefer_rows(), num_threads); break;
        default:             output->ptr = tatami::convert_to_dense<double, int, double  >(&source, source.prefer_rows(), num_threads); break;
    }

    return output;
}
