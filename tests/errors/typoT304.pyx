# ticket: t304
# mode: error

def f():
    print assert sizeof(i32) == sizof(short) == sizeof(long)

_ERRORS = u"""
5:10: Expected an identifier or literal, found 'assert'
"""
