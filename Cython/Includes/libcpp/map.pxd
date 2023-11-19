use super::utility::pair

extern from "<map>" namespace "std" nogil:
    cdef cppclass map[T, U, COMPARE=*, ALLOCATOR=*]:
        ctypedef T key_type
        ctypedef U mapped_type
        ctypedef pair[const T, U] value_type
        ctypedef COMPARE key_compare
        ctypedef ALLOCATOR allocator_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            fn iterator(&mut iterator) except +
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            pair[T, U]& operator*()
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
            fn const_iterator(&mut iterator) except +
            fn const_iterator(&mut const_iterator) except +
            fn operator=(&mut iterator) except +
            # correct would be const value_type& but this does not work
            # well with cython's code gen
            const pair[T, U]& operator*()
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
            fn reverse_iterator(&mut reverse_iterator) except +
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            pair[T, U]& operator*()
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
            fn const_reverse_iterator(&mut reverse_iterator) except +
            fn operator=(&mut reverse_iterator) except +
            # correct would be const value_type& but this does not work
            # well with cython's code gen
            const pair[T, U]& operator*()
            const_reverse_iterator operator++()
            const_reverse_iterator operator--()
            const_reverse_iterator operator++(i32)
            const_reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)

        map() except +
        map(map&) except +
        # map(&mut key_compare)
        fn &mut U operator[](const T&)
        # fn &mut map operator=(&mut map)
        fn u2 operator==(&mut map, &mut map)
        fn u2 operator!=(&mut map, &mut map)
        fn u2 operator<(&mut map, &mut map)
        fn u2 operator>(&mut map, &mut map)
        fn u2 operator<=(&mut map, &mut map)
        fn u2 operator>=(&mut map, &mut map)
        fn &mut U at(const T&) except +
        const U& const_at "at"(const T&) except +
        iterator begin()
        const_iterator const_begin "begin" ()
        const_iterator cbegin()
        void clear()
        fn usize count(const T&)
        u2 empty()
        iterator end()
        const_iterator const_end "end" ()
        const_iterator cend()
        fn pair[iterator, iterator] equal_range(const T&)
        pair[const_iterator, const_iterator] const_equal_range "equal_range"(const T&)
        iterator erase(iterator)
        iterator const_erase "erase"(const_iterator)
        iterator erase(const_iterator, const_iterator)
        fn usize erase(const T&)
        fn iterator find(const T&)
        fn const_iterator const_find "find" (const T&)
        fn pair[iterator, u2] insert(const pair[T, U]&) except +
        fn iterator insert(const_iterator, const pair[T, U]&) except +
        void insert[InputIt](InputIt, InputIt) except +
        # key_compare key_comp()
        fn iterator lower_bound(const T&)
        fn const_iterator const_lower_bound "lower_bound"(const T&)
        usize max_size()
        reverse_iterator rbegin()
        const_reverse_iterator const_rbegin "rbegin"()
        const_reverse_iterator crbegin()
        reverse_iterator rend()
        const_reverse_iterator const_rend "rend"()
        const_reverse_iterator crend()
        usize size()
        fn void swap(&mut map)
        fn iterator upper_bound(const T&)
        fn const_iterator const_upper_bound "upper_bound"(const T&)
        # value_compare value_comp()
        # C++20
        fn u2 contains(const T&)

    cdef cppclass multimap[T, U, COMPARE=*, ALLOCATOR=*]:
        ctypedef T key_type
        ctypedef U mapped_type
        ctypedef pair[const T, U] value_type
        ctypedef COMPARE key_compare
        ctypedef ALLOCATOR allocator_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            fn iterator(&mut iterator) except +
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            pair[T, U]& operator*()
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
            fn const_iterator(&mut iterator) except +
            fn const_iterator(&mut const_iterator) except +
            fn operator=(&mut iterator) except +
            # correct would be const value_type& but this does not work
            # well with cython's code gen
            fn const pair[T, U]& operator*()
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
            fn reverse_iterator(&mut reverse_iterator) except +
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            pair[T, U]& operator*()
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
            fn const_reverse_iterator(&mut reverse_iterator) except +
            fn operator=(&mut reverse_iterator) except +
            # correct would be const value_type& but this does not work
            # well with cython's code gen
            const pair[T, U]& operator*()
            const_reverse_iterator operator++()
            const_reverse_iterator operator--()
            const_reverse_iterator operator++(i32)
            const_reverse_iterator operator--(i32)
            u2 operator==(reverse_iterator)
            u2 operator==(const_reverse_iterator)
            u2 operator!=(reverse_iterator)
            u2 operator!=(const_reverse_iterator)

        multimap() except +
        multimap(const multimap&) except +
        # fn multimap(&mut key_compare)
        # fn &mut multimap operator=(&mut multimap)
        u2 operator==(const multimap&, const multimap&)
        u2 operator!=(const multimap&, const multimap&)
        u2 operator<(const multimap&, const multimap&)
        u2 operator>(const multimap&, const multimap&)
        u2 operator<=(const multimap&, const multimap&)
        u2 operator>=(const multimap&, const multimap&)
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
        iterator insert(const pair[T, U]&) except +
        iterator insert(const_iterator, const pair[T, U]&) except +
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
        fn void swap(&mut multimap)
        iterator upper_bound(const T&)
        const_iterator const_upper_bound "upper_bound"(const T&)
        # value_compare value_comp()
        u2 contains(const T&)
