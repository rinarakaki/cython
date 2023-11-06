# mode: compile

cdef class Grail:
    def __add__(i32 x, f32 y):
        pass

cdef class Swallow:
    pass

fn f(Grail g):
    let i32 i = 0
    let auto s = Swallow()
    let object x = Grail()
    g = x
    x = g
    g = i
    i = g
    g = s
    s = g
