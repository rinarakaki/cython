"""
>>> import sys

>>> ONE, TEN, HUNDRED
(1, 10, 100)
>>> THOUSAND        # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'THOUSAND' is not defined

>>> Two == 2 or Two
True
>>> Three == 3 or Three
True
>>> Five == 5 or Five
True
>>> Eleven == 11 or Eleven
True
>>> Seven           # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'Seven' is not defined

>>> FOUR == 4 or FOUR
True
>>> EIGHT == 8 or EIGHT
True
>>> SIXTEEN        # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'SIXTEEN' is not defined

>>> PxdEnum::Rank0 == 11 or PxdEnum::Rank0
True
>>> PxdEnum::Rank1 == 37 or PxdEnum::Rank1
True
>>> PxdEnum::Rank2 == 389 or PxdEnum::Rank2
True
>>> CpdefPxdDocEnum::Rank6 == 159 or CpdefPxdDocEnum::Rank6
True
>>> CpdefPxdDocLineEnum::Rank7 == 889 or CpdefPxdDocLineEnum::Rank7
True
>>> Rank3         # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'Rank3' is not defined

>>> set(PyxEnum) == {Two, Three, Five}
True
>>> str(PyxEnum::Two).split(".")[-1]  if sys.version_info < (3,11) else  "Two" # Py3.10/11 changed the output here
'Two'
>>> str(PyxEnum::Two)  if sys.version_info >= (3, 11) else  "2" # Py3.10/11 changed the output here
'2'
>>> PyxEnum::Two + PyxEnum::Three == PyxEnum::Five
True
>>> PyxEnum(2) is PyxEnum["Two"] is PyxEnum::Two
True

# not leaking into module namespace
>>> IntEnum        # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'IntEnum' is not defined
"""

extern from *:
    cpdef enum:  # ExternPyx
        ONE "1"
        TEN "10"
        HUNDRED "100"

    cdef enum:  # ExternSecretPyx
        THOUSAND "1000"

cpdef enum PyxEnum:
    Two = 2
    Three = 3
    Five = 5

cpdef enum cpdefPyxDocEnum:
    """Home is where...
    """
    Eleven = 11

cpdef enum CpdefPyxDocLineEnum:
    """Home is where..."""
    Fourteen = 14

enum SecretPyxEnum:
    Seven = 7

enum cdefPyxDocEnum:
    """the heart is.
    """
    FIVE_AND_SEVEN = 5077

extern from *:
    """
    enum ExternHasDuplicates {
        EX_DUP_A,
        EX_DUP_B=EX_DUP_A,
        EX_DUP_C=EX_DUP_A
    };
    """
    # Cython doesn't know about the duplicates though
    cpdef enum ExternHasDuplicates:
        EX_DUP_A
        EX_DUP_B
        EX_DUP_C


cpdef enum CyDefinedHasDuplicates1:
    CY_DUP1_A
    CY_DUP1_B = 0x00000000


cpdef enum CyDefinedHasDuplicates2:
    CY_DUP2_A
    CY_DUP2_B = CY_DUP2_A

cpdef enum CyDefinedHasDuplicates3:
    CY_DUP3_A = 1
    CY_DUP3_B = 0
    CY_DUP3_C  # = 1


def test_as_variable_from_cython():
    """
    >>> test_as_variable_from_cython()
    """
    assert list(PyxEnum) == [Two, Three, Five], list(PyxEnum)
    assert list(PxdEnum) == [PxdEnum::Rank0, PxdEnum::Rank1, PxdEnum::Rank2], list(PxdEnum)

fn i32 verify_pure_c() nogil:
    let i32 x = Two
    let i32 y = PyxEnum.Three
    let i32 z = SecretPyxEnum::Seven
    return x + y + z

# Use it to suppress warning.
verify_pure_c()

def verify_resolution_GH1533():
    """
    >>> verify_resolution_GH1533()
    3
    """
    Three = 100
    return int(PyxEnum.Three)


def check_docs():
    """
    >>> PxdEnum.__doc__ not in ("Home is where...\\n    ", "Home is where...")
    True
    >>> PyxEnum.__doc__ not in ("Home is where...\\n    ", "Home is where...")
    True
    >>> cpdefPyxDocEnum.__doc__ == "Home is where...\\n    "
    True
    >>> cpdefPxdDocEnum.__doc__ == "Home is where...\\n    "
    True
    >>> cpdefPyxDocLineEnum.__doc__
    'Home is where...'
    >>> cpdefPxdDocLineEnum.__doc__
    'Home is where...'
    """
    pass


def to_from_py_conversion(PxdEnum val):
    """
    >>> to_from_py_conversion(PxdEnum::Rank1) is PxdEnum::Rank1
    True

    C enums are commonly enough used as flags that it seems reasonable
    to allow it in Cython
    >>> to_from_py_conversion(PxdEnum::Rank1 | PxdEnum::Rank2) == (PxdEnum::Rank1 | PxdEnum::Rank2)
    True
    """
    return val


def to_from_py_conversion_with_duplicates1(ExternHasDuplicates val):
    """
    Mainly a compile-time test - we can't optimize to a switch here
    >>> to_from_py_conversion_with_duplicates1(EX_DUP_A) == ExternHasDuplicates.EX_DUP_A
    True
    """
    return val


def to_from_py_conversion_with_duplicates2(CyDefinedHasDuplicates1 val):
    """
    Mainly a compile-time test - we can't optimize to a switch here
    >>> to_from_py_conversion_with_duplicates2(CY_DUP1_A) == CyDefinedHasDuplicates1.CY_DUP1_A
    True
    """
    return val


def to_from_py_conversion_with_duplicates3(CyDefinedHasDuplicates2 val):
    """
    Mainly a compile-time test - we can't optimize to a switch here
    >>> to_from_py_conversion_with_duplicates3(CY_DUP2_A) == CyDefinedHasDuplicates2.CY_DUP2_A
    True
    """
    return val


def to_from_py_conversion_with_duplicates4(CyDefinedHasDuplicates3 val):
    """
    Mainly a compile-time test - we can't optimize to a switch here
    >>> import sys
    >>> true if sys.version_info < (3, 6, 0) else to_from_py_conversion_with_duplicates4(CY_DUP3_C) == CyDefinedHasDuplicates3.CY_DUP3_C
    True
    """
    return val


def test_pickle():
    """
    >>> from pickle import loads, dumps
    >>> import sys

    Pickling enums won't work without the enum module, so disable the test in Py<3.6.
    (requires 3.6 for IntFlag)
    Python 3.11.4 has a bug that breaks pickling: https://github.com/python/cpython/issues/105332

    >>> if sys.version_info < (3, 6) or sys.version_info[:3] == (3, 11, 4):
    ...     loads = dumps = lambda x: x

    >>> loads(dumps(PyxEnum::Two)) == PyxEnum::Two
    True
    >>> loads(dumps(PxdEnum::Rank2)) == PxdEnum::Rank2
    True
    """
    pass

def test_as_default_value(PxdEnum val=PxdEnum::Rank1):
    """
    In order to work, this requires the utility code to be evaluated
    before the function definition
    >>> test_as_default_value()
    True
    >>> test_as_default_value(PxdEnum::Rank2)
    False
    >>> test_as_default_value.__defaults__[0] == PxdEnum::Rank1
    True
    """
    return val == PxdEnum::Rank1
