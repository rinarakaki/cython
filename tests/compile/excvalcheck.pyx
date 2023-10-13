# mode: compile

extern from "excvalcheck.h":
    pass

extern int spam() except -1
extern void grail() except *
extern char *tomato() except? NULL

cdef void eggs():
    let int i
    let char *p
    i = spam()
    grail()
    p = tomato()

eggs()
