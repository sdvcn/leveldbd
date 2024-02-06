module deimos.leveldb.c;

import std.stdint:uint8_t,uint64_t;

/*
import deimos.leveldb.db;
import deimos.leveldb.iterator;
import deimos.leveldb.options;
import deimos.leveldb.write_batch;
import deimos.leveldb.cache;
import deimos.leveldb.env;
*/



extern (C):

struct leveldb_t;    // leveldb_t;
struct leveldb_cache_t;    // leveldb_cache_t;
struct leveldb_comparator_t;    // leveldb_comparator_t;
struct leveldb_env_t;    // leveldb_env_t;
struct leveldb_filelock_t;    // leveldb_filelock_t;
struct leveldb_filterpolicy_t;    // leveldb_filterpolicy_t;
struct leveldb_iterator_t;    // leveldb_iterator_t;
struct leveldb_logger_t;    // leveldb_logger_t;
struct leveldb_options_t;    // leveldb_options_t;
struct leveldb_randomfile_t;    // leveldb_randomfile_t;
struct leveldb_readoptions_t;    // leveldb_readoptions_t;
struct leveldb_seqfile_t;    // leveldb_seqfile_t;
struct leveldb_snapshot_t;    // leveldb_snapshot_t;
struct leveldb_writablefile_t;    // leveldb_writablefile_t;
struct leveldb_writebatch_t;    // leveldb_writebatch_t;
struct leveldb_writeoptions_t;    // leveldb_writeoptions_t;

/*
struct leveldb_t{
    DB rep;
}

struct leveldb_cache_t {
  Cache rep;
}

struct leveldb_comparator_t {
    void* state_;
}

struct leveldb_env_t {
  Env rep;
  bool is_default;
}

struct leveldb_filelock_t {
  FileLock rep;
}

struct leveldb_filterpolicy_t {
    void* state_;
}

struct leveldb_iterator_t {
  Iterator rep;
}

struct leveldb_writebatch_t {
  WriteBatch rep;
}
struct leveldb_snapshot_t {
  const Snapshot rep;
}
struct leveldb_readoptions_t {
  ReadOptions rep;
}
struct leveldb_writeoptions_t {
  WriteOptions rep;
}
struct leveldb_options_t {
  Options rep;
}

struct leveldb_seqfile_t {
  SequentialFile rep;
}
struct leveldb_randomfile_t {
  RandomAccessFile rep;
}
struct leveldb_writablefile_t {
  WritableFile rep;
}
struct leveldb_logger_t {
  Logger rep;
}
*/

export leveldb_t* leveldb_open(const leveldb_options_t* options,
    const(char*) name, char** errptr);

export void leveldb_close(leveldb_t* db);

export void leveldb_put(leveldb_t* db,
    const leveldb_writeoptions_t* options,
    const(char*) key, size_t keylen, const(char*) val,
    size_t vallen, char** errptr);

export void leveldb_delete(leveldb_t* db,
    const leveldb_writeoptions_t* options,
    const(char*) key, size_t keylen,
    char** errptr);

export void leveldb_write(leveldb_t* db,
    const leveldb_writeoptions_t* options,
    leveldb_writebatch_t* batch, char** errptr);

/* Returns NULL if not found.  A malloc()ed array otherwise.
   Stores the length of the array in *vallen. */
export char* leveldb_get(leveldb_t* db,
    const leveldb_readoptions_t* options,
    const(char*) key, size_t keylen, size_t* vallen,
    char** errptr);

export leveldb_iterator_t* leveldb_create_iterator(
    leveldb_t* db, const leveldb_readoptions_t* options);

export const (leveldb_snapshot_t*) leveldb_create_snapshot(leveldb_t* db);

export void leveldb_release_snapshot(
    leveldb_t* db, const leveldb_snapshot_t* snapshot);

/* Returns NULL if property name is unknown.
   Else returns a pointer to a malloc()-ed null-terminated value. */
export char* leveldb_property_value(leveldb_t* db,
    const(char*) propname);

export void leveldb_approximate_sizes(
    leveldb_t * db,
    int num_ranges, 
    const const(char)* range_start_key,const size_t * range_start_key_len, 
    const const(char)* range_limit_key,const size_t * range_limit_key_len, 
    uint64_t * sizes);

export void leveldb_compact_range(leveldb_t* db, const(char*) start_key,
    size_t start_key_len,
    const(char*) limit_key,
    size_t limit_key_len);

/* Management operations */

export void leveldb_destroy_db(const leveldb_options_t* options,
    const(char*) name, char** errptr);

export void leveldb_repair_db(const leveldb_options_t* options,
    const(char*) name, char** errptr);

/* Iterator */

export void leveldb_iter_destroy(leveldb_iterator_t*);
export uint8_t leveldb_iter_valid(const leveldb_iterator_t*);
export void leveldb_iter_seek_to_first(leveldb_iterator_t*);
export void leveldb_iter_seek_to_last(leveldb_iterator_t*);
export void leveldb_iter_seek(leveldb_iterator_t*, const(char*) k,
    size_t klen);
export void leveldb_iter_next(leveldb_iterator_t*);
export void leveldb_iter_prev(leveldb_iterator_t*);
export const(char*) leveldb_iter_key(const leveldb_iterator_t*,
    size_t* klen);
export const(char*) leveldb_iter_value(const leveldb_iterator_t*,
    size_t* vlen);
export void leveldb_iter_get_error(const leveldb_iterator_t*,
    char** errptr);

/* Write batch */

export leveldb_writebatch_t* leveldb_writebatch_create();
export void leveldb_writebatch_destroy(leveldb_writebatch_t*);
export void leveldb_writebatch_clear(leveldb_writebatch_t*);
export void leveldb_writebatch_put(leveldb_writebatch_t*,
    const(char*) key, size_t klen,
    const(char*) val, size_t vlen);
export void leveldb_writebatch_delete(leveldb_writebatch_t*,
    const(char*) key, size_t klen);
export void leveldb_writebatch_iterate(
    const leveldb_writebatch_t * , 
    void* state,
    void function(void*, const(char*) k, size_t klen, const(char*) v, size_t vlen) put,
    void function(void*, const(char*) k, size_t klen) deleted);
export void leveldb_writebatch_append(
    leveldb_writebatch_t* destination, const leveldb_writebatch_t* source);

/* Options */

export leveldb_options_t* leveldb_options_create();
export void leveldb_options_destroy(leveldb_options_t*);
export void leveldb_options_set_comparator(leveldb_options_t*,
    leveldb_comparator_t*);
export void leveldb_options_set_filter_policy(leveldb_options_t*,
    leveldb_filterpolicy_t*);
export void leveldb_options_set_create_if_missing(leveldb_options_t*,
    uint8_t);
export void leveldb_options_set_error_if_exists(leveldb_options_t*,
    uint8_t);
export void leveldb_options_set_paranoid_checks(leveldb_options_t*,
    uint8_t);
export void leveldb_options_set_env(leveldb_options_t*, leveldb_env_t*);
export void leveldb_options_set_info_log(leveldb_options_t*,
    leveldb_logger_t*);
export void leveldb_options_set_write_buffer_size(leveldb_options_t*,
    size_t);
export void leveldb_options_set_max_open_files(leveldb_options_t*, int);
export void leveldb_options_set_cache(leveldb_options_t*,
    leveldb_cache_t*);
export void leveldb_options_set_block_size(leveldb_options_t*, size_t);
export void leveldb_options_set_block_restart_interval(
    leveldb_options_t*, int);
export void leveldb_options_set_max_file_size(leveldb_options_t*,
    size_t);

enum
{
    leveldb_no_compression = 0,
    leveldb_snappy_compression = 1
};
export void leveldb_options_set_compression(leveldb_options_t*, int);

/* Comparator */

export leveldb_comparator_t * leveldb_comparator_create(
    void* state, 
    void function(void*) destructor,
    int function(
        void*,
        const(char*) a, size_t alen,
        const(char*) b, size_t blen) compare,
    const(char*) function(void*) name);
export void leveldb_comparator_destroy(leveldb_comparator_t*);

/* Filter policy */

export leveldb_filterpolicy_t * leveldb_filterpolicy_create(
    void* state, 
    void function(void*) destructor,
    char* function(
        void*,
        const const(char)* key_array, const size_t* key_length_array,
        int num_keys,
        size_t* filter_length) create_filter,
    ubyte function(
        void*,
        const(char*) key, size_t length,
        const(char*) filter, size_t filter_length) key_may_match,
    const(char*) function(void*) name);
export void leveldb_filterpolicy_destroy(leveldb_filterpolicy_t*);

export leveldb_filterpolicy_t* leveldb_filterpolicy_create_bloom(
    int bits_per_key);

/* Read options */

export leveldb_readoptions_t* leveldb_readoptions_create();
export void leveldb_readoptions_destroy(leveldb_readoptions_t*);
export void leveldb_readoptions_set_verify_checksums(
    leveldb_readoptions_t*, uint8_t);
export void leveldb_readoptions_set_fill_cache(leveldb_readoptions_t*,
    uint8_t);
export void leveldb_readoptions_set_snapshot(leveldb_readoptions_t*,
    const leveldb_snapshot_t*);

/* Write options */

export leveldb_writeoptions_t* leveldb_writeoptions_create();
export void leveldb_writeoptions_destroy(leveldb_writeoptions_t*);
export void leveldb_writeoptions_set_sync(leveldb_writeoptions_t*,
    uint8_t);

/* Cache */

export leveldb_cache_t* leveldb_cache_create_lru(size_t capacity);
export void leveldb_cache_destroy(leveldb_cache_t* cache);

/* Env */

export leveldb_env_t* leveldb_create_default_env();
export void leveldb_env_destroy(leveldb_env_t*);

/* If not NULL, the returned buffer must be released using leveldb_free(). */
export char* leveldb_env_get_test_directory(leveldb_env_t*);

/* Utility */

/* Calls free(ptr).
   REQUIRES: ptr was malloc()-ed and returned by one of the routines
   in this file.  Note that in certain cases (typically on Windows), you
   may need to call this routine instead of free(ptr) to dispose of
   malloc()-ed memory returned by this library. */
export void leveldb_free(void* ptr);

/* Return the major version number for this release. */
export int leveldb_major_version();

/* Return the minor version number for this release. */
export int leveldb_minor_version();
