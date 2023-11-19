use super::utility::pair

extern from "<set>" namespace "std" nogil:
    cdef cppclass set[T]:
        ctypedef T value_type

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
            fn const value_type& operator*()
            fn const_iterator operator++()
            fn const_iterator operator--()
            fn const_iterator operator++(i32)
            fn const_iterator operator--(i32)
            u2 operator==(iterator)
            u2 operator==(const_iterator)
            u2 operator!=(iterator)
            u2 operator!=(const_iterator)

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
            fn const value_type& operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)

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
        iterator begin()
        const_iterator const_begin "begin"()
        const_iterator cbegin()
        fn void clear()
        fn usize count(const T&)
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn pair[iterator, iterator] equal_range(const T&)
        fn pair[const_iterator, const_iterator] const_equal_range "equal_range"(const T&)
        fn iterator erase(iterator)
        fn iterator const_erase "erase"(const_iterator)
        fn iterator erase(const_iterator, const_iterator)
        fn usize erase(const T&)
        fn iterator find(const T&)
        fn const_iterator const_find "find"(const T&)
        fn pair[iterator, u2] insert(const T&) except +
        fn iterator insert(iterator, const T&) except +
        fn iterator insert(const_iterator, const T&) except +
        fn iterator const_insert "insert"(const_iterator, const T&) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        # key_compare key_comp()
        fn iterator lower_bound(const T&)
        fn const_iterator const_lower_bound "lower_bound"(const T&)
        fn usize max_size()
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        const_reverse_iterator crbegin()
        reverse_iterator rend()
        const_reverse_iterator const_rend "rend"()
        const_reverse_iterator crend()
        usize size()
        fn void swap(&mut set)
        iterator upper_bound(const T&)
        const_iterator const_upper_bound "upper_bound"(const T&)
        # value_compare value_comp()
        # C++20
        fn u2 contains(const T&)

    cdef cppclass multiset[T]:
        ctypedef T value_type

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
            const value_type& operator*()
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
            reverse_iterator(reverse_iterator&) except +
            fn &mut value_type operator*()
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
            fn operator=(&mut reverse_iterator) except +
            const value_type& operator*()
            const_reverse_iterator operator++()
            const_reverse_iterator operator--()
            const_reverse_iterator operator++(i32)
            const_reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)

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
        iterator begin()
        const_iterator const_begin "begin"()
        const_iterator cbegin()
        void clear()
        usize count(const T&)
        u2 empty()
        iterator end()
        const_iterator const_end "end"()
        const_iterator cend()
        pair[iterator, iterator] equal_range(const T&)
        pair[const_iterator, const_iterator] const_equal_range "equal_range"(const T&)
        iterator erase(iterator)
        iterator const_erase "erase"(const_iterator)
        iterator erase(const_iterator, const_iterator)
        usize erase(const T&)
        iterator find(const T&)
        const_iterator const_find "find"(const T&)
        iterator insert(const T&) except +
        iterator insert(iterator, const T&) except +
        iterator const_insert "insert"(const_iterator, const T&) except +
        void insert[InputIt](InputIt, InputIt) except +
        # key_compare key_comp()
        iterator lower_bound(const T&)
        const_iterator const_lower_bound "lower_bound"(const T&)
        usize max_size()
        reverse_iterator rbegin()
        const_reverse_iterator const_rbegin "rbegin"()
        const_reverse_iterator crbegin()
        reverse_iterator rend()
        const_reverse_iterator const_rend "rend"()
        const_reverse_iterator crend()
        usize size()
        fn void swap(&mut multiset)
        fn iterator upper_bound(const T&)
        fn const_iterator const_upper_bound "upper_bound"(const T&)
        # C++20
        fn u2 contains(const T&)
