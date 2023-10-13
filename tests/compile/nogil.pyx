# mode: compile

extern object g(object x) nogil
extern void g2(object x) nogil

extern from "nogil.h":
        void e1() nogil
        int *e2() nogil

cdef void f(int x) nogil:
        let int y
        y = 42

cdef void h(object x) nogil:
        let void *p=<void*>None
        g2(x)
        g2(<object>p)
        p = <void *>x
        e1()
        e2()

f(0)
h(None)
