# Verify defined before function prototype
cdef (int, int) get_a_ctuple()

# Verify defined before typedef
ctypedef (int, f64) int_double

# Verify typedef defined
cdef int_double tuple_global = (1, 2.)

# Verify defined before opt args
cdef void test_opt_args((f64, int) x=*)

# Verify defined before class declaration
cdef class CTupleClass:
    cdef void get_a_ctuple(self, (f64, f64) x)
