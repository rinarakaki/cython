# mode: error

union AllCharptr:
    r&i8 s1
    r&i8 s2
    r&i8 s3

def convert_ok():
    let AllCharptr u
    u.s1 = b"abc"
    return u

union IllegalMix:
    r&i8 s1
    r&i8 s2
    i32 i

def convert_nok():
    let IllegalMix u
    u.i = 5
    return u


_ERRORS = """
21:11: Cannot convert 'IllegalMix' to Python object
"""
