extern from "<forward_list>" namespace "std" nogil:
    cdef cppclass forward_list[T,ALLOCATOR=*]:
        ctypedef T value_type
        ctypedef ALLOCATOR allocator_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass iterator:
            iterator()
            iterator(iterator &)
            fn &mut T operator*()
            fn iterator operator++()
            fn iterator operator++(i32)
            fn u2 operator==(iterator)
            fn u2 operator!=(iterator)
        cppclass const_iterator(iterator):
            pass
        forward_list() except +
        forward_list(forward_list&) except +
        forward_list(usize, T&) except +
        # fn &mut forward_list operator=(&mut forward_list)
        fn u2 operator==(&mut forward_list, &mut forward_list)
        fn u2 operator!=(&mut forward_list, &mut forward_list)
        fn u2 operator<(&mut forward_list, &mut forward_list)
        fn u2 operator>(&mut forward_list, &mut forward_list)
        fn u2 operator<=(&mut forward_list, &mut forward_list)
        fn u2 operator>=(&mut forward_list, &mut forward_list)
        fn void assign(usize, &mut T)
        fn &mut T front()
        fn iterator before_begin()
        fn const_iterator const_before_begin "before_begin"()
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn u2 empty()
        fn usize max_size()
        fn void clear()
        fn iterator insert_after(iterator, &mut T)
        fn void insert_after(iterator, usize, &mut T)
        fn iterator erase_after(iterator)
        fn iterator erase_after(iterator, iterator)
        fn void push_front(&mut T)
        fn void pop_front()
        fn void resize(usize)
        fn void resize(usize, &mut T)
        fn void swap(&mut forward_list)
        fn void merge(&mut forward_list)
        fn void merge[Compare](&mut forward_list, Compare)
        fn void splice_after(iterator, &mut forward_list)
        fn void splice_after(iterator, &mut forward_list, iterator)
        fn void splice_after(iterator, &mut forward_list, iterator, iterator)
        fn void remove(&T)
        fn void remove_if[Predicate](Predicate)
        fn void reverse()
        fn void unique()
        fn void unique[Predicate](Predicate)
        fn void sort()
        fn void sort[Compare](Compare)
