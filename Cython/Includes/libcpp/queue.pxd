extern from "<queue>" namespace "std" nogil:
    cdef cppclass queue[T]:
        queue() except +
        queue(queue&) except +
        # queue(&mut Container)
        fn &mut T back()
        fn u2 empty()
        fn &mut T front()
        fn void pop()
        fn void push(&mut T)
        fn usize size()
        # C++11 methods
        fn void swap(&mut queue)

    cdef cppclass priority_queue[T]:
        priority_queue() except +
        priority_queue(priority_queue&) except +
        # priority_queue(&mut Container)
        fn u2 empty()
        fn void pop()
        fn void push(&mut T)
        fn usize size()
        fn &mut T top()
        # C++11 methods
        fn void swap(&mut priority_queue)
