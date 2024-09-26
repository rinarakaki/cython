extern from "<vector>" namespace "std" nogil:
    cdef cppclass vector[T, ALLOCATOR=*]:
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
            fn &mut T operator*()
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
            fn &T operator*()
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
            fn &mut T operator*()
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
            fn &T operator*()
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

        vector() except +
        vector(vector&) except +
        vector(size_type) except +
        vector(size_type, T&) except +
        # vector[InputIt](InputIt, InputIt)
        fn &mut T operator[](size_type)
        # fn &mut vector operator=(&mut vector)
        fn u2 operator==(&mut vector, &mut vector)
        fn u2 operator!=(&mut vector, &mut vector)
        fn u2 operator<(&mut vector, &mut vector)
        fn u2 operator>(&mut vector, &mut vector)
        fn u2 operator<=(&mut vector, &mut vector)
        fn u2 operator>=(&mut vector, &mut vector)
        fn void assign(size_type, &T)
        fn void assign[InputIt](InputIt, InputIt) except +
        fn &mut T at(size_type) except +
        fn &mut T back()
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn size_type capacity()
        fn void clear()
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn iterator erase(iterator)
        fn iterator erase(iterator, iterator)
        fn &mut T front()
        fn iterator insert(iterator, &T) except +
        fn iterator insert(iterator, size_type, &T) except +
        fn iterator insert[InputIt](iterator, InputIt, InputIt) except +
        fn size_type max_size()
        fn void pop_back()
        fn void push_back(&mut T) except +
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        fn const_reverse_iterator crbegin()
        fn reverse_iterator rend()
        fn const_reverse_iterator const_rend "rend"()
        fn const_reverse_iterator crend()
        fn void reserve(size_type) except +
        fn void resize(size_type) except +
        fn void resize(size_type, &mut T) except +
        fn size_type size()
        fn void swap(&mut vector)

        # C++11 methods
        fn T* data()
        fn const T* const_data "data"()
        fn void shrink_to_fit() except +
        fn iterator emplace(const_iterator, ...) except +
        fn &mut T emplace_back(...) except +
