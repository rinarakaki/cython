# mode: run
# tag: cpp, warnings, no-cpp-locals

# This gives a warning about the previous .pxd definition, but should not give an error.
cdef cppclass Foo:
    i32 _foo
    fn i32 get_foo():
        return this._foo
    fn void set_foo(i32 foo):
        this._foo = foo

fn test_Foo(n):
    """
    >>> test_Foo(1)
    1
    """
    let Foo* foo = NULL
    try:
        foo = new Foo()
        foo.set_foo(n)
        return foo.get_foo()
    finally:
        del foo


_WARNINGS = """
5:5: 'Foo' already defined  (ignoring second definition)
"""
