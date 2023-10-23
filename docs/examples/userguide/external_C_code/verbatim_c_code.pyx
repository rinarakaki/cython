cdef extern from *:
    """
    /* This is C code which will be put
     * in the .c file output by Cython */
    static long square(long x) {return x * x;}
    #define assign(x, y) ((x) = (y))
    """
    i64 square(i64 x)

    void assign(i64& x, i64 y)
