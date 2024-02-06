module deimos.leveldb.env;

import deimos.leveldb.status;
import deimos.leveldb.slice;

import std.stdint:uint64_t;

extern(C++,struct)
extern(C++,`leveldb`):
class Env {
    ~this();
}

abstract class SequentialFile
{
    ~this();
    abstract Status Read(size_t n, Slice result, char* scratch);
    abstract Status Skip(uint64_t n);
}

class RandomAccessFile
{
    ~this();
    abstract Status Read(uint64_t offset, size_t n, Slice result, char* scratch);
}

class WritableFile
{
    ~this();
    abstract Status Append(ref Slice data);
    abstract Status Close();
    abstract Status Flush();
    abstract Status Sync();    
}

abstract class Logger{
    ~this();
    void Logv(const char* format, void*);
}

abstract class FileLock
{
    ~this();
}