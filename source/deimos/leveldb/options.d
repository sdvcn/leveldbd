module deimos.leveldb.options;


import deimos.leveldb.env;
import deimos.leveldb.db;
import deimos.leveldb.filter_policy;
import deimos.leveldb.cache;





extern(C++,struct)
extern(C++,`leveldb`):

enum CompressionType{
    kNoCompression = 0x00,
    kSnappyCompression = 0x01,
    kZlibCompression = 0x02,
}

struct Options{
    bool create_if_missing;
    bool error_if_exists;
    bool paranoid_checks;
    Env    env;
    Logger info_log;

    size_t write_buffer_size;
    int max_open_files;
    Cache block_cache;
    size_t block_size;
    int block_restart_interval;
    size_t max_file_size;
    CompressionType compression = CompressionType.kSnappyCompression;
    bool reuse_logs;
    FilterPolicy filter_policy;
}

struct ReadOptions
{
    bool verify_checksums;
    bool fill_cache;
    Snapshot snapshot;
}

struct WriteOptions
{
    bool sync;
}