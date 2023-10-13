# mode: compile

def f(obj, i32 i, f64 f, char *s1, char s2[]):
    pass

fn g(obj, i32 i, f64 f, char *s1, char s2[]):
    pass

fn do_g(object (*func)(object, int, double, char*, char*)):
    return func(1, 2, 3.14159, "a", "b")

do_g(&g)
