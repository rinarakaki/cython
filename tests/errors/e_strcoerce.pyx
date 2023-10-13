# mode: error

let int c1 = "t"     # works
let int c2 = "te"    # fails
let int cx = "test"  # fails

let int x1 =  "\xFF"    # works
let int x2 =  "\u0FFF"  # fails

let Py_UNICODE u1 = u"\xFF"   # works
let int u3 = u"\xFF"          # fails


_ERRORS = """
4:14: Only single-character string literals can be coerced into ints.
5:14: Only single-character string literals can be coerced into ints.
8:15: Only single-character string literals can be coerced into ints.
11:14: Unicode literals do not support coercion to C types other than Py_UNICODE/Py_UCS4 (for characters) or Py_UNICODE* (for strings).
"""
