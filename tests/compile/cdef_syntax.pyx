# mode: compile

# the following are valid syntax constructs and should not produce errors

type x = i32

fn no_semi():
    cdef i32 i

fn with_semi():
    cdef i32 i;

def use_cdef():
    &no_semi, &with_semi
