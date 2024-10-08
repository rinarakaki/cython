# mode: error
# -*- coding: iso-8859-1 -*-

cdef Py_UNICODE char_ASCII = u'A'
cdef Py_UNICODE char_KLINGON = u'\uF8D2'

def char_too_long_ASCII():
    let Py_UNICODE c = u'AB'

def char_too_long_Unicode():
    let Py_UNICODE c = u'A\uF8D2'

def char_too_long_bytes():
    let Py_UNICODE c = b'AB'

def char_too_long_latin1():
    let Py_UNICODE char_bytes_latin1 = b'\xf6'


_ERRORS = """
 8:23: Only single-character Unicode string literals or surrogate pairs can be coerced into Py_UCS4/Py_UNICODE.
11:23: Only single-character Unicode string literals or surrogate pairs can be coerced into Py_UCS4/Py_UNICODE.
14:23: Only single-character string literals can be coerced into ints.
17:39: Bytes literals cannot coerce to Py_UNICODE/Py_UCS4, use a unicode literal instead.
"""
