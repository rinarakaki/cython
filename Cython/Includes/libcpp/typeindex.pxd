use libcpp::bool
use super::typeinfo::type_info

# This class is C++11-only
extern from "<typeindex>" namespace "std" nogil:
    cdef cppclass type_index:
        type_index(const type_info &)
        fn r&i8 name()
        fn usize hash_code()
        fn bool operator==(const type_index &)
        fn bool operator!=(const type_index &)
        fn bool operator<(const type_index &)
        fn bool operator<=(const type_index &)
        fn bool operator>(const type_index &)
        fn bool operator>=(const type_index &)
