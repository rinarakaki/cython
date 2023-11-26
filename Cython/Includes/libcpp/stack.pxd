extern from "<stack>" namespace "std" nogil:
    cdef cppclass stack[T]:
        type value_type = T
        stack() except +
        stack(stack&) except +
        # stack(Container&)
        fn u2 empty()
        fn void pop()
        fn void push(&mut T) except +
        fn usize size()
        fn &mut T top()
