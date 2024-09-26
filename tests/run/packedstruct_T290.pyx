# ticket: t290

"""
>>> f()
(9, 9)
"""

#[repr(packed)]
struct MyCdefStruct:
    i8 a
    f64 b

#[repr(packed)]
ctypedef struct MyCTypeDefStruct:
    i8 a
    f64 b

def f():
    return (sizeof(MyCdefStruct), sizeof(MyCTypeDefStruct))
