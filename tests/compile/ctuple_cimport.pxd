# Verify defined before function prototype
fn (i32, i32) get_a_ctuple()

# Verify defined before typedef
type int_double = (i32, f64)

# Verify typedef defined
cdef int_double tuple_global = (1, 2.0)

# Verify defined before opt args
fn void test_opt_args((f64, i32) x=*)

# Verify defined before class declaration
cdef class CTupleClass:
    fn void get_a_ctuple(self, (f64, f64) x)
