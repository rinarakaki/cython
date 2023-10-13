# mode: compile

cdef void f():
    let void *p
    let char *q=NULL
    p = q

f()
