use super::utility::pair

extern from "<unordered_map>" namespace "std" nogil:
    cdef cppclass unordered_map[T, U, HASH=*, PRED=*, ALLOCATOR=*]:
        ctypedef T key_type
        ctypedef U mapped_type
        ctypedef pair[const T, U] value_type
        ctypedef ALLOCATOR allocator_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass iterator
        cppclass iterator:
            iterator() except +
            iterator(iterator&) except +
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn pair[T, U]& operator*()
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
            fn operator=(&mut iterator) except +
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn const pair[T, U]& operator*()
            fn const_iterator operator++()
            fn const_iterator operator--()
            fn const_iterator operator++(i32)
            fn const_iterator operator--(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)

        unordered_map() except +
        unordered_map(unordered_map&) except +
        # fn unordered_map(&mut key_compare)
        fn &mut U operator[](&T)
        # fn &mut unordered_map operator=(&mut unordered_map)
        fn u2 operator==(&mut unordered_map, &mut unordered_map)
        fn u2 operator!=(&mut unordered_map, &mut unordered_map)
        fn u2 operator<(&mut unordered_map, &mut unordered_map)
        fn u2 operator>(&mut unordered_map, &mut unordered_map)
        fn u2 operator<=(&mut unordered_map, &mut unordered_map)
        fn u2 operator>=(&mut unordered_map, &mut unordered_map)
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
        fn const_iterator const_find "find"(&T)
        fn pair[iterator, u2] insert(const pair[T, U]&) except +
        fn iterator insert(const_iterator, const pair[T, U]&) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        # fn key_compare key_comp()
        fn iterator lower_bound(&T)
        fn const_iterator const_lower_bound "lower_bound"(&T)
        fn usize max_size()
        fn usize size()
        fn void swap(&mut unordered_map)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # fn value_compare value_comp()
        fn void max_load_factor(f32)
        fn f32 max_load_factor()
        fn f32 load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(&T)
        # C++20
        fn u2 contains(&T)

    cdef cppclass unordered_multimap[T, U, HASH=*, PRED=*, ALLOCATOR=*]:
        ctypedef T key_type
        ctypedef U mapped_type
        ctypedef pair[const T, U] value_type
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
            # correct would be &mut value_type but this does not work
            # well with cython's code gen
            fn pair[T, U]& operator*()
            fn iterator operator++()
            fn iterator operator++(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            fn operator=(&mut iterator) except +
            # correct would be &value_type but this does not work
            # well with cython's code gen
            fn const pair[T, U]& operator*()
            fn const_iterator operator++()
            fn const_iterator operator++(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)

        unordered_multimap() except +
        unordered_multimap(const unordered_multimap&) except +
        # fn unordered_multimap(&mut key_compare)
        # fn &mut unordered_map operator=(&mut unordered_multimap)
        fn u2 operator==(&unordered_multimap, &unordered_multimap)
        fn u2 operator!=(&unordered_multimap, &unordered_multimap)
        fn u2 operator<(&unordered_multimap, &unordered_multimap)
        fn u2 operator>(&unordered_multimap, &unordered_multimap)
        fn u2 operator<=(&unordered_multimap, &unordered_multimap)
        fn u2 operator>=(&unordered_multimap, &unordered_multimap)
        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        # fn local_iterator begin(usize)
        # fn const_local_iterator const_begin "begin"(usize)
        fn void clear()
        fn usize count(&T)
        fn u2 empty()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        # fn local_iterator end(usize)
        # fn const_local_iterator const_end "end"(usize)
        fn pair[iterator, iterator] equal_range(&T)
        fn pair[const_iterator, const_iterator] const_equal_range "equal_range"(&T)
        fn iterator erase(iterator)
        fn iterator const_erase "erase"(const_iterator)
        fn iterator erase(const_iterator, const_iterator)
        fn usize erase(&T)
        fn iterator find(&T)
        fn const_iterator const_find "find"(&T)
        fn iterator insert(const pair[T, U]&) except +
        fn iterator insert(const_iterator, const pair[T, U]&) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        # fn key_compare key_comp()
        fn iterator lower_bound(&T)
        fn const_iterator const_lower_bound "lower_bound"(&T)
        fn usize max_size()
        fn usize size()
        fn void swap(&mut unordered_multimap)
        fn iterator upper_bound(&T)
        fn const_iterator const_upper_bound "upper_bound"(&T)
        # fn value_compare value_comp()
        fn void max_load_factor(f32)
        fn f32 max_load_factor()
        fn f32 load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(&T)
        # C++20
        fn u2 contains(&T)
