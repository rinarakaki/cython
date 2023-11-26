use super::utility::pair

extern from "<map>" namespace "std" nogil:
    cdef cppclass map[T, U, COMPARE=*, ALLOCATOR=*]:
        type key_type = T
        type mapped_type = U
        type value_type = pair[const T, U]
        type key_compare = COMPARE
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
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn &mut pair[T, U] operator*()
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
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn &pair[T, U] operator*()
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
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn &mut pair[T, U] operator*()
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
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn &pair[T, U] operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)

        map() except +
        map(map&) except +
        # map(&mut key_compare)
        fn &mut U operator[](&T)
        # fn &mut map operator=(&mut map)
        fn u2 operator==(&mut map, &mut map)
        fn u2 operator!=(&mut map, &mut map)
        fn u2 operator<(&mut map, &mut map)
        fn u2 operator>(&mut map, &mut map)
        fn u2 operator<=(&mut map, &mut map)
        fn u2 operator>=(&mut map, &mut map)
        fn &mut U at(&T) except +
        fn &U const_at "at"(&T) except +
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
        fn const_iterator const_find "find" (&T)
        fn pair[iterator, u2] insert(&pair[T, U]) except +
        fn iterator insert(const_iterator, &pair[T, U]) except +
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
        fn void swap(&mut map)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # fn value_compare value_comp()
        # C++20
        fn u2 contains(&T)

    cdef cppclass multimap[T, U, COMPARE=*, ALLOCATOR=*]:
        type key_type = T
        type mapped_type = U
        type value_type = pair[const T, U]
        type key_compare = COMPARE
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
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn &mut pair[T, U] operator*()
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
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn &pair[T, U] operator*()
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
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn &mut pair[T, U] operator*()
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
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn &pair[T, U] operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)

        multimap() except +
        multimap(const multimap&) except +
        # fn multimap(&mut key_compare)
        # fn &mut multimap operator=(&mut multimap)
        fn u2 operator==(&multimap, &multimap)
        fn u2 operator!=(&multimap, &multimap)
        fn u2 operator<(&multimap, &multimap)
        fn u2 operator>(&multimap, &multimap)
        fn u2 operator<=(&multimap, &multimap)
        fn u2 operator>=(&multimap, &multimap)
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
        fn iterator insert(&pair[T, U]) except +
        fn iterator insert(const_iterator, &pair[T, U]) except +
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
        fn void swap(&mut multimap)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # fn value_compare value_comp()
        fn u2 contains(&T)
