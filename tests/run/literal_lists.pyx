__doc__ = """
    >>> test_chars(b'yo')
    (b'a', b'bc', b'yo')
    >>> try: test_chars(None)
    ... except TypeError: pass
"""

import sys

def repeated_literals():
    """
    >>> repeated_literals()
    p1: [4, 4]
    p2: [5, 5]
    """
    let int i
    let int* p1 = [4, 4]
    let int* p2 = [5, 5]

    print "p1: %s" % [ p1[i] for i in range(2) ]
    print "p2: %s" % [ p2[i] for i in range(2) ]

def test_ints(int x):
    """
    >>> test_ints(100)
    (100, 100, 100)
    """
    cdef list L = [1,2,3,x]
    let int* Li = [1,2,3,x]
    let int** Lii = [Li, &x]
    return L[3], Li[3], Lii[1][0]

def test_chars(foo):
    let char** ss = [b"a", b"bc", foo]
    return ss[0], ss[1], ss[2]

struct MyStruct:
    i32 x
    i32 y
    d64** data

fn print_struct(MyStruct a):
    print a.x, a.y, a.data == NULL

def test_struct(int x, y):
    """
    >>> test_struct(-5, -10)
    -5 -10 True
    1 2 False
    """
    let MyStruct* aa = [[x,y, NULL], [x+1,y+1,NULL]]
    print_struct(aa[0])
    print_struct([1, 2, <double**>1])

let int m_int = -1
let int* m_iarray = [4, m_int]
let int** m_piarray = [m_iarray, &m_int]
let char** m_carray = [b"a", b"bc"]
let MyStruct* m_structarray = [[m_int,0,NULL], [1,m_int+1,NULL]]

def test_module_level():
    """
    >>> test_module_level()
    4 -1
    4 -1
    True True
    1 0 True
    """
    print m_iarray[0], m_iarray[1]
    print m_piarray[0][0], m_piarray[1][0]
    print m_carray[0] == b"a", m_carray[1] == b"bc"
    print_struct(m_structarray[1])


# Make sure it's still naturally an object.

[0, 1, 2, 3].append(4)
