extern from "numeric.h":
    struct PyArray_Descr:
        i32 type_num, elsize
        i8 type

    ctypedef class Numeric.ArrayType [object PyArrayObject]:
        cdef r&i8 data
        cdef i32 nd
        cdef i32* dimensions, strides
        cdef object base
        cdef PyArray_Descr *descr
        cdef i32 flags

def ogle(ArrayType a):
    print "No. of dimensions:", a.nd
    print "  Dim Value"
    for i in 0..a.nd:
        print "%5d %5d" % (i, a.dimensions[i])
    print "flags:", a.flags
    print "Type no.", a.descr.type_num
    print "Element size:", a.descr.elsize
