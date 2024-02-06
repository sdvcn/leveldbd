module deimos.leveldb.slice;

import core.stdc.string;

import core.stdcpp.string;

alias std_string = basic_string!char;


unittest
{
    import std.logger;
    import core.stdcpp.new_;

    //Slice s123 = cpp_new!Slice("ca123");
    Slice s123 = Slice("123");
    Slice v123 = Slice("123");
    Slice f123 = Slice("423");

    auto v1 = (s123 == v123);
    auto v2 = (s123 == f123);

    assert(s123 == v123);
    assert(!(s123 == f123));
}


/*
auto opUnary(string op)(ref Slice x,ref Slice y) if(op=="==")
{
    return (x.size() == y.size()) && 
    (memcmp(x.data(),y.data(),x.size()) == 0);
}

auto opUnary(string op)(ref Slice x,ref Slice y) if(op=="!=")
{
    return !(x == y);
}

*/
extern(C++,`leveldb`):

extern(C++,class)
struct Slice{
    this(const char* data, size_t size)
    {
        data_ = data;
        size_ = size;
    }

    this(ref std_string str)
    {
        data_ = str.data();
        size_ = str.size();
    }

    this(const char* data)
    {
        data_ = data;
        size_ = strlen(data);
    }

    this(ref Slice x)
    {
        data_ = x.data_;
        size_ = x.size_;
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
    
    /*   
    std_string ToString()
    {
        std_string vs123;
        vs123.data() = data_;
        vs123.size() = size_;
        //return std_string(data_,size_);
        return v;
    }

    */
    



    int compare(ref Slice b) const
    {
        const size_t min_len = (size_ < b.size_)? size_ : b.size_;
        int r = memcmp(data_, b.data_, min_len);
        if (r == 0)
            r = (size_ < b.size_)? -1 : (size_ > b.size_)? 1 : 0;
        return r;
    }

    bool starts_with(ref Slice x)
    {
        return (
            (this.size_ >= x.size_) && 
            (memcmp(this.data_,x.data_,x.size_) == 0)
            );
    }

    extern(D)
    this(string ss1)
    {
        this.data_ = ss1.ptr;
        this.size_ = ss1.length;
    }

    extern(D)
    string toString() //const @safe pure nothrow
    {
        struct node{
            size_t length;
            const(char)* ptr;
        };

        auto sv = data_[0..size_];
        return cast(string)sv;
    }

    //extern(D)
    auto opIndex(size_t n)
    in(n<size())
    {
        return data_[n];
    }
    
    bool opEquals(ref Slice y)
    {
        return (this.size() == y.size()) && 
        (memcmp(this.data(),y.data(),this.size()) == 0);
    }

    private:
        const(char)* data_;
        size_t size_;
}

