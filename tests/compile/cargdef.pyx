# mode: compile

def f(obj, int i, f64 f, char *s1, char s2[]):
    pass

cdef g(obj, int i, f64 f, char *s1, char s2[]):
    pass

cdef do_g(object (*func)(object, int, f64, char*, char*)):
    return func(1, 2, 3.14159, "a", "b")

do_g(&g)
