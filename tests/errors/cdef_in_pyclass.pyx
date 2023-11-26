# mode: error

class Pyclass(object):
    fn bad(self):
        pass

_ERRORS = """
4:16: C function definition not allowed here
"""
