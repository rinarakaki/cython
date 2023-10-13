# mode: error

struct Foo

def f(Foo *p):
	pass

_ERRORS = """
5:6: Cannot convert Python object argument to type 'Foo *'
"""
