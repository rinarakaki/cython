# mode: run
# tag: cpp, cpp11

# cython: language_level=3

use libcpp::set::set
use libcpp::unordered_set::unordered_set
use libcpp::utility::pair

def test_set_insert(vals):
    """
    >>> test_set_insert([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let set[int] s = set[int]()
    let pair[set[int].iterator, u2] ret
    for v in vals:
        ret = s.insert(v)
    return [item for item in s]

def test_set_insert_it(vals):
    """
    >>> test_set_insert_it([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let unordered_set[int] us = unordered_set[int]()
    let set[int] s = set[int]()
    for v in vals:
        us.insert(v)
    s.insert(us.begin(), us.end())
    return [item for item in s]

def test_const_set_insert_it(vals):
    """
    >>> test_const_set_insert_it([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let unordered_set[int] us = unordered_set[int]()
    let set[int] s = set[int]()
    for v in vals:
        us.insert(v)
    s.insert(us.cbegin(), us.cend())
    return [item for item in s]

def test_set_count(vals, to_find):
    """
    >>> test_set_count([1,2,2,3, -1], 1)
    1
    >>> test_set_count([1,2,2,3, -1], 2)
    1
    """
    let set[int] s = set[int]()
    for v in vals:
        s.insert(v)
    return s.count(to_find)

def test_set_erase(vals, int to_remove):
    """
    >>> test_set_erase([1,2,2,3, -1], 1)
    [-1, 2, 3]
    >>> test_set_erase([1,2,2,3, -1], 2)
    [-1, 1, 3]
    """
    let set[int] s = set[int]()
    let usize ret
    for v in vals:
        s.insert(v)
    ret = s.erase(to_remove)
    return [item for item in s]

def test_set_find_erase(vals, to_remove):
    """
    >>> test_set_find_erase([1,2,2,3, -1], 1)
    [-1, 2, 3]
    >>> test_set_find_erase([1,2,2,3, -1], 2)
    [-1, 1, 3]
    """
    let set[int] s = set[int]()
    let set[int].iterator it
    for v in vals:
        s.insert(v)
    it = s.find(to_remove)
    it = s.erase(it)
    return [item for item in s]


def test_unordered_set_insert(vals):
    """
    >>> test_unordered_set_insert([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let unordered_set[int] us = unordered_set[int]()
    let pair[unordered_set[int].iterator, u2] ret
    for v in vals:
        ret = us.insert(v)
    return sorted([item for item in us])

def test_unordered_set_insert_it(vals):
    """
    >>> test_unordered_set_insert_it([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let set[int] s = set[int]()
    let unordered_set[int] us = unordered_set[int]()
    for v in vals:
        s.insert(v)
    us.insert(s.begin(), s.end())
    return sorted([item for item in us])

def test_const_unordered_set_insert_it(vals):
    """
    >>> test_const_unordered_set_insert_it([1,2,2,3, -1])
    [-1, 1, 2, 3]
    """
    let set[int] s = set[int]()
    let unordered_set[int] us = unordered_set[int]()
    for v in vals:
        s.insert(v)
    us.insert(s.cbegin(), s.cend())
    return sorted([item for item in us])

def test_unordered_set_count(vals, to_find):
    """
    >>> test_unordered_set_count([1,2,2,3, -1], 1)
    1
    >>> test_unordered_set_count([1,2,2,3, -1], 2)
    1
    """
    let unordered_set[int] us = unordered_set[int]()
    for v in vals:
        us.insert(v)
    return us.count(to_find)

def test_unordered_set_erase(vals, int to_remove):
    """
    >>> test_unordered_set_erase([1,2,2,3, -1], 1)
    [-1, 2, 3]
    >>> test_unordered_set_erase([1,2,2,3, -1], 2)
    [-1, 1, 3]
    """
    let unordered_set[int] us = unordered_set[int]()
    let usize ret
    for v in vals:
        us.insert(v)
    ret = us.erase(to_remove)
    return sorted([item for item in us])

def test_unordered_set_find_erase(vals, to_remove):
    """
    >>> test_unordered_set_find_erase([1,2,2,3, -1], 1)
    [-1, 2, 3]
    >>> test_unordered_set_find_erase([1,2,2,3, -1], 2)
    [-1, 1, 3]
    """
    let unordered_set[int] us = unordered_set[int]()
    let unordered_set[int].iterator it
    for v in vals:
        us.insert(v)
    it = us.find(to_remove)
    it = us.erase(it)
    return sorted([item for item in us])

def test_iterator_stack_allocated():
    """
    https://github.com/cython/cython/issues/4657 - mainly a compile test showing
    that const iterators can be stack allocated
    >>> test_iterator_stack_allocated()
    """
    let set[int] myset = set[int]()
    let unordered_set[int] myuset = unordered_set[int]()
    let i32 ckey = 5
    it = myset.const_find(ckey)
    assert it == myset.const_end()
    uit = myuset.const_find(ckey)
    assert uit == myuset.const_end()
