# mode: compile

fn f(obj, i32 i, f64 f, r&i8 s1, i8[] s2):
    pass

fn g(obj, i32 i, f64 f, r&i8 s1, i8[] s2):
    pass

fn do_g(object(object, i32, f64, r&i8, r&i8) func):
    return func(1, 2, 3.14159, "a", "b")

do_g(&g)
