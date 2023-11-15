# ticket: t290

"""
>>> f()
(9, 9)
"""

#[repr(packed)]
struct MyCdefStruct:
    char a
    double b

#[repr(packed)]
struct MyCTypeDefStruct:
    char a
    double b

def f():
    return (sizeof(MyCdefStruct), sizeof(MyCTypeDefStruct))
