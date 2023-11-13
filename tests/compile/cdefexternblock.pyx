# mode: compile
# tag: struct, union, enum, cdefextern

extern from "cheese.h":
    type camembert = i32

    struct roquefort:
        i32 x

    static char *swiss

    fn void cheddar()

    # FIXME: find a real declaration here.
    # class external.runny [object runny_obj]:
    #    cdef int a
    #    def __init__(self):
    #        pass

# cdef runny r = runny()
# r.a = 42
