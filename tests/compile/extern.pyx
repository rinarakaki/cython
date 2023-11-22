# mode: compile

cdef extern i32 i
cdef extern r&mut i8 s[]
extern fn void spam(char c)

extern fn i32 eggs():
    pass

fn i32 grail():
    pass

grail()
