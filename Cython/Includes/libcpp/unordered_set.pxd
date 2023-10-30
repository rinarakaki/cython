from .utility cimport pair

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
            value_type& operator*()
            iterator operator++()
            iterator operator--()
            iterator operator++(i32)
            iterator operator--(i32)
            fn bint operator==(iterator)
            fn bint operator==(const_iterator)
            fn bint operator!=(iterator)
            fn bint operator!=(const_iterator)
        cppclass const_iterator:
            fn const_iterator() except +
            fn const_iterator(iterator&) except +
            operator=(iterator&) except +
            fn const value_type& operator*()
            fn const_iterator operator++()
            fn const_iterator operator--()
            fn const_iterator operator++(i32)
            fn const_iterator operator--(i32)
            fn bint operator==(iterator)
            fn bint operator==(const_iterator)
            fn bint operator!=(iterator)
            fn bint operator!=(const_iterator)

        unordered_set() except +
        unordered_set(unordered_set&) except +
        #unordered_set& operator=(unordered_set&)
        fn bint operator==(unordered_set&, unordered_set&)
        fn bint operator!=(unordered_set&, unordered_set&)
        iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn usize count(const T&)
        fn bint empty()
        iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        pair[iterator, iterator] equal_range(const T&)
        pair[const_iterator, const_iterator] const_equal_range "equal_range"(const T&)
        iterator erase(iterator)
        iterator const_erase "erase"(const_iterator)
        iterator erase(const_iterator, const_iterator)
        fn usize erase(const T&)
        iterator find(const T&)
        fn const_iterator const_find "find"(const T&)
        pair[iterator, bint] insert(const T&) except +
        iterator insert(const_iterator, const T&) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        fn usize max_size()
        fn usize size()
        fn void swap(unordered_set&)
        # value_compare value_comp()
        fn void max_load_factor(float)
        fn float max_load_factor()
        fn float load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(const T&)
        # C++20
        fn bint contains(const T&)

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
            value_type& operator*()
            iterator operator++()
            iterator operator++(i32)
            fn bint operator==(iterator)
            fn bint operator==(const_iterator)
            fn bint operator!=(iterator)
            fn bint operator!=(const_iterator)
        cppclass const_iterator:
            fn const_iterator() except +
            fn const_iterator(iterator&) except +
            operator=(iterator&) except +
            fn const value_type& operator*()
            fn const_iterator operator++()
            fn const_iterator operator++(i32)
            fn bint operator==(iterator)
            fn bint operator==(const_iterator)
            fn bint operator!=(iterator)
            fn bint operator!=(const_iterator)

        unordered_multiset() except +
        unordered_multiset(unordered_multiset&) except +
        # unordered_multiset& operator=(unordered_multiset&)
        fn bint operator==(unordered_multiset&, unordered_multiset&)
        fn bint operator!=(unordered_multiset&, unordered_multiset&)
        iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn void clear()
        fn usize count(const T&)
        fn bint empty()
        iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        pair[iterator, iterator] equal_range(const T&)
        pair[const_iterator, const_iterator] const_equal_range "equal_range"(const T&)
        iterator erase(iterator)
        iterator const_erase "erase"(const_iterator)
        iterator erase(const_iterator, const_iterator)
        fn usize erase(const T&)
        iterator find(const T&)
        fn const_iterator const_find "find"(const T&)
        iterator insert(const T&) except +
        iterator insert(const_iterator, const T&) except +
        fn void insert[InputIt](InputIt, InputIt) except +
        fn usize max_size()
        fn usize size()
        fn void swap(unordered_multiset&)
        # value_compare value_comp()
        fn void max_load_factor(float)
        fn float max_load_factor()
        fn float load_factor()
        fn void rehash(usize)
        fn void reserve(usize)
        fn usize bucket_count()
        fn usize max_bucket_count()
        fn usize bucket_size(usize)
        fn usize bucket(const T&)
        # C++20
        fn bint contains(const T&)
