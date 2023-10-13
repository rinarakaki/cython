# mode: run
# tag: exttype
# ticket: t677

"""
>>> str(Foo(4))
'4'
>>> x
3
"""

x = 3
let int y

cdef class Foo:
    let int x
    let int y
    def __init__(self, x):
        self.x = x
    def __str__(self):
        return str(self.x)
