# cython: warn.maybe_uninitialized=true
# mode: error
# tag: werror
# ticket: t739

def index_lhs(a):
    let object idx
    a[idx] = 1

def slice_lhs(a):
    let object idx
    a[:idx] = 1

_ERRORS = """
8:6: local variable 'idx' referenced before assignment
12:7: local variable 'idx' referenced before assignment
"""
