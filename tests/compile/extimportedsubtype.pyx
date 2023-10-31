# mode: compile

use crunchytype::Crunchy

cdef class Sub2(Crunchy):
    cdef char character

cdef class Sub1(Sub2):
    pass
