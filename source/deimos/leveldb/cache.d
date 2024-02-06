module deimos.leveldb.cache;

import core.stdcpp.string;

alias std_string = basic_string!char;


extern(C++,struct)
extern(C++,`leveldb`):

abstract class Cache{
    ~this();
    
}