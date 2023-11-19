use libcpp::bool
use libcpp::typeinfo::type_info

extern from "<any>" namespace "std" nogil:
    cdef cppclass any:
        any()
        any(any&) except +
        fn void reset()
        fn bool has_value()
        fn &mut type_info type()
        fn &mut T emplace[T](...) except +
        fn void swap(&mut any)
        fn &mut any operator=(&mut any) except +
        fn &mut any operator=[U](&mut U) except +

    fn T any_cast[T](&mut any) except +
