use libcpp::(bool, nullptr_t, nullptr)

extern from "<memory>" namespace "std" nogil:
    cdef cppclass default_delete[T]:
        default_delete()

    cdef cppclass allocator[T]:
        allocator()
        allocator(&allocator)
        # allocator(const allocator[U] &)  # unique_ptr unit tests fail w/this
        fn T* address(T &)
        fn const T* address(&T) const
        fn T* allocate(usize n) # Not to standard.  should be a second default argument
        fn void deallocate(T *, usize)
        fn usize max_size() const
        fn void construct(T *, &T)  # C++98.  The C++11 version is variadic AND perfect-forwarding
        fn void destroy(T *)  # C++98
        fn void destroy[U](U *)  # unique_ptr unit tests fail w/this


    cdef cppclass unique_ptr[T,DELETER=*]:
        unique_ptr()
        unique_ptr(nullptr_t)
        unique_ptr(T*)
        unique_ptr(unique_ptr[T]&)

        # Modifiers
        fn T* release()
        fn void reset()
        fn void reset(nullptr_t)
        fn void reset(T*)
        fn void swap(&mut unique_ptr)

        # Observers
        fn T* get()
        fn &mut T operator*()
        # T* operator->() # Not Supported
        fn bool operator bool()
        fn bool operator!()

        fn bool operator==(&unique_ptr)
        fn bool operator!=(&unique_ptr)
        fn bool operator<(&unique_ptr)
        fn bool operator>(&unique_ptr)
        fn bool operator<=(&unique_ptr)
        fn bool operator>=(&unique_ptr)

        fn fn bool operator==(nullptr_t)
        fn bool operator!=(nullptr_t)

    # Forward Declaration not working ("Compiler crash in AnalyseDeclarationsTransform")
    # cdef cppclass weak_ptr[T]

    cdef cppclass shared_ptr[T]:
        shared_ptr()
        shared_ptr(nullptr_t)
        shared_ptr(T*)
        shared_ptr(shared_ptr[T]&)
        shared_ptr(shared_ptr[T]&, T*)
        shared_ptr(unique_ptr[T]&)
        # shared_ptr(weak_ptr[T]&) # Not Supported
        fn shared_ptr[T]& operator=[Y](const shared_ptr[Y]& ptr)

        # Modifiers
        fn void reset()
        fn void reset(T*)
        fn void swap(&mut shared_ptr)

        # Observers
        fn T* get()
        fn &mut T operator*()
        # T* operator->() # Not Supported
        fn long use_count()
        fn bool unique()
        fn bool operator bool()
        fn bool operator!()
        # fn bool owner_before[Y](const weak_ptr[Y]&) # Not Supported
        fn bool owner_before[Y](const shared_ptr[Y]&)

        fn bool operator==(&shared_ptr)
        fn bool operator!=(&shared_ptr)
        fn bool operator<(&shared_ptr)
        fn bool operator>(&shared_ptr)
        fn bool operator<=(&shared_ptr)
        fn bool operator>=(&shared_ptr)

        fn bool operator==(nullptr_t)
        fn bool operator!=(nullptr_t)

    cdef cppclass weak_ptr[T]:
        weak_ptr()
        weak_ptr(weak_ptr[T]&)
        weak_ptr(shared_ptr[T]&)

        # Modifiers
        fn void reset()
        fn void swap(&mut weak_ptr)

        # Observers
        fn i64 use_count()
        fn bool expired()
        fn shared_ptr[T] lock()
        fn bool owner_before[Y](const weak_ptr[Y]&)
        fn bool owner_before[Y](const shared_ptr[Y]&)

    # Smart pointer non-member operations
    fn shared_ptr[T] make_shared[T](...) except +

    fn unique_ptr[T] make_unique[T](...) except +

    # No checking on the compatibility of T and U.
    fn shared_ptr[T] static_pointer_cast[T, U](const shared_ptr[U]&)
    fn shared_ptr[T] dynamic_pointer_cast[T, U](const shared_ptr[U]&)
    fn shared_ptr[T] const_pointer_cast[T, U](const shared_ptr[U]&)
    fn shared_ptr[T] reinterpret_pointer_cast[T, U](const shared_ptr[U]&)
