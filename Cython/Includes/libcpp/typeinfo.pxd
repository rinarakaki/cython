use libcpp::bool

extern from "<typeinfo>" namespace "std" nogil:
    cdef cppclass type_info:
        fn r&i8 name()
        fn i32 before(&type_info)
        fn bool operator==(&type_info)
        fn bool operator!=(&type_info)
        # C++11-only
        fn usize hash_code()
