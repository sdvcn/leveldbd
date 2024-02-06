module deimos.leveldb.db;

import deimos.leveldb.slice;
import deimos.leveldb.status;
import deimos.leveldb.options;




import core.stdcpp.string;
import std.compiler;

//leveldb::Slice::Slice(std::basic_string<char,std::char_traits<char>,std::allocator<char>> const &)	00000000000055E0	


alias std_string = basic_string!char;

extern(C++,struct)
extern(C++,`leveldb`):


class Snapshot{
    //abstract  ~this();
}

struct Range
{
    Slice start;
    Slice limit;
}

class DB{
    this();
    ~this();
    // leveldb::DB::Open(leveldb::Options const &,std::basic_string<char,std::char_traits<char>,std::allocator<char>> const &,leveldb::DB * *)	000000000000B788	

    //leveldb::DB::Open1(leveldb::Options &, std::basic_string<char,std::char_traits<char>, std::allocator<char> > &,struct leveldb::DB * *)
    export static Status Open(const ref Options,ref std_string name,DB* dbptr);
    
    

}