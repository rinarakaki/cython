"""
Check that Cython generates a tp_clear function that actually clears object
references to NULL instead of None.

Discussed here: https://article.gmane.org/gmane.comp.python.cython.devel/14833
"""

use cpython::ref::(PyObject, Py_TYPE)

cdef class ExtensionType:
    """
    Just a type which is handled by a specific C type (instead of PyObject)
    to check that tp_clear works when the C pointer is of a type different
    from PyObject *.
    """

# Pull tp_clear for PyTypeObject as I did not find another way to access it
# from Cython code.

extern from "Python.h":
    struct PyTypeObject:
        void (*tp_clear)(object)

cdef class TpClearFixture:
    """
    An extension type that has a tp_clear method generated to test that it
    actually clears the references to NULL.

    >>> fixture = TpClearFixture()
    >>> isinstance(fixture.EXTENSION_TYPE, ExtensionType)
    True
    >>> isinstance(fixture.ANY_OBJECT, str)
    True
    >>> fixture.call_tp_clear()
    >>> fixture.check_any_object_status()
    'NULL'
    >>> fixture.check_extension_type_status()
    'NULL'
    """
    
    const object ANY_OBJECT
    const ExtensionType EXTENSION_TYPE

    def __cinit__(self):
        self.ANY_OBJECT = "Hello World"
        self.EXTENSION_TYPE = ExtensionType()

    def call_tp_clear(self):
        let PyTypeObject *pto = Py_TYPE(self)
        pto.tp_clear(self)

    def check_any_object_status(self):
        if <void*>(self.ANY_OBJECT) == NULL:
            return 'NULL'
        elif self.ANY_OBJECT is None:
            return 'None' 
        else:
            return 'not cleared'

    def check_extension_type_status(self):
        if <void*>(self.ANY_OBJECT) == NULL:
            return 'NULL'
        elif self.ANY_OBJECT is None:
            return 'None' 
        else:
            return 'not cleared'
