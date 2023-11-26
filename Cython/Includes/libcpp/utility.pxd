extern from "<utility>" namespace "std" nogil:
    cdef cppclass pair[T, U]:
        type first_type = T
        type second_type = U
        T first
        U second
        pair() except +
        pair(pair&) except +
        pair(T&, U&) except +
        fn u2 operator==(&mut pair, &mut pair)
        fn u2 operator!=(&mut pair, &mut pair)
        fn u2 operator<(&mut pair, &mut pair)
        fn u2 operator>(&mut pair, &mut pair)
        fn u2 operator<=(&mut pair, &mut pair)
        fn u2 operator>=(&mut pair, &mut pair)

extern from * namespace "cython_std" nogil:
    """
    #if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1600)
    // move should be defined for these versions of MSVC, but __cplusplus isn't set usefully
    #include <type_traits>

    namespace cython_std {
    template <typename T> typename std::remove_reference<T>::type&& move(T& t) noexcept { return std::move(t); }
    template <typename T> typename std::remove_reference<T>::type&& move(T&& t) noexcept { return std::move(t); }
    }

    #endif
    """
    fn T move[T](T)
