extern from "externsue.h":
    enum Eggs:
        Runny, Firm, Hard

    struct Spam:
        i32 i

    union Soviet:
        i8 c

extern static Eggs e
extern static Spam s
extern static Soviet u

fn void tomato():
    global e
    e = Runny
    e = Firm
    e = Hard
