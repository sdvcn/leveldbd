module deimos.leveldb.write_batch;

import deimos.leveldb.slice;

extern(C++,struct)
extern(C++,`leveldb`):

abstract class WriteBatch
{
    abstract class Handler{
        ~this();
        void Put(ref Slice key, ref Slice value);
        void Delete(ref Slice key);
    }
    this();
}

