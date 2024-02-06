module deimos.leveldb.status;




extern(C++,`leveldb`):

extern(C++,class)
struct Status
{
    enum Code{
        kOk = 0,
        kNotFound = 1,
        kCorruption = 2,
        kNotSupported = 3,
        kInvalidArgument = 4,
        kIOError = 5
    }
    const char* state_;

    Code code()
    {
        return (state_ is null)?Code.kOk:cast(Code)(state_[4]);
    }
}