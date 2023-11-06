# tag: cpp
# mode: compile

extern from "cpp_nogil.h" nogil:
    cdef cppclass NoGilTest1:
        NoGilTest1()
        fn void do_something()

# This is declared in cpp_nogil.h, but here we're testing
# that we can put nogil directly on the cppclass.
extern from *:
    cdef cppclass NoGilTest2 nogil:
        NoGilTest2()
        void do_something()

with nogil:
    NoGilTest1().do_something()
    NoGilTest2().do_something()

# We can override nogil methods as with gil methods.
cdef cppclass WithGilSubclass(NoGilTest1):
    fn void do_something() noexcept with gil:
        print "have the gil"
