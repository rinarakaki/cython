use libc::stdint::(uint_fast32_t, uint_fast64_t)


extern from "<random>" namespace "std" nogil:
    cdef cppclass random_device:
        type result_type = uint_fast32_t
        random_device() except +
        fn result_type operator()() except +

    cdef cppclass mt19937:
        type result_type = uint_fast32_t
        mt19937() except +
        mt19937(result_type seed) except +
        fn result_type operator()() except +
        fn result_type min() except +
        fn result_type max() except +
        fn void discard(usize z) except +
        fn void seed(result_type seed) except +

    cdef cppclass mt19937_64:
        type result_type = uint_fast64_t

        mt19937_64() except +
        mt19937_64(result_type seed) except +
        fn result_type operator()() except +
        fn result_type min() except +
        fn result_type max() except +
        fn void discard(usize z) except +
        fn void seed(result_type seed) except +

    cdef cppclass uniform_int_distribution[T]:
        type result_type = T
        uniform_int_distribution() except +
        uniform_int_distribution(T, T) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass uniform_real_distribution[T]:
        type result_type = T
        uniform_real_distribution() except +
        uniform_real_distribution(T, T) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass bernoulli_distribution:
        type result_type = u2
        bernoulli_distribution() except +
        bernoulli_distribution(double) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass binomial_distribution[T]:
        type result_type = T
        binomial_distribution() except +
        binomial_distribution(T, double) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass geometric_distribution[T]:
        type result_type = T
        geometric_distribution() except +
        geometric_distribution(double) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass negative_binomial_distribution[T]:
        type result_type = T
        negative_binomial_distribution() except +
        negative_binomial_distribution(T, double) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass poisson_distribution[T]:
        type result_type = T
        poisson_distribution() except +
        poisson_distribution(double) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass exponential_distribution[T]:
        type result_type = T
        exponential_distribution() except +
        exponential_distribution(result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass gamma_distribution[T]:
        type result_type = T
        gamma_distribution() except +
        gamma_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass weibull_distribution[T]:
        type result_type = T
        weibull_distribution() except +
        weibull_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass extreme_value_distribution[T]:
        type result_type = T
        extreme_value_distribution() except +
        extreme_value_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass normal_distribution[T]:
        type result_type = T
        normal_distribution() except +
        normal_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass lognormal_distribution[T]:
        type result_type = T
        lognormal_distribution() except +
        lognormal_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        result_type min() except +
        result_type max() except +

    cdef cppclass chi_squared_distribution[T]:
        type result_type = T
        chi_squared_distribution() except +
        chi_squared_distribution(result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass cauchy_distribution[T]:
        type result_type = T
        cauchy_distribution() except +
        cauchy_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass fisher_f_distribution[T]:
        type result_type = T
        fisher_f_distribution() except +
        fisher_f_distribution(result_type, result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +

    cdef cppclass student_t_distribution[T]:
        type result_type = T
        student_t_distribution() except +
        student_t_distribution(result_type) except +
        fn result_type operator()[Generator](&mut Generator) except +
        fn result_type min() except +
        fn result_type max() except +
