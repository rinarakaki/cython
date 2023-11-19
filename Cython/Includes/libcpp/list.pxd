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
            iterator operator++()
            iterator operator--()
            iterator operator++(i32)
            iterator operator--(i32)
            u2 operator==(iterator)
            u2 operator==(const_iterator)
            u2 operator!=(iterator)
            u2 operator!=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            const_iterator(const_iterator&) except +
            fn operator=(&mut iterator) except +
            fn const value_type& operator*()
            const_iterator operator++()
            const_iterator operator--()
            const_iterator operator++(i32)
            const_iterator operator--(i32)
            u2 operator==(iterator)
            u2 operator==(const_iterator)
            u2 operator!=(iterator)
            u2 operator!=(const_iterator)

        cppclass const_reverse_iterator
        cppclass reverse_iterator:
            reverse_iterator() except +
            reverse_iterator(&mut reverse_iterator) except +
            &mut value_type operator*()
            reverse_iterator operator++()
            reverse_iterator operator--()
            reverse_iterator operator++(i32)
            reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)
        cppclass const_reverse_iterator:
            const_reverse_iterator() except +
            const_reverse_iterator(reverse_iterator&) except +
            operator=(&mut reverse_iterator) except +
            const value_type& operator*()
            const_reverse_iterator operator++()
            const_reverse_iterator operator--()
            const_reverse_iterator operator++(i32)
            const_reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)

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
        iterator begin()
        const_iterator const_begin "begin"()
        const_iterator cbegin()
        void clear()
        u2 empty()
        iterator end()
        const_iterator const_end "end"()
        const_iterator cend()
        iterator erase(iterator)
        iterator erase(iterator, iterator)
        fn &mut T front()
        fn iterator insert(iterator, &mut T)
        fn void insert(iterator, usize, &mut T)
        usize max_size()
        void merge(&mut list) except +
        # void merge(&mut list, BinPred)
        void pop_back()
        void pop_front()
        fn void push_back(&mut T) except +
        fn void push_front(&mut T) except +
        reverse_iterator rbegin()
        const_reverse_iterator const_rbegin "rbegin"()
        const_reverse_iterator crbegin()
        fn void remove(&mut T) except +
        # void remove_if(UnPred)
        reverse_iterator rend()
        const_reverse_iterator const_rend "rend"()
        const_reverse_iterator crend()
        fn void resize(usize, &mut T) except +
        void reverse()
        usize size()
        void sort() except +
        # void sort(BinPred)
        fn void splice(iterator, &mut list)
        fn void splice(iterator, &mut list, iterator)
        fn void splice(iterator, &mut list, iterator, iterator)
        fn void swap(&mut list)
        fn void unique()
        # void unique(BinPred)
