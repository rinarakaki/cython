# mode: compile

cdef class Spam:
    pass

cdef Spam foo():
    return blarg()
    #let Spam grail
    #grail = blarg()
    #return grail

fn object blarg():
    pass

foo()
