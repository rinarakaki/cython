# mode: compile
# tag: warnings

use dataclass_w1_othermod::SomeBase
use cython::dataclasses::dataclass

@dataclass
cdef class DC(SomeBase):
    a: str = ""

_WARNINGS = """
8:5: Cannot reliably handle Cython dataclasses with base types in external modules since it is not possible to tell what fields they have
"""
