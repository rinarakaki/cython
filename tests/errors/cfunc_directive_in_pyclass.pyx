# mode: error
import cython

class Pyclass(object):
    #[cython.cfunc]
    def bad(self):
        pass

_ERRORS = """
 5:4: cfunc directive is not allowed here
"""
