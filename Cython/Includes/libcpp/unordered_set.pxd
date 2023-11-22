use super::utility::pair

extern from "<unordered_set>" namespace "std" nogil:
    cdef cppclass unordered_set[T,HASH=*,PRED=*,ALLOCATOR=*]:
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

        unordered_set() except +
        unordered_set(unordered_set&) except +
        # fn &mut unordered_set operator=(&mut unordered_set)
        fn u2 operator==(&mut unordered_set, &mut unordered_set)
        fn u2 operator!=(&mut unordered_set, &mut unordered_set)
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
        fn iterator insert(const_iterator, &T) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        fn usize max_size()
        fn usize size()
        fn void swap(&mut unordered_set)
        # fn value_compare value_comp()
        fn void max_load_factor(float)
        fn float max_load_factor()
        fn float load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(&T)
        # C++20
        fn u2 contains(&T)

    cdef cppclass unordered_multiset[T,HASH=*,PRED=*,ALLOCATOR=*]:
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
            fn iterator operator++(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            fn operator=(&mut iterator) except +
            fn &value_type operator*()
            fn const_iterator operator++()
            fn const_iterator operator++(i32)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)

        unordered_multiset() except +
        unordered_multiset(unordered_multiset&) except +
        # fn &mut unordered_multiset operator=(&mut unordered_multiset)
        fn u2 operator==(&mut unordered_multiset, &mut unordered_multiset)
        fn u2 operator!=(&mut unordered_multiset, &mut unordered_multiset)
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
        fn iterator insert(const_iterator, &T) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        fn usize max_size()
        fn usize size()
        fn void swap(&mut unordered_multiset)
        # fn value_compare value_comp()
        fn void max_load_factor(float)
        fn float max_load_factor()
        fn float load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(&T)
        # C++20
        fn u2 contains(&T)
