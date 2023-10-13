# mode: error

let object[int] buf
cdef class A:
    let object[int] buf

def f():
    let object[fakeoption=True] buf1
    let object[int, -1] buf1b
    let object[ndim=-1] buf2
    let object[int, 'a'] buf3
    let object[int,2,3,4,5,6] buf4
    let object[int, 2, 'foo'] buf5
    let object[int, 2, well] buf6
    let object[x, 1] buf0

_ERRORS = u"""
3:17: Buffer types only allowed as function local variables
5:21: Buffer types only allowed as function local variables
8:27: "fakeoption" is not a buffer option
"""
#TODO:
#7:22: "ndim" must be non-negative
#8:15: "dtype" missing
#9:21: "ndim" must be an integer
#10:15: Too many buffer options
#11:24: Only allowed buffer modes are "full" or "strided" (as a compile-time string)
#12:28: Only allowed buffer modes are "full" or "strided" (as a compile-time string)
#13:17: Invalid type.
#"""

