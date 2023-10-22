# mode: error

class Pyclass(object):
    fn bad(self):
        pass

_ERRORS = """
 4:9: cdef statement not allowed here
"""
