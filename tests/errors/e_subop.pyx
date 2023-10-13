# mode: error

def f():
	let int int2
	let char *ptr1, *ptr2, *ptr3
	ptr1 = int2 - ptr3 # error
	ptr1 = ptr2 - ptr3 # error
_ERRORS = u"""
6:13: Invalid operand types for '-' (int; char *)
7:13: Cannot assign type 'ptrdiff_t' to 'char *'
"""
