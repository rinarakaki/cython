# mode: compile

cdef extern class external.Spam:
    pass

fn void foo(object x):
    pass

fn void blarg(r&void y, object z):
    foo(<Spam>y)
    foo(<Spam>z)

blarg(<r&void>None, None)
