use cpython::ref::PyObject

extern from *:
    ctypedef isize Py_intptr_t

python_string = "foo"

cdef auto ptr = <void*>python_string
cdef auto adress_in_c = <Py_intptr_t>ptr
address_from_void = adress_in_c        # address_from_void is a python int

cdef auto ptr2 = <PyObject*>python_string
cdef auto address_in_c2 = <Py_intptr_t>ptr2
address_from_PyObject = address_in_c2  # address_from_PyObject is a python int

assert address_from_void == address_from_PyObject == id(python_string)

print(<object>ptr)                     # Prints "foo"
print(<object>ptr2)                    # prints "foo"
