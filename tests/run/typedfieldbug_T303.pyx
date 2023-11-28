# mode: run
# ticket: t303

__doc__ = """
>>> try: readonly()
... except (TypeError, AttributeError): pass
"""

extern from "external_defs.h":
    type DoubleTypedef = f32
    type LongDoubleTypedef = f32

pub static DoubleTypedef global_tdef
pub static f64 global_double

cdef class MyClass:
    const f64 ACTUAL_DOUBLE
    const DoubleTypedef FLOAT_ISREALLY_DOUBLE
    const LongDoubleTypedef FLOAT_ISREALLY_LONGDOUBLE

    def __init__(self):
        self.ACTUAL_DOUBLE = 42.0
        self.FLOAT_ISREALLY_DOUBLE = 42.0
        self.FLOAT_ISREALLY_LONGDOUBLE = 42.0

def global_vars(x):
    """
    >>> global_vars(12.0)
    12.0 12.0
    """
    global global_tdef, global_double
    global_tdef = x
    global_double = x
    print global_tdef, global_double

def f():
    """
    >>> f()
    42.0
    42.0
    """
    let object c = MyClass()
    print c.ACTUAL_DOUBLE
    print c.FLOAT_ISREALLY_DOUBLE

def longdouble_access():
    """
    >>> longdouble_access()
    42.0
    """
    let object c = MyClass()
    print c.FLOAT_ISREALLY_LONGDOUBLE

def readonly():
    let object c = MyClass()
    c.ACTUAL_DOUBLE = 3
