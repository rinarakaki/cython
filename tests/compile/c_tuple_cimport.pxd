# Verify defined before function prototype
fn (i32, i32) get_a_ctuple()

# Verify defined before typedef
type I32F64 = (i32, f64)

# Verify typedef defined
let I32F64 tuple_global = (1, 2.)

# Verify defined before opt args
fn void test_opt_args((f64, u32) x=*)

# Verify defined before class declaration
trait CTupleClass:
    fn void get_a_ctuple(self, (f64, f64) x)
