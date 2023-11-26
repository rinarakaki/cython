use super::utility::pair

extern from "<set>" namespace "std" nogil:
    cdef cppclass set[T]:
        type value_type = T

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

        set() except +
        set(set&) except +
        # set(&mut key_compare)
        # fn &mut set operator=(&mut set)
        fn u2 operator==(&mut set, &mut set)
        fn u2 operator!=(&mut set, &mut set)
        fn u2 operator<(&mut set, &mut set)
        fn u2 operator>(&mut set, &mut set)
        fn u2 operator<=(&mut set, &mut set)
        fn u2 operator>=(&mut set, &mut set)
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn usize count(&T)
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn pair[iterator, iterator] equal_range(&T)
        fn pair[const_iterator, const_iterator] const_equal_range "equal_range"(&T)
        fn iterator erase(iterator)
        fn iterator const_erase "erase"(const_iterator)
        fn iterator erase(const_iterator, const_iterator)
        fn usize erase(&T)
        fn iterator find(&T)
        fn const_iterator const_find "find"(&T)
        fn pair[iterator, u2] insert(&T) except +
        fn iterator insert(iterator, &T) except +
        fn iterator insert(const_iterator, &T) except +
        fn iterator const_insert "insert"(const_iterator, &T) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        # fn key_compare key_comp()
        fn iterator lower_bound(&T)
        fn const_iterator const_lower_bound "lower_bound"(&T)
        fn usize max_size()
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        fn const_reverse_iterator crbegin()
        fn reverse_iterator rend()
        fn const_reverse_iterator const_rend "rend"()
        fn const_reverse_iterator crend()
        fn usize size()
        fn void swap(&mut set)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # fn value_compare value_comp()
        # C++20
        fn u2 contains(&T)

    cdef cppclass multiset[T]:
        type value_type = T

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

        multiset() except +
        multiset(multiset&) except +
        # multiset(&mut key_compare)
        # fn &mut multiset operator=(&mut multiset)
        fn u2 operator==(&mut multiset, &mut multiset)
        fn u2 operator!=(&mut multiset, &mut multiset)
        fn u2 operator<(&mut multiset, &mut multiset)
        fn u2 operator>(&mut multiset, &mut multiset)
        fn u2 operator<=(&mut multiset, &mut multiset)
        fn u2 operator>=(&mut multiset, &mut multiset)
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn usize count(&T)
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn pair[iterator, iterator] equal_range(&T)
        fn pair[const_iterator, const_iterator] const_equal_range "equal_range"(&T)
        fn iterator erase(iterator)
        fn iterator const_erase "erase"(const_iterator)
        fn iterator erase(const_iterator, const_iterator)
        fn usize erase(&T)
        fn iterator find(&T)
        fn const_iterator const_find "find"(&T)
        fn iterator insert(&T) except +
        fn iterator insert(iterator, &T) except +
        fn iterator const_insert "insert"(const_iterator, &T) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        # key_compare key_comp()
        fn iterator lower_bound(&T)
        fn const_iterator const_lower_bound "lower_bound"(&T)
        fn usize max_size()
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        fn const_reverse_iterator crbegin()
        fn reverse_iterator rend()
        fn const_reverse_iterator const_rend "rend"()
        fn const_reverse_iterator crend()
        fn usize size()
        fn void swap(&mut multiset)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # C++20
        fn u2 contains(&T)
