# distutils: language = c++

extern from "<vector>" namespace "std":
    cdef cppclass vector[T]:
        cppclass iterator:
            fn T operator*()
            fn iterator operator++()
            fn bint operator==(iterator)
            fn bint operator!=(iterator)
        vector()
        fn void push_back(T&)
        fn T& operator[](i32)
        fn T& at(i32)
        fn iterator begin()
        fn iterator end()

cdef vector[i32].iterator iter  #iter is declared as being of type vector<int>::iterator
