# ticket: t290

"""
>>> f()
(9, 9)
"""

#[repr(packed)]
struct MyCdefStruct:
    char a
    f64 b

#[repr(packed)]
struct MyCTypeDefStruct:
    char a
    f64 b

def f():
    return (sizeof(MyCdefStruct), sizeof(MyCTypeDefStruct))
