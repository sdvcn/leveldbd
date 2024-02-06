module deimos.leveldb.slice;

import core.stdc.string;

import core.stdcpp.string;

alias std_string = basic_string!char;


unittest
{
    import std.logger;
    import core.stdcpp.new_;

    Slice s123 = cpp_new!Slice("ca123");

    info("s123.data() = ", s123.size());
}


extern(C++,struct)
extern(C++,`leveldb`):
class Slice{
    this()
    {
        data_ = "";
        size_ = 0;
    }
    this(const char* data, size_t size)
    {
        data_ = data;
        size_ = size;
    }

    this(const char* data)
    {
        data_ = data;
        size_ = strlen(data);
    }

    this(ref std_string str)
    {
        data_ = str.data();
        size_ = str.size();
    }
    extern(D)
    this(string ss1)
    {
        this.data_ = ss1.ptr;
        this.size_ = ss1.length;
    }

    bool empty() const
    {
        return size_ == 0;
    }

    auto data() 
    {
        return data_;
    }

    size_t size() const
    {
        return size_;
    }

    void clear()
    {
        data_ = "";
        size_ = 0;
    }

    int compare(ref Slice b) const
    {
        const size_t min_len = (size_ < b.size_)? size_ : b.size_;
        int r = memcmp(data_, b.data_, min_len);
        if (r == 0)
            r = (size_ < b.size_)? -1 : (size_ > b.size_)? 1 : 0;
        return r;
    }

    private:
        const(char)* data_;
        size_t size_;
}

