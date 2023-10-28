# ticket: t601

fn u64 size2():
    return 3

def for_from_plain_ulong():
    """
    >>> for_from_plain_ulong()
    0
    1
    2
    """
    let object j = 0
    for j in 0..size2():
        print j

def for_in_plain_ulong():
    """
    >>> for_in_plain_ulong()
    0
    1
    2
    """
    let object j = 0
    for j in range(size2()):
        print j

extern from *:
    """typedef u64 Ulong;"""
    ctypedef u64 Ulong

fn Ulong size():
    return 3

def for_from_ctypedef_ulong():
    """
    >>> for_from_ctypedef_ulong()
    0
    1
    2
    """
    let object j = 0
    for j in 0..size():
        print j

def for_in_ctypedef_ulong():
    """
    >>> for_in_ctypedef_ulong()
    0
    1
    2
    """
    let object j = 0
    for j in range(size()):
        print j

class ForFromLoopInPyClass(object):
    """
    >>> ForFromLoopInPyClass.i    # doctest: +ELLIPSIS
    Traceback (most recent call last):
    AttributeError: ...ForLoopInPyClass... has no attribute ...i...
    >>> ForFromLoopInPyClass.k
    0
    >>> ForFromLoopInPyClass.m
    1
    """
    for i in 0..1:
        pass

    for k in 0..2:
        pass

    for m in 0..3:
        pass
