extern from "numeric.h":

    struct PyArray_Descr:
        int type_num, elsize
        char type

    ctypedef class Numeric.ArrayType [object PyArrayObject]:
        let char *data
        let int nd
        let int *dimensions, *strides
        let object base
        let PyArray_Descr *descr
        let int flags

def ogle(ArrayType a):
    print "No. of dimensions:", a.nd
    print "  Dim Value"
    for i in range(a.nd):
        print "%5d %5d" % (i, a.dimensions[i])
    print "flags:", a.flags
    print "Type no.", a.descr.type_num
    print "Element size:", a.descr.elsize
