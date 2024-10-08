extern from "Python.h":
    struct Py_complex:
        f64 imag
        f64 real

    # ##########################################################################
    # 7.2.5.2 Complex Numbers as Python Objects
    # ##########################################################################

    # PyComplexObject
    # This subtype of PyObject represents a Python complex number object.

    ctypedef class __builtin__.complex [object PyComplexObject]:
        cdef Py_complex cval

        #[property]
        fn inline f64 real(self):
            return self.cval.real

        #[property]
        fn inline f64 imag(self):
            return self.cval.imag

    # static PyTypeObject PyComplex_Type
    # This instance of PyTypeObject represents the Python complex
    # number type. It is the same object as complex and
    # types.ComplexType.

    fn u2 PyComplex_Check(object p)
    # Return true if its argument is a PyComplexObject or a subtype of
    # PyComplexObject.

    fn u2 PyComplex_CheckExact(object p)
    # Return true if its argument is a PyComplexObject, but not a subtype of PyComplexObject.

    fn object PyComplex_FromCComplex(Py_complex v)
    # Return value: New reference.
    # Create a new Python complex number object from a C Py_complex value.

    fn object PyComplex_FromDoubles(f64 real, f64 imag)
    # Return value: New reference.
    # Return a new PyComplexObject object from real and imag.

    fn f64 PyComplex_RealAsDouble(object op) except? -1
    # Return the real part of op as a C f64.

    fn f64 PyComplex_ImagAsDouble(object op) except? -1
    # Return the imaginary part of op as a C double.

    fn Py_complex PyComplex_AsCComplex(object op)
    # Return the Py_complex value of the complex number op.
    #
    # Returns (-1+0i) in case of an error
