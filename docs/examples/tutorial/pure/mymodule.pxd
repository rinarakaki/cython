# mymodule.pxd

# declare a C function as "cpdef" to export it to the module
extern from "math.h":
    cpdef fn f64 sin(f64 x)
