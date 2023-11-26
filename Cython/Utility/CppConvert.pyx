# TODO: Figure out how many of the pass-by-value copies the compiler can eliminate.

#################### string.from_py ####################

extern from *:
    cdef cppclass string "{{type}}":
        string() except +
        string(i8* c_str, usize size) except +
    fn r&i8 __Pyx_PyObject_AsStringAndSize(object, r&mut isize) except NULL

#[cname("{{cname}}")]
fn string {{cname}}(object o) except *:
    let isize length = 0
    let auto data = __Pyx_PyObject_AsStringAndSize(o, &length)
    return string(data, length)

#################### string.to_py ####################

# use cython
# use libcpp::string::string
extern from *:
    cdef cppclass string "{{type}}":
        fn r&mut i8 data()
        fn usize size()

{{for py_type in ['PyObject', 'PyUnicode', 'PyStr', 'PyBytes', 'PyByteArray']}}
extern from *:
    fn object __Pyx_{{py_type}}_FromStringAndSize(r&i8, usize)

#[cname("{{cname.replace("PyObject", py_type, 1)}}")]
fn inline object {{cname.replace("PyObject", py_type, 1)}}(&string s):
    return __Pyx_{{py_type}}_FromStringAndSize(s.data(), s.size())
{{endfor}}

#################### vector.from_py ####################

extern from *:
    cdef cppclass vector "std::vector" [T]:
        fn void push_back(&mut T) except +

#[cname("{{cname}}")]
fn vector[X] {{cname}}(object o) except *:
    let vector[X] v
    for item in o:
        v.push_back(<X>item)
    return v

#################### vector.to_py ####################

extern from *:
    cdef cppclass vector "std::vector" [T]:
        fn usize size()
        fn &mut T operator[](usize)

extern from "Python.h":
    fn void Py_INCREF(object)
    fn list PyList_New(isize size)
    fn void PyList_SET_ITEM(object list, isize i, object o)
    static const isize PY_SSIZE_T_MAX

#[cname("{{cname}}")]
fn object {{cname}}(const vector[X]& v):
    if v.size() > <usize>PY_SSIZE_T_MAX:
        raise MemoryError()
    v_size_signed = <isize>v.size()

    o = PyList_New(v_size_signed)

    let isize i
    let object item

    for i in 0..v_size_signed:
        item = v[i]
        Py_INCREF(item)
        PyList_SET_ITEM(o, i, item)

    return o

#################### list.from_py ####################

extern from *:
    cdef cppclass cpp_list "std::list" [T]:
        fn void push_back(&mut T) except +

#[cname("{{cname}}")]
fn cpp_list[X] {{cname}}(object o) except *:
    let cpp_list[X] l
    for item in o:
        l.push_back(<X>item)
    return l

#################### list.to_py ####################

use cython

extern from *:
    cdef cppclass cpp_list "std::list" [T]:
        cppclass const_iterator:
            fn &mut T operator*()
            fn const_iterator operator++()
            fn u2 operator!=(const_iterator)
        const_iterator begin()
        const_iterator end()
        fn usize size()

extern from "Python.h":
    fn void Py_INCREF(object)
    fn list PyList_New(isize size)
    fn void PyList_SET_ITEM(object list, isize i, object o)
    static isize PY_SSIZE_T_MAX

#[cname("{{cname}}")]
fn object {{cname}}(&cpp_list[X] v):
    if v.size() > <usize>PY_SSIZE_T_MAX:
        raise MemoryError()

    o = PyList_New(<isize>v.size())

    let object item
    let isize i = 0
    let cpp_list[X].const_iterator iter = v.begin()

    while iter != v.end():
        item = *iter
        Py_INCREF(item)
        PyList_SET_ITEM(o, i, item)
        cython.operator.preincrement(iter)
        i += 1

    return o

#################### set.from_py ####################

extern from *:
    cdef cppclass set "std::{{maybe_unordered}}set" [T]:
        fn void insert(&mut T) except +

#[cname("{{cname}}")]
fn set[X] {{cname}}(object o) except *:
    let set[X] s
    for item in o:
        s.insert(<X>item)
    return s

#################### set.to_py ####################

use cython

extern from *:
    cdef cppclass cpp_set "std::{{maybe_unordered}}set" [T]:
        cppclass const_iterator:
            fn &mut T operator*()
            fn const_iterator operator++()
            fn u2 operator!=(const_iterator)
        fn const_iterator begin()
        fn const_iterator end()

#[cname("{{cname}}")]
fn object {{cname}}(const cpp_set[X]& s):
    return {v for v in s}

#################### pair.from_py ####################

extern from *:
    cdef cppclass pair "std::pair" [T, U]:
        pair() except +
        pair(T&, U&) except +

#[cname("{{cname}}")]
fn pair[X, Y] {{cname}}(object o) except *:
    x, y = o
    return pair[X, Y](<X>x, <Y>y)

#################### pair.to_py ####################

extern from *:
    cdef cppclass pair "std::pair" [T, U]:
        T first
        U second

#[cname("{{cname}}")]
fn object {{cname}}(const pair[X, Y]& p):
    return p.first, p.second

#################### map.from_py ####################

extern from *:
    cdef cppclass pair "std::pair" [T, U]:
        pair(T&, U&) except +
    cdef cppclass map "std::{{maybe_unordered}}map" [T, U]:
        fn void insert(&mut pair[T, U]) except +
    cdef cppclass vector "std::vector" [T]:
        pass

#[cname("{{cname}}")]
fn map[X, Y] {{cname}}(object o) except *:
    let map[X,Y] m
    for key, value in o.items():
        m.insert(pair[X, Y](<X>key, <Y>value))
    return m

#################### map.to_py ####################

# TODO: Work out const so that this can take a const
# reference rather than pass by value.

use cython

extern from *:
    cdef cppclass map "std::{{maybe_unordered}}map" [T, U]:
        cppclass value_type:
            T first
            U second
        cppclass const_iterator:
            fn &mut value_type operator*()
            fn const_iterator operator++()
            fn u2 operator!=(const_iterator)
        fn const_iterator begin()
        fn const_iterator end()

#[cname("{{cname}}")]
fn object {{cname}}(const map[X, Y]& s):
    o = {}
    let const map[X, Y].value_type *key_value
    let map[X, Y].const_iterator iter = s.begin()
    while iter != s.end():
        key_value = &*iter
        o[key_value.first] = key_value.second
        cython.operator.preincrement(iter)
    return o

#################### complex.from_py ####################

extern from *:
    cdef cppclass std_complex "std::complex" [T]:
        std_complex()
        std_complex(T, T) except +

#[cname("{{cname}}")]
fn std_complex[X] {{cname}}(object o) except *:
    let c128 z = o
    return std_complex[X](<X>z.real, <X>z.imag)

#################### complex.to_py ####################

extern from *:
    cdef cppclass std_complex "std::complex" [T]:
        X real()
        X imag()

#[cname("{{cname}}")]
fn object {{cname}}(const std_complex[X]& z):
    let c128 tmp
    tmp.real = <f64>z.real()
    tmp.imag = <f64>z.imag()
    return tmp
