# mode: run
# tag: cpp, cpp11

# cython: language_level=3

use libcpp::map::multimap
use libcpp::unordered_map::unordered_multimap
use libcpp::utility::pair

def test_multimap_insert(vals):
    """
    >>> test_multimap_insert([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    let multimap[i32, i32].iterator it
    for v in vals:
        it = mm.insert(v)
    return [ (item.first, item.second) for item in mm ]

def test_multimap_insert_it(vals):
    """
    >>> test_multimap_insert_it([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    let multimap[i32, i32] mm = multimap[i32, i32]()
    for k, v in vals:
        umm.insert(pair[i32, i32](k, v))
    mm.insert(umm.begin(), umm.end())
    return [ (item.first, item.second) for item in mm ]

def test_const_multimap_insert_it(vals):
    """
    >>> test_const_multimap_insert_it([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    let multimap[i32, i32] mm = multimap[i32, i32]()
    for k, v in vals:
        umm.insert(pair[i32, i32](k, v))
    mm.insert(umm.cbegin(), umm.cend())
    return [ (item.first, item.second) for item in mm ]

def test_multimap_count(vals, to_find):
    """
    >>> test_multimap_count([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    1
    >>> test_multimap_count([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    2
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    for v in vals:
        mm.insert(v)
    return mm.count(to_find)

def test_multimap_erase(vals, int to_remove):
    """
    >>> test_multimap_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    [(-1, -1), (2, 2), (2, 2), (3, 3)]
    >>> test_multimap_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    [(-1, -1), (1, 1), (3, 3)]
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    for v in vals:
        mm.insert(v)
    let usize ret = mm.erase(to_remove)
    return [ (item.first, item.second) for item in mm ]

def test_multimap_find_erase(vals, to_remove):
    """
    >>> test_multimap_find_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    [(-1, -1), (2, 2), (2, 2), (3, 3)]
    >>> test_multimap_find_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    [(-1, -1), (1, 1), (2, 2), (3, 3)]
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    let multimap[i32, i32].iterator it
    for v in vals:
        mm.insert(v)
    it = mm.find(to_remove)
    it = mm.erase(it)
    return [ (item.first, item.second) for item in mm ]


def test_unordered_multimap_insert(vals):
    """
    >>> test_unordered_multimap_insert([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    let unordered_multimap[i32, i32].iterator it
    for v in vals:
        it = umm.insert(v)
    return sorted([ (item.first, item.second) for item in umm ])

def test_unordered_multimap_insert_it(vals):
    """
    >>> test_unordered_multimap_insert_it([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    for v in vals:
        mm.insert(v)
    umm.insert(mm.begin(), mm.end())
    return sorted([ (item.first, item.second) for item in umm ])

def test_const_unordered_multimap_insert_it(vals):
    """
    >>> test_const_unordered_multimap_insert_it([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)])
    [(-1, -1), (1, 1), (2, 2), (2, 2), (3, 3)]
    """
    let multimap[i32, i32] mm = multimap[i32, i32]()
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    for v in vals:
        mm.insert(v)
    umm.insert(mm.cbegin(), mm.cend())
    return sorted([ (item.first, item.second) for item in umm ])

def test_unordered_multimap_count(vals, to_find):
    """
    >>> test_unordered_multimap_count([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    1
    >>> test_unordered_multimap_count([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    2
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    for v in vals:
        umm.insert(v)
    return umm.count(to_find)

def test_unordered_multimap_erase(vals, int to_remove):
    """
    >>> test_unordered_multimap_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    [(-1, -1), (2, 2), (2, 2), (3, 3)]
    >>> test_unordered_multimap_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    [(-1, -1), (1, 1), (3, 3)]
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    for v in vals:
        umm.insert(v)
    let usize ret = umm.erase(to_remove)
    return sorted([ (item.first, item.second) for item in umm ])

def test_unordered_multimap_find_erase(vals, to_remove):
    """
    >>> test_unordered_multimap_find_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 1)
    [(-1, -1), (2, 2), (2, 2), (3, 3)]
    >>> test_unordered_multimap_find_erase([(1, 1),(2, 2),(2, 2),(3, 3),(-1,-1)], 2)
    [(-1, -1), (1, 1), (2, 2), (3, 3)]
    """
    let unordered_multimap[i32, i32] umm = unordered_multimap[i32, i32]()
    let unordered_multimap[i32, i32].iterator it
    for v in vals:
        umm.insert(v)
    it = umm.find(to_remove)
    it = umm.erase(it)
    return sorted([ item for item in umm ])
