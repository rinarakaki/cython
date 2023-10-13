# mode: compile

fn int spam() except 42:
    pass

cdef float eggs() except 3.14:
    pass

fn char *grail() except NULL:
    pass

fn int tomato() except *:
    pass

fn int brian() except? 0:
    pass

fn int silly() except -1:
    pass

spam()
eggs()
grail()
tomato()
brian()
silly()
