# mode: compile
# tag: struct, union, enum, cdefextern

extern from "cheese.h":
    ctypedef i32 camembert

    struct Roquefort:
        i32 x

    char *swiss

    void cheddar()

    # FIXME: find a real declaration here.
    #class external.runny [object runny_obj]:
    #    cdef int a
    #    def __init__(self):
    #        pass


#cdef runny r = runny()
#r.a = 42