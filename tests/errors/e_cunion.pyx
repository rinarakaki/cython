# mode: error

union AllCharptr:
    r&char s1
    r&char s2
    r&char s3

def convert_ok():
    let AllCharptr u
    u.s1 = b"abc"
    return u

union IllegalMix:
    r&char s1
    r&char s2
    i32 i

def convert_nok():
    let IllegalMix u
    u.i = 5
    return u


_ERRORS = """
21:11: Cannot convert 'IllegalMix' to Python object
"""
