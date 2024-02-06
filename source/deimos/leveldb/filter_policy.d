module deimos.leveldb.filter_policy;

import deimos.leveldb.slice;

import core.stdcpp.string;

alias std_string = basic_string!char;

extern(C++,struct)
extern(C++,`leveldb`):

/*
class FilterPolicy
{
    ~this();
    abstract const char* Name();
    //CreateFilter
}
*/

abstract class FilterPolicy{
    ~this();
    const char* Name();
    void CreateFilter(ref Slice key,int n,std_string dst) const;
    bool KeyMayMatch(ref Slice key,ref Slice filter) const;
}



FilterPolicy NewBloomFilterPolicy(int bits_per_key);