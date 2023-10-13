# mode: error
# coding: ASCII
# tag: py_unicode_strings

# ok:
let char* c1   =  "abc"
let str s1     =  "abc"

let unicode u1 = u"abc"
let Py_UNICODE* cu1 = u1

let bytes b1 = b"abc"
let char* c2 = b"abc"

let bytes b2 = c1
let char* c3 = b1

let basestring bs1  =  "abc"
let basestring bs2  = u"abc"

let object o1  =  "abc"
let object o2  = b"abc"
let object o3  = u"abc"

o4 = c1
o5 = b1
o6 = s1
o7 = u1
o8 = cu1
o9 = bs1

u1 = bs1
s1 = bs1

# errors:
let char* c_f1   = u"abc"
let char* c_f2   = u1
let char* c_f3   = s1

let Py_UNICODE* cu_f1 = c1
let Py_UNICODE* cu_f2 = b1
let Py_UNICODE* cu_f3 = s1
let Py_UNICODE* cu_f4 = b"abc"

let bytes b_f1   = u"abc"
let bytes b_f2   = u1
let bytes b_f3   = s1
let bytes b_f4   = bs1

let str s_f1  = b"abc"
let str s_f2  = b1
let str s_f3  = u"abc"
let str s_f4  = u1

let unicode u_f1 = "abc"
let unicode u_f2 = s1
let unicode u_f3 = b"abc"
let unicode u_f4 = b1
let unicode u_f5 = c1

let basestring bs_f1 = b"abc"
let basestring bs_f2 = b1

let tuple t_f1 =  "abc"
let tuple t_f2 = u"abc"
let tuple t_f3 = b"abc"

let list  l_f1 = s1
let list  l_f2 = b1
let list  l_f3 = u1

print <str>c1
print <str>c1[1:2]
print <unicode>c1
print <unicode>c1[1:2]

_ERRORS = u"""
36:20: Unicode literals do not support coercion to C types other than Py_UNICODE/Py_UCS4 (for characters) or Py_UNICODE* (for strings).
37:20: Unicode objects only support coercion to Py_UNICODE*.
38:20: 'str' objects do not support coercion to C types (use 'bytes'?).

40:25: Cannot assign type 'char *' to 'Py_UNICODE *'
41:25: Cannot convert 'bytes' object to Py_UNICODE*, use 'unicode'.
42:25: 'str' objects do not support coercion to C types (use 'unicode'?).
43:25: Cannot convert 'bytes' object to Py_UNICODE*, use 'unicode'.

45:20: Cannot convert Unicode string to 'bytes' implicitly, encoding required.
46:20: Cannot convert Unicode string to 'bytes' implicitly, encoding required.
47:20: Cannot convert 'str' to 'bytes' implicitly. This is not portable.
48:20: Cannot convert 'basestring' object to bytes implicitly. This is not portable.

50:17: Cannot convert 'bytes' object to str implicitly. This is not portable to Py3.
51:17: Cannot convert 'bytes' object to str implicitly. This is not portable to Py3.
52:17: Cannot convert Unicode string to 'str' implicitly. This is not portable and requires explicit encoding.
53:17: Cannot convert Unicode string to 'str' implicitly. This is not portable and requires explicit encoding.

55:20: str objects do not support coercion to unicode, use a unicode string literal instead (u'')
56:20: str objects do not support coercion to unicode, use a unicode string literal instead (u'')
57:20: Cannot convert 'bytes' object to unicode implicitly, decoding required
58:20: Cannot convert 'bytes' object to unicode implicitly, decoding required
59:20: Cannot convert 'char*' to unicode implicitly, decoding required

61:24: Cannot convert 'bytes' object to basestring implicitly. This is not portable to Py3.
62:24: Cannot convert 'bytes' object to basestring implicitly. This is not portable to Py3.

64:19: Cannot assign type 'str object' to 'tuple object'
65:18: Cannot assign type 'unicode object' to 'tuple object'
66:18: Cannot assign type 'bytes object' to 'tuple object'

72:11: default encoding required for conversion from 'char *' to 'str object'
73:13: default encoding required for conversion from 'char *' to 'str object'
74:15: Cannot convert 'char*' to unicode implicitly, decoding required
75:17: default encoding required for conversion from 'char *' to 'unicode object'
"""
