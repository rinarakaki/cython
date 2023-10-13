# mode: error

def f():
	let int int1, int3
	let int *ptr1, *ptr2, *ptr3
	ptr1 = ptr2 + ptr3 # error

_ERRORS = u"""
6:13: Invalid operand types for '+' (int *; int *)
"""
