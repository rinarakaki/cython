from libcpp cimport bool

extern from "<typeinfo>" namespace "std" nogil:
    cdef cppclass type_info:
        fn const char* name()
        fn i32 before(const type_info&)
        fn bool operator==(const type_info&)
        fn bool operator!=(const type_info&)
        # C++11-only
        fn usize hash_code()
