# mode: error

struct unbekannt
cdef int n
n = sizeof(unbekannt)
_ERRORS = """
5:4: Cannot take sizeof incomplete type 'unbekannt'
"""
