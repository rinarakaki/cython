use libcpp::bool

extern from "<functional>" namespace "std" nogil:
    cdef cppclass function[T]:
        function() except +
        function(T*) except +
        function(function&) except +
        function(void*) except +

        fn function operator=(T*)
        fn function operator=(&mut function)
        fn function operator=(void*)
        fn function operator=[U](U)

        fn bool operator bool()

    # Comparisons
    cdef cppclass greater[T=*]:
        # https://github.com/cython/cython/issues/3193
        greater() except +
        fn bool operator()(&T lhs, &T rhs) except +

    cdef cppclass reference_wrapper[T]:
        reference_wrapper()
        reference_wrapper(T)
        fn &mut T get() const
