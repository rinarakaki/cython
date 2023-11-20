use super::object::(PyObject, PyTypeObject)

extern from "Python.h":
    type wrapperfunc = object(self, args, void* wrapped)
    type wrapperfunc_kwds = object(self, args, void* wrapped, kwds)

    struct wrapperbase:
        char* name
        i32 offset
        void* function
        wrapperfunc wrapper
        char* doc
        i32 flags
        PyObject* name_strobj

    static i32 PyWrapperFlag_KEYWORDS

    ctypedef class __builtin__.wrapper_descriptor [object PyWrapperDescrObject]:
        cdef type d_type
        cdef d_name
        cdef wrapperbase* d_base
        cdef void* d_wrapped

    fn object PyDescr_NewWrapper(PyTypeObject* cls, wrapperbase* wrapper, void* wrapped)

    fn i32 PyDescr_IsData(descr)
