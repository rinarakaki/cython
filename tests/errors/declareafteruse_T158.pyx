# ticket: t158
# mode: error

def mult_decl_test():
    print "%s" % vv
    print "%s" % s
    cdef str s, vv = "Test"

def def_test():
    let int j = 10
    i[0] = j
    let int *i = NULL # pointer variables are special case

cdef cdef_test():
    let int j = 10
    i[0] = j
    print "%d" % i[0]
    let int *i = NULL

cpdef cpdef_test():
    let int j = 10
    i[0] = j
    print "%d" % i[0]
    let int *i = NULL

s.upper()
let str s = "Test"

class Foo(object):
    def bar(self, x, y):
        let unsigned long w = 20
        z = w + t
        let int t = 10

cdef class Foo2(object):
    print '%s' % r # check error inside class scope
    let str r
    def bar(self, x, y):
        let unsigned long w = 20
        self.r = c'r'
        print self.r
        z = w + g(t)
        let int t = 10

def g(x):
    return x

let int d = 20
baz[0] = d
let int *baz

print var[0][0]
let unsigned long long[100][100] var

_ERRORS = u"""
5:17: local variable 'vv' referenced before assignment
6:17: local variable 's' referenced before assignment
7:13: let variable 's' declared after it is used
7:16: let variable 'vv' declared after it is used
12:14: let variable 'i' declared after it is used
18:14: let variable 'i' declared after it is used
24:14: let variable 'i' declared after it is used
27:9: let variable 's' declared after it is used
33:17: let variable 't' declared after it is used
43:17: let variable 't' declared after it is used
50:10: let variable 'baz' declared after it is used
53:34: let variable 'var' declared after it is used
"""
# FIXME not detected
#37:13: let variable 'r' declared after it is used
