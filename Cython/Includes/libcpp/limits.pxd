extern from "<limits>" namespace "std" nogil:
    enum float_round_style:
        round_indeterminate       = -1
        round_toward_zero         = 0
        round_to_nearest          = 1
        round_toward_infinity     = 2
        round_toward_neg_infinity = 3

    enum float_denorm_style:
        denorm_indeterminate  = -1
        denorm_absent         = 0
        denorm_present        = 1

    #The static methods can be called as, e.g. numeric_limits[int].round_error(), etc.
    #The const data members should be declared as static.  Cython currently doesn't allow that
    #and/or I can't figure it out, so you must instantiate an object to access, e.g.
    #cdef numeric_limits[double] lm
    #print lm.round_style
    cdef cppclass numeric_limits[T]:
        const u2 is_specialized
        @staticmethod
        T min()
        @staticmethod
        T max()
        const i32 digits
        const i32  digits10
        const u2 is_signed
        const u2 is_integer
        const u2 is_exact
        const i32 radix
        @staticmethod
        T epsilon()
        @staticmethod
        T round_error()

        const i32  min_exponent
        const i32  min_exponent10
        const i32  max_exponent
        const i32  max_exponent10

        const u2 has_infinity
        const u2 has_quiet_NaN
        const u2 has_signaling_NaN
        const float_denorm_style has_denorm
        const u2 has_denorm_loss
        @staticmethod
        T infinity()
        @staticmethod
        T quiet_NaN()
        @staticmethod
        T signaling_NaN()
        @staticmethod
        T denorm_min()

        const u2 is_iec559
        const u2 is_bounded
        const u2 is_modulo

        const u2 traps
        const u2 tinyness_before
        const float_round_style round_style
