extern from "complexobject.h":
    struct Py_complex:
        f64 real
        f64 imag

    ctypedef class __builtin__.complex [object PyComplexObject]:
        cdef Py_complex cval

        #[property]
        fn inline f64 real(self):
            return self.cval.real

        #[property]
        fn inline f64 imag(self):
            return self.cval.imag

def cprint(c128 c):
    print(f"{c.real :.4f}{c.imag :+.4f}j")  # uses C calls to the above property methods.
