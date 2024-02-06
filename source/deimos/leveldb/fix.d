module deimos.leveldb.fix;

import deimos.leveldb.c;
import deimos.leveldb.db;


package:
/*
//extern(C)
struct leveldb_t
{
    ~this()
    {
        //leveldb_close(cast(void*)&this);
    }

}
*/
unittest
{
    import std.logger;
    import core.stdcpp.new_;

    info("Running leveldb fix unittest");

    infof("leveldb version %s.%s",leveldb_major_version(),leveldb_minor_version());

    //auto mdb cpp_new!DB();
    DB mdb = cpp_new!DB();

    

    mdb.destroy();
    
}