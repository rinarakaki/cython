
extern from "<execution>" namespace "std::execution" nogil:
    cdef cppclass sequenced_policy:
        pass
    cdef cppclass parallel_policy:
        pass
    cdef cppclass parallel_unsequenced_policy:
        pass
    cdef cppclass unsequenced_policy:
        pass

    static const sequenced_policy seq "std::execution::seq"
    static const parallel_policy par "std::execution::par"
    static const parallel_unsequenced_policy par_unseq "std::execution::par_unseq"
    static const unsequenced_policy unseq "std::execution::unseq"
