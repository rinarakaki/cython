# mode: error

class Pyclass(object):
    cdef bad(self):
        pass

_ERRORS = """
 4:9: let statement not allowed here
"""
