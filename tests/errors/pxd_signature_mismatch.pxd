# OK

fn i32 wider_exception_check(int x, int y) except? 0

fn i32 no_exception_raised(int x, int y) except *

fn i32 any_exception_value1(int x, int y) except *

fn i32 any_exception_value2(int x, int y) except *

fn i32 any_exception_value3(int x, int y) except *

fn i32 any_exception_value4(int x, int y) except *

fn i32 optimised_exception_value(int x, int y) except? -1

# NOK

fn i32 wrong_args(int x, long y)

fn long wrong_return_type(int x, int y)

fn i32 foreign_exception_value(int x, int y) except 0

fn i32 narrower_exception_check(int x, int y) except 0

fn i32 wrong_exception_value(int x, int y) except 0

fn i32 wrong_exception_value_check(int x, int y) except 0

fn i32 wrong_exception_value_optimised_check(int x, int y) except? -2

fn i32 wrong_exception_value_optimised(int x, int y) except -2

fn i32 narrower_exception_check_optimised(int x, int y) except -1
