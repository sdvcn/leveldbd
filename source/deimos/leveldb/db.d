module deimos.leveldb.db;

import deimos.leveldb.slice;
import deimos.leveldb.status;
import deimos.leveldb.options;
import deimos.leveldb.write_batch;
import deimos.leveldb.iterator;


import std.stdint:uint64_t;

import core.stdcpp.string:basic_string;




alias std_string = basic_string!char;

struct ty1{
    DB mmdb;
}

unittest
{
    import core.stdcpp.new_;
    import std.logger:info;
    DB mdb;
    auto pmdb = &mdb;
    
    /*
    std_string name = "testdb";
    Options options;
    options.create_if_missing = true;
    
    auto s = DB.Open(options,name, pmdb);

    info("Open status: ", s);

    */

}







extern(C++,`leveldb`):

extern(C++,class)
class Snapshot{
    // ~this();
}

extern(C++,struct)
struct Range
{
    Slice start;
    Slice limit;
    this(Slice s, Slice l) { start = s; limit = l; }
    /*
    this(ref Slice start, ref Slice limit)
    {
        this.start = start;
        this.limit = limit;
    }
    */
}

extern(C++,class)
abstract class DB
{
    ~this();
    export static Status Open(ref const Options,ref const std_string,DB*);
}

/*
extern(C++,class)
class DB{
    this();
    ~this();
    export static Status Open(ref const Options,ref const std_string,DB*);

    
    abstract Status Put(const WriteOptions,const Slice,const Slice);
    abstract Status Delete(const WriteOptions,const Slice);
    abstract Status Write(const WriteOptions,ref WriteBatch);
    abstract Status Get(const ReadOptions,const Slice,ref Slice);
    abstract Iterator* NewIterator(const ReadOptions);
    abstract const Snapshot* GetSnapshot();
    abstract void ReleaseSnapshot(const Snapshot*);
    abstract bool GetProperty(const Slice,ref std_string);
    abstract void GetApproximateSizes(const Range*,int n,ref uint64_t sizes);
    abstract Status CompactRange(const Slice* start,const Slice* limit);

}
*/
Status DestroyDB(const std_string name,const Options options);
Status RepairDB(const std_string name,const Options options);