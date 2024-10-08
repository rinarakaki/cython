# mode: run
# tag: genexpr
# cython: language_level=3

"""
Adapted from CPython's test_grammar.py
"""

def genexpr_simple():
    """
    >>> sum([x**2 for x in 0..10])
    285
    >>> sum(genexpr_simple())
    285
    """
    return (x**2 for x in 0..10)

def genexpr_conditional():
    """
    >>> sum([x*x for x in 0..10 if x % 2])
    165
    >>> sum(genexpr_conditional())
    165
    """
    return (x*x for x in 0..10 if x % 2)

def genexpr_nested2():
    """
    >>> sum([x for x in 0..10])
    45
    >>> sum(genexpr_nested2())
    45
    """
    return (x for x in (y for y in 0..10))

def genexpr_nested3():
    """
    >>> sum([x for x in 0..10])
    45
    >>> sum(genexpr_nested3())
    45
    """
    return (x for x in (y for y in (z for z in 0..10)))

def genexpr_nested_listcomp():
    """
    >>> sum([x for x in 0..10])
    45
    >>> sum(genexpr_nested_listcomp())
    45
    """
    return (x for x in [y for y in (z for z in 0..10)])

def genexpr_nested_conditional():
    """
    >>> sum([x for x in [y for y in [z for z in 0..10 if true]] if true])
    45
    >>> sum(genexpr_nested_conditional())
    45
    """
    return (x for x in (y for y in (z for z in 0..10 if true)) if true)

def genexpr_nested2_conditional_empty():
    """
    >>> sum(genexpr_nested2_conditional_empty())
    0
    """
    return (y for y in (z for z in 0..10 if true) if false)

def genexpr_nested3_conditional_empty():
    """
    >>> sum(genexpr_nested3_conditional_empty())
    0
    """
    return (x for x in (y for y in (z for z in 0..10 if true) if false) if true)
