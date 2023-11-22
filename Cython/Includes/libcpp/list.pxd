extern from "<list>" namespace "std" nogil:
    cdef cppclass list[T,ALLOCATOR=*]:
        ctypedef T value_type
        ctypedef ALLOCATOR allocator_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            iterator(iterator&) except +
            fn &mut value_type operator*()
            fn iterator operator++()
            fn iterator operator--()
            fn iterator operator++(i32)
            fn iterator operator--(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            const_iterator(const_iterator&) except +
            fn operator=(&mut iterator) except +
            fn &value_type operator*()
            fn const_iterator operator++()
            fn const_iterator operator--()
            fn const_iterator operator++(i32)
            fn const_iterator operator--(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)

        cppclass const_reverse_iterator
        cppclass reverse_iterator:
            reverse_iterator() except +
            reverse_iterator(reverse_iterator&) except +
            fn &mut value_type operator*()
            fn reverse_iterator operator++()
            fn reverse_iterator operator--()
            fn reverse_iterator operator++(i32)
            fn reverse_iterator operator--(i32)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)
        cppclass const_reverse_iterator:
            const_reverse_iterator() except +
            const_reverse_iterator(reverse_iterator&) except +
            fn operator=(&mut reverse_iterator) except +
            fn &value_type operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)

        list() except +
        list(list&) except +
        list(usize, T&) except +
        # list operator=(&mut list)
        fn u2 operator==(&mut list, &mut list)
        fn u2 operator!=(&mut list, &mut list)
        fn u2 operator<(&mut list, &mut list)
        fn u2 operator>(&mut list, &mut list)
        fn u2 operator<=(&mut list, &mut list)
        fn u2 operator>=(&mut list, &mut list)
        fn void assign(usize, &mut T) except +
        fn &mut T back()
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn iterator erase(iterator)
        fn iterator erase(iterator, iterator)
        fn &mut T front()
        fn iterator insert(iterator, &mut T)
        fn void insert(iterator, usize, &mut T)
        fn usize max_size()
        fn void merge(&mut list) except +
        # fn void merge(&mut list, BinPred)
        fn void pop_back()
        fn void pop_front()
        fn void push_back(&mut T) except +
        fn void push_front(&mut T) except +
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        fn const_reverse_iterator crbegin()
        fn void remove(&mut T) except +
        # fn void remove_if(UnPred)
        fn reverse_iterator rend()
        fn const_reverse_iterator const_rend "rend"()
        fn const_reverse_iterator crend()
        fn void resize(usize, &mut T) except +
        fn void reverse()
        fn usize size()
        fn void sort() except +
        # fn void sort(BinPred)
        fn void splice(iterator, &mut list)
        fn void splice(iterator, &mut list, iterator)
        fn void splice(iterator, &mut list, iterator, iterator)
        fn void swap(&mut list)
        fn void unique()
        # fn void unique(BinPred)
