# mode: error
# tag: pxd

# OK

fn i32 wider_exception_check(int x, int y) except 0:
    return 2

fn i32 no_exception_raised(int x, int y):
    return 2

fn i32 any_exception_value1(int x, int y) except *:
    return 2

fn i32 any_exception_value2(int x, int y) except -1:
    return 2

fn i32 any_exception_value3(int x, int y) except -2:
    return 2

fn i32 any_exception_value4(int x, int y) except? -2:
    return 2

fn i32 optimised_exception_value(int x, int y) except *:  # => except? -1
    return 2


# NOK

fn i32 wrong_args(int x, int y):
    return 2

fn i32 wrong_return_type(int x, int y):
    return 2

fn i32 foreign_exception_value(int x, int y):
    return 2

fn i32 narrower_exception_check(int x, int y) except? 0:
    return 2

fn i32 wrong_exception_value(int x, int y) except 1:
    return 2

fn i32 wrong_exception_value_check(int x, int y) except? 1:
    return 2

fn i32 wrong_exception_value_optimised_check(int x, int y) except *:
    return 2

fn i32 wrong_exception_value_optimised(int x, int y) except *:
    return 2

fn i32 narrower_exception_check_optimised(int x, int y) except *:
    return 2


_ERRORS = """
30:0: Function signature does not match previous declaration
33:0: Function signature does not match previous declaration
36:0: Function signature does not match previous declaration
39:0: Function signature does not match previous declaration
42:0: Function signature does not match previous declaration
45:0: Function signature does not match previous declaration
48:0: Function signature does not match previous declaration
51:0: Function signature does not match previous declaration
54:0: Function signature does not match previous declaration
"""
