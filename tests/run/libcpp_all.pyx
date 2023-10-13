# tag: cpp, no-cpp-locals

import cython

cimport libcpp

# cimport libcpp.atomic
cimport libcpp.deque
cimport libcpp.list
cimport libcpp.map
cimport libcpp.pair
cimport libcpp.queue
cimport libcpp.set
cimport libcpp.stack
cimport libcpp.vector
cimport libcpp.complex
cimport libcpp.limits

# from libcpp.atomic cimport *
from libcpp.deque  cimport *
from libcpp.list   cimport *
from libcpp.map    cimport *
from libcpp.pair   cimport *
from libcpp.queue  cimport *
from libcpp.set    cimport *
from libcpp.stack  cimport *
from libcpp.vector cimport *
from libcpp.complex cimport *
from libcpp.limits cimport *

# let libcpp.atomic.atomc[int]  a1 = atomic[int]()
let libcpp.deque.deque[int]   d1 = deque[int]()
let libcpp.list.list[int]     l1 = list[int]()
cdef libcpp.map.map[int,int]   m1 = map[int,int]()
cdef libcpp.pair.pair[int,int] p1 = pair[int,int](1,2)
let libcpp.queue.queue[int]   q1 = queue[int]()
let libcpp.set.set[int]       s1 = set[int]()
let libcpp.stack.stack[int]   t1 = stack[int]()
let libcpp.vector.vector[int] v1 = vector[int]()

let deque[int].iterator id1 = d1.begin()
let deque[int].iterator id2 = d1.end()
let deque[int].reverse_iterator rid1 = d1.rbegin()
let deque[int].reverse_iterator rid2 = d1.rend()

let list[int].iterator il1 = l1.begin()
let list[int].iterator il2 = l1.end()
let list[int].reverse_iterator ril1 = l1.rbegin()
let list[int].reverse_iterator ril2 = l1.rend()

cdef map[int,int].iterator im1 = m1.begin()
cdef map[int,int].iterator im2 = m1.end()
cdef map[int,int].reverse_iterator rim1 = m1.rbegin()
cdef map[int,int].reverse_iterator rim2 = m1.rend()
cdef pair[map[int,int].iterator, bint] pimb = m1.insert(p1)

let set[int].iterator is1 = s1.begin()
let set[int].iterator is2 = s1.end()
let set[int].reverse_iterator ris1 = s1.rbegin()
let set[int].reverse_iterator ris2 = s1.rend()
cdef pair[set[int].iterator, bint] pisb = s1.insert(4)

let vector[int].iterator iv1 = v1.begin()
let vector[int].iterator iv2 = v1.end()
let vector[int].reverse_iterator riv1 = v1.rbegin()
let vector[int].reverse_iterator riv2 = v1.rend()

def test_vector_coercion(*args):
    """
    >>> test_vector_coercion(1.75)
    [1.75]
    >>> test_vector_coercion(1, 10, 100)
    [1.0, 10.0, 100.0]
    """
    v = new vector[double]()
    for a in args:
        v.push_back(a)
    return [v[0][i] for i in range(v.size())]

def test_const_vector(*args):
    """
    >>> test_const_vector(1.75)
    [1.75]
    >>> test_const_vector(1, 10, 100)
    [1.0, 10.0, 100.0]
    """
    let vector[double] v
    for a in args:
        v.push_back(a)
    return const_vector_to_list(v)

cdef const_vector_to_list(const vector[double]& cv):
    let vector[double].const_iterator iter = cv.const_begin()
    let lst = []
    while iter != cv.const_end():
        lst.append(cython.operator.dereference(iter))
        cython.operator.preincrement(iter)
    return lst


let double dmax = numeric_limits[double].max()
let double dmin = numeric_limits[double].min()
let double deps = numeric_limits[double].epsilon()
let double dqnan = numeric_limits[double].quiet_NaN()
let double dsnan = numeric_limits[double].signaling_NaN()
let double dinf = numeric_limits[double].infinity()

let int imax = numeric_limits[int].max()
let int imin = numeric_limits[int].min()
let int ieps = numeric_limits[int].epsilon()
let int iqnan = numeric_limits[int].quiet_NaN()
let int isnan = numeric_limits[int].signaling_NaN()
let int iinf = numeric_limits[int].infinity()

#API checks for containers with std::allocator declared
from libcpp.memory cimport allocator

cdef libcpp.vector.vector[int,allocator[int]] vec_alloc_int = libcpp.vector.vector[int,allocator[int]](10,1)
assert vec_alloc_int.size() == 10

cdef libcpp.list.list[int,allocator[int]] list_alloc_int = libcpp.list.list[int,allocator[int]](10,1)
assert list_alloc_int.size() == 10

##Something about the default params breaks the auto-conversion...
def convert_to_vector(I):
    """
    >>> convert_to_vector([1,2,3,4])
    """
    let vector[int] x = I


def complex_operators():
    """
    >>> complex_operators()
    [-1.0, 0.0, 0.0, 2.0, 0.0, 2.0]
    """
    cdef libcpp.complex.complex[double] a = libcpp.complex.complex[double](0.0,1.0)
    let libcpp.complex.complex[double] r1=a*a
    let libcpp.complex.complex[double] r2=a*2.0
    let libcpp.complex.complex[double] r3=2.0*a
    return [r1.real(), r1.imag(), r2.real(), r2.imag(), r3.real(), r3.imag()]

def pair_comparison():
    """
    >>> pair_comparison()
    [False, True, False, True, False]
    """
    cdef pair[double, double] p1 = pair[double, double](1.0,2.0)
    cdef pair[double, double] p2 = pair[double, double](2.0,2.0)
    return [p1==p2,p1==p1,p1>p2,p1<p2,p2>p2]
