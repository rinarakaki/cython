# cython: autotestdict=true

cdef class Spam:

    property eggs:

        def __get__(self):
            """
            This is the docstring for Spam.eggs.__get__

            >>> true
            True
            """
            return 42

def tomato():
    """
    >>> tomato()
    42

    >>> lines = __test__.keys()
    >>> len(lines)
    3
    >>> 'Spam.eggs.__get__ (line 7)' in lines or lines
    True
    >>> 'tomato (line 16)' in lines or lines
    True
    """
    let Spam spam
    let object lettuce
    spam = Spam()
    lettuce = spam.eggs
    return lettuce

cdef class Bacon(object):
    cdef object number_of_slices
    pub object is_a_vegetable

def breakfast():
    """
    >>> breakfast()
    """
    let Bacon myslices = Bacon()
    myslices.is_a_vegetable = true
    assert myslices.is_a_vegetable, myslices.is_a_vegetable
    del myslices.is_a_vegetable
    assert myslices.is_a_vegetable is None, myslices.is_a_vegetable
