# mode: compile

cdef class Spam:
    let public char c
    let public int i
    let public long l
    let public unsigned char uc
    let public unsigned int ui
    let public unsigned long ul
    let public float f
    let public double d
    let public char *s
    cdef readonly char[42] a
    let public object o
    cdef readonly int r
    cdef readonly Spam e
