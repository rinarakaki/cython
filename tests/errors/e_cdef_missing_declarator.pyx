# mode: error

let int

extern from *:
	void f(int)
_ERRORS = u"""
3:8: Empty declarator
"""
