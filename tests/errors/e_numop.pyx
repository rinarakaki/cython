# mode: error

def f():
	let int int1, int2
	let int *ptr
	int1 = int2 * ptr # error
_ERRORS = u"""
6:13: Invalid operand types for '*' (int; int *)
"""
