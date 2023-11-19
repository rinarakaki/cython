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
            iterator operator++()
            iterator operator++(i32)
            u2 operator==(iterator)
            u2 operator!=(iterator)
        cppclass const_iterator(iterator):
            pass
        forward_list() except +
        forward_list(forward_list&) except +
        forward_list(usize, T&) except +
        # &mut forward_list operator=(&mut forward_list)
        fn u2 operator==(&mut forward_list, &mut forward_list)
        fn u2 operator!=(&mut forward_list, &mut forward_list)
        fn u2 operator<(&mut forward_list, &mut forward_list)
        fn u2 operator>(&mut forward_list, &mut forward_list)
        fn u2 operator<=(&mut forward_list, &mut forward_list)
        fn u2 operator>=(&mut forward_list, &mut forward_list)
        fn void assign(usize, &mut T)
        fn &mut T front()
        iterator before_begin()
        const_iterator const_before_begin "before_begin"()
        iterator begin()
        const_iterator const_begin "begin"()
        iterator end()
        const_iterator const_end "end"()
        u2 empty()
        usize max_size()
        void clear()
        fn iterator insert_after(iterator, &mut T)
        fn void insert_after(iterator, usize, &mut T)
        iterator erase_after(iterator)
        iterator erase_after(iterator, iterator)
        fn void push_front(&mut T)
        void pop_front()
        void resize(usize)
        fn void resize(usize, &mut T)
        fn void swap(&mut forward_list)
        fn void merge(&mut forward_list)
        fn void merge[Compare](&mut forward_list, Compare)
        fn void splice_after(iterator, &mut forward_list)
        fn void splice_after(iterator, &mut forward_list, iterator)
        fn void splice_after(iterator, &mut forward_list, iterator, iterator)
        fn void remove(const T&)
        void remove_if[Predicate](Predicate)
        void reverse()
        void unique()
        void unique[Predicate](Predicate)
        void sort()
        void sort[Compare](Compare)
