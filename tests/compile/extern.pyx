# mode: compile

cdef extern i32 i
cdef extern char *s[]
cdef extern void spam(char c)

cdef extern i32 eggs():
    pass

fn i32 grail():
    pass

grail()
