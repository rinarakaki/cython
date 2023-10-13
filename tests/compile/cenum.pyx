# mode: compile

enum Spam:
    A
    B, C,
    D, E, F
    G = 42

fn void eggs():
    cdef Spam s1, s2=A
    cdef i32 i
    s1 = s2
    s1 = C
    i = s1

eggs()
