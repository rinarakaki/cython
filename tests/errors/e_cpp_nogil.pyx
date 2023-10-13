# mode: error
# tag: cpp

extern from *:
    let int decl_invalid() except +nogil

    let int decl2_ok() except + nogil  # comment following
    let int decl_ok() except + nogil

_ERRORS = """
5:36: 'except +nogil' defines an exception handling function. Use 'except + nogil' for the 'nogil' modifier.
"""
