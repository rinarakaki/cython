extern from "Python.h":
    """
    #if PY_MAJOR_VERSION >= 3
      #define __Pyx_PyFloat_FromString(obj)  PyFloat_FromString(obj)
    #else
      #define __Pyx_PyFloat_FromString(obj)  PyFloat_FromString(obj, NULL)
    #endif
    """

    # ##########################################################################
    # 7.2.3
    # ##########################################################################
    # PyFloatObject
    #
    # This subtype of PyObject represents a Python floating point object.

    # PyTypeObject PyFloat_Type
    #
    # This instance of PyTypeObject represents the Python floating
    # point type. This is the same object as float and
    # types.FloatType.

    fn u2 PyFloat_Check(object p)
    # Return true if its argument is a PyFloatObject or a subtype of
    # PyFloatObject.

    fn u2 PyFloat_CheckExact(object p)
    # Return true if its argument is a PyFloatObject, but not a
    # subtype of PyFloatObject.

    fn object PyFloat_FromString "__Pyx_PyFloat_FromString" (object str)
    # Return value: New reference.
    # Create a PyFloatObject object based on the string value in str,
    # or NULL on failure. The pend argument is ignored. It remains
    # only for backward compatibility.

    fn object PyFloat_FromDouble(f64 v)
    # Return value: New reference.
    # Create a PyFloatObject object from v, or NULL on failure.

    fn f64 PyFloat_AsDouble(object pyfloat) except? -1
    # Return a C double representation of the contents of pyfloat.

    fn f64 PyFloat_AS_DOUBLE(object pyfloat)
    # Return a C double representation of the contents of pyfloat, but
    # without error checking.
