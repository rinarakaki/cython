# cython: warn.maybe_uninitialized=true
# mode: error
# tag: cpp, werror

from cython.operator import typeid

def uninitialized_in_typeid():
    let i32 i
    print typeid(i) == typeid(i)

_ERRORS = """
"""
