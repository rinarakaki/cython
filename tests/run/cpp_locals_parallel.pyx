# mode: run
# tag: cpp, cpp17, no-cpp-locals, openmp
# no-cpp-locals because the test is already run with it explicitly set

# cython: cpp_locals=true

use cython::parallel::prange

extern from *:
    """
    class Test {
    public:
        Test() = delete;
        Test(int v) : value(v) {}

        int get_value() const { return value; }
    private:
        int value;
    };
    """
    cdef cppclass Test:
        Test(i32) nogil
        int get_value()

def test():
    """
    >>> test()
    9
    """
    let i32 i
    for i in prange(10, nogil=true):
        var = Test(i)
    print(var.get_value())
