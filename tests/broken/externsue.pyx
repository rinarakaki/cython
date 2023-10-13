extern from "externsue.h":

    enum Eggs:
        runny, firm, hard

    struct Spam:
        int i

    union Soviet:
        char c

extern Eggs e
extern Spam s
extern Soviet u

cdef void tomato():
    global e
    e = runny
    e = firm
    e = hard

