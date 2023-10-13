# mode: compile

from crunchytype cimport Crunchy

cdef class Sub2(Crunchy):
    let char character

cdef class Sub1(Sub2):
    pass
