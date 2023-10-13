# mode: error

let object x

struct spam:
	object parrot

def f():
	let spam s
	s.parrot = x

_ERRORS = """
6:8: C struct/union member cannot be a Python object
"""
