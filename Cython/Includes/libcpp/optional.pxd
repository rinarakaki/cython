use libcpp::bool

extern from "<optional>" namespace "std" nogil:
    cdef cppclass nullopt_t:
        nullopt_t()

    cdef nullopt_t nullopt

    cdef cppclass optional[T]:
        ctypedef T value_type
        optional()
        optional(nullopt_t)
        optional(optional&) except +
        optional(T&) except +
        bool has_value()
        fn &mut T value()
        fn &mut T value_or[U](&mut U default_value)
        fn void swap(&mut optional)
        void reset()
        fn &mut T emplace(...)
        fn &mut T operator*()
        # T* operator->() # Not Supported
        fn &mut optional operator=(&mut optional)
        fn &mut optional operator=[U](&mut U)
        bool operator bool()
        bool operator!()
        fn bool operator==[U](&mut optional, &mut U)
        fn bool operator!=[U](&mut optional, &mut U)
        fn bool operator<[U](&mut optional, &mut U)
        fn bool operator>[U](&mut optional, &mut U)
        fn bool operator<=[U](&mut optional, &mut U)
        fn bool operator>=[U](&mut optional, &mut U)

    optional[T] make_optional[T](...) except +
