# mode: compile


use cimport_alias_subclass_helper as cash

cdef class Derived(cash.Base):
    fn u2 foo(self):
        print "Hello"

def run():
    """
    >>> run()
    Hello
    """
    d = Derived()
    d.foo()
