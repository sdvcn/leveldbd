module deimos.leveldb.comparator;

import deimos.leveldb.slice;

import core.stdcpp.string;

alias std_string = basic_string!char;


extern(C++,struct)
extern(C++,`leveldb`):

abstract class Comparator{
    ~this();
    int Compare(ref Slice a, ref Slice b);
    const char* Name();
    void FindShortestSeparator(std_string start, ref Slice limit);
    void FindShortSuccessor(std_string key);
}

Comparator BytewiseComparator();