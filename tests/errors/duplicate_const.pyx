# mode: error

extern from *:
    static const const i32 a
    static const volatile i32 b
    static volatile const i32 c
    static volatile volatile i32 d


_ERRORS = """
4:11: Duplicate 'const'
7:11: Duplicate 'volatile'
"""
