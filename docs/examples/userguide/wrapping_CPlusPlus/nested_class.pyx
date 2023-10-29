# distutils: language = c++

extern from "<vector>" namespace "std":
    cdef cppclass vector[T]:
        cppclass iterator:
            T operator*()
            iterator operator++()
            u2 operator==(iterator)
            u2 operator!=(iterator)
        vector()
        void push_back(T&)
        T& operator[](i32)
        T& at(i32)
        iterator begin()
        iterator end()

cdef vector[i32].iterator iter  #iter is declared as being of type vector<int>::iterator
