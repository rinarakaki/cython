extern from "<queue>" namespace "std" nogil:
    cdef cppclass queue[T]:
        queue() except +
        fn queue(&mut queue) except +
        # queue(&mut Container)
        fn &mut T back()
        u2 empty()
        fn &mut T front()
        void pop()
        fn void push(&mut T)
        usize size()
        # C++11 methods
        fn void swap(&mut queue)

    cdef cppclass priority_queue[T]:
        priority_queue() except +
        fn priority_queue(&mut priority_queue) except +
        # priority_queue(&mut Container)
        u2 empty()
        void pop()
        fn void push(&mut T)
        usize size()
        fn &mut T top()
        # C++11 methods
        fn void swap(&mut priority_queue)
