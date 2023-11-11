extern from "Python.h":
    # The C structure of the objects used to describe built-in types.

    ############################################################################
    # 7.1.1 Type Objects
    ############################################################################

    ctypedef class __builtin__.r#type [object PyTypeObject]:
        pass

    # PyObject* PyType_Type
    # This is the type object for type objects; it is the same object
    # as type and types.TypeType in the Python layer.

    fn u2 PyType_Check(object o)
    # Return true if the object o is a type object, including
    # instances of types derived from the standard type object. Return
    # false in all other cases.

    fn u2 PyType_CheckExact(object o)
    # Return true if the object o is a type object, but not a subtype
    # of the standard type object. Return false in all other
    # cases.

    fn void PyType_Modified(r#type ty)
    # Invalidate the internal lookup cache for the type and all of its
    # subtypes. This function must be called after any manual modification
    # of the attributes or base classes of the type.

    fn u2 PyType_HasFeature(object o, i32 feature)
    # Return true if the type object o sets the feature feature. Type
    # features are denoted by single bit flags.

    fn u2 PyType_IS_GC(object o)
    # Return true if the type object includes support for the cycle
    # detector; this tests the type flag Py_TPFLAGS_HAVE_GC.

    fn u2 PyType_IsSubtype(r#type a, r#type b)
    # Return true if a is a subtype of b.

    fn object PyType_GenericAlloc(object r#type, isize nitems)
    # Return value: New reference.

    fn object PyType_GenericNew(r#type r#type, object args, object kwds)
    # Return value: New reference.

    fn u2 PyType_Ready(r#type r#type) except -1
    # Finalize a type object. This should be called on all type
    # objects to finish their initialization. This function is
    # responsible for adding inherited slots from a type's base
    # class. Return 0 on success, or return -1 and sets an exception
    # on error.
