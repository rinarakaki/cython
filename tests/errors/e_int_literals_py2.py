# mode: error
# cython: language_level=2

def int_literals():
    a = 1i64  # ok
    b = 10000000000000i64  # ok
    c = 1u64
    d = 10000000000000u64
    e = 10000000000000i128


_ERRORS = """
7:11: illegal integer literal syntax in Python source file
8:11: illegal integer literal syntax in Python source file
9:11: illegal integer literal syntax in Python source file
"""
