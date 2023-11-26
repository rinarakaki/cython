extern from "<deque>" namespace "std" nogil:
    cdef cppclass deque[T,ALLOCATOR=*]:
        type value_type = T
        type allocator_type = ALLOCATOR

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        type size_type = usize
        type difference_type = ptrdiff_t

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            iterator(iterator&) except +
            fn &mut value_type operator*()
            fn iterator operator++()
            fn iterator operator--()
            fn iterator operator++(i32)
            fn iterator operator--(i32)
            fn iterator operator+(size_type)
            fn iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
            fn u2 operator<(iterator)
            fn u2 operator<(const_iterator)
            fn u2 operator>(iterator)
            fn u2 operator>(const_iterator)
            fn u2 operator<=(iterator)
            fn u2 operator<=(const_iterator)
            fn u2 operator>=(iterator)
            fn u2 operator>=(const_iterator)
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
            fn const_iterator operator+(size_type)
            fn const_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
            fn u2 operator<(iterator)
            fn u2 operator<(const_iterator)
            fn u2 operator>(iterator)
            fn u2 operator>(const_iterator)
            fn u2 operator<=(iterator)
            fn u2 operator<=(const_iterator)
            fn u2 operator>=(iterator)
            fn u2 operator>=(const_iterator)

        cppclass const_reverse_iterator
        cppclass reverse_iterator:
            reverse_iterator() except +
            reverse_iterator(reverse_iterator&) except +
            fn &mut value_type operator*()
            fn reverse_iterator operator++()
            fn reverse_iterator operator--()
            fn reverse_iterator operator++(i32)
            fn reverse_iterator operator--(i32)
            fn reverse_iterator operator+(size_type)
            fn reverse_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)
            fn u2 operator<(reverse_iterator)
            fn u2 operator<(const_reverse_iterator)
            fn u2 operator>(reverse_iterator)
            fn u2 operator>(const_reverse_iterator)
            fn u2 operator<=(reverse_iterator)
            fn u2 operator<=(const_reverse_iterator)
            fn u2 operator>=(reverse_iterator)
            fn u2 operator>=(const_reverse_iterator)
        cppclass const_reverse_iterator:
            const_reverse_iterator() except +
            const_reverse_iterator(reverse_iterator&) except +
            fn operator=(&mut reverse_iterator) except +
            fn &value_type operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            fn const_reverse_iterator operator+(size_type)
            fn const_reverse_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)
            fn u2 operator<(reverse_iterator)
            fn u2 operator<(const_reverse_iterator)
            fn u2 operator>(reverse_iterator)
            fn u2 operator>(const_reverse_iterator)
            fn u2 operator<=(reverse_iterator)
            fn u2 operator<=(const_reverse_iterator)
            fn u2 operator>=(reverse_iterator)
            fn u2 operator>=(const_reverse_iterator)

        deque() except +
        deque(deque&) except +
        deque(usize) except +
        deque(usize, T&) except +
        # deque[InputIt](InputIt, InputIt)
        fn &mut T operator[](usize)
        # fn &mut deque operator=(&mut deque)
        fn u2 operator==(&mut deque, &mut deque)
        fn u2 operator!=(&mut deque, &mut deque)
        fn u2 operator<(&mut deque, &mut deque)
        fn u2 operator>(&mut deque, &mut deque)
        fn u2 operator<=(&mut deque, &mut deque)
        fn u2 operator>=(&mut deque, &mut deque)
        fn void assign(usize, &mut T) except +
        fn void assign[InputIt](InputIt, InputIt) except +
        fn &mut T at(usize) except +
        fn &mut T back()
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn iterator erase(iterator) except +
        fn iterator erase(iterator, iterator) except +
        fn &mut T front()
        fn iterator insert(iterator, &mut T) except +
        fn void insert(iterator, usize, &mut T) except +
        fn void insert[InputIt](iterator, InputIt, InputIt) except +
        fn usize max_size()
        fn void pop_back()
        fn void pop_front()
        fn void push_back(&mut T) except +
        fn void push_front(&mut T) except +
        fn reverse_iterator rbegin()
        # fn const_reverse_iterator rbegin()
        fn const_reverse_iterator crbegin()
        fn reverse_iterator rend()
        # fn const_reverse_iterator rend()
        fn const_reverse_iterator crend()
        fn void resize(usize) except +
        fn void resize(usize, &mut T) except +
        fn usize size()
        fn void swap(&mut deque)

        # C++11 methods
        fn void shrink_to_fit() except +
