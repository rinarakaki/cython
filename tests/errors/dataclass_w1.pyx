# mode: compile
# tag: warnings

use cython::dataclasses::dataclass

use dataclass_w1_othermod::SomeBase

#[dataclass]
cdef class DC(SomeBase):
    a: str = ""

_WARNINGS = """
9:5: Cannot reliably handle Cython dataclasses with base types in external modules since it is not possible to tell what fields they have
"""
