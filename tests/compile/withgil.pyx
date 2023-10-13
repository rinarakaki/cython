# mode: compile

cdef void f() with gil:
    x = 42

fn int g(void* x) with gil:
    pass

f()
g("test")
