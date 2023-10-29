extern from "<stack>" namespace "std" nogil:
    cdef cppclass stack[T]:
        ctypedef T value_type
        stack() except +
        stack(stack&) except +
        #stack(Container&)
        u2 empty()
        void pop()
        void push(T&) except +
        usize size()
        T& top()
