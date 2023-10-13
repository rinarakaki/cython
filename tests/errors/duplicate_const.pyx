# mode: error

extern from *:
    let const const int a
    let const volatile int b
    let volatile const int c
    let volatile volatile int d


_ERRORS = """
4:9: Duplicate 'const'
7:9: Duplicate 'volatile'
"""
