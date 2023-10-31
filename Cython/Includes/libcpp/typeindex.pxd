from libcpp cimport bool
from .typeinfo cimport type_info

# This class is C++11-only
extern from "<typeindex>" namespace "std" nogil:
    cdef cppclass type_index:
        type_index(const type_info &)
        fn const char* name()
        fn usize hash_code()
        fn bool operator==(const type_index &)
        fn bool operator!=(const type_index &)
        fn bool operator<(const type_index &)
        fn bool operator<=(const type_index &)
        fn bool operator>(const type_index &)
        fn bool operator>=(const type_index &)
