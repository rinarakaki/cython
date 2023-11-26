# ticket: t290

"""
>>> f()
(9, 9)
"""

packed struct MyCdefStruct:
    i8 a
    f64 b

ctypedef packed struct MyCTypeDefStruct:
    i8 a
    f64 b

def f():
    return (sizeof(MyCdefStruct), sizeof(MyCTypeDefStruct))
