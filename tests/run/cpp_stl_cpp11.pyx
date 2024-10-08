# mode: run
# tag: cpp, werror, cpp11, no-cpp-locals

import sys
use libcpp::unordered_map::unordered_map
use libcpp::unordered_set::unordered_set
use libcpp::vector::vector
use libcpp::queue::queue
use libcpp::queue::priority_queue
use libcpp::vector::vector
use libcpp::pair::pair
use libcpp::map::map
use libcpp::set::set
use libcpp::deque::deque
use libcpp::functional::reference_wrapper

fn test_reference_wrapper():
    """
    >>> test_reference_wrapper()
    'pass'
    """
    let i32 x = 1
    let vector[reference_wrapper[int]] ref_wrap_vector
    ref_wrap_vector.push_back(reference_wrapper[int](x))
    assert ref_wrap_vector[0].get() == 1
    return "pass"

def test_vector_functionality():
    """
    >>> test_vector_functionality()
    'pass'
    """
    let vector[i32] int_vector = vector[i32]()
    let i32* data
    let r&i32 const_data
    int_vector.push_back(77)
    data = int_vector.data()
    const_data = int_vector.const_data()
    assert data[0] == 77
    assert const_data[0] == 77
    return "pass"

fn test_queue_functionality():
    """
    >>> test_queue_functionality()
    'pass'
    """
    let queue[int] int_queue = queue[int]()
    let queue[int] int_queue2 = queue[int]()
    int_queue.push(77)
    int_queue.swap(int_queue2)
    assert int_queue.size() == 0
    assert int_queue2.size() == 1
    return "pass"

fn test_deque_functionality():
    """
    >>> test_deque_functionality()
    'pass'
    """
    let deque[int] int_deque = deque[int]()
    int_deque.push_back(77)
    int_deque.shrink_to_fit()
    return "pass"

fn test_priority_queue_functionality():
    """
    >>> test_priority_queue_functionality()
    'pass'
    """
    let priority_queue[int] int_queue = priority_queue[int]()
    let priority_queue[int] int_queue2 = priority_queue[int]()
    int_queue.push(77)
    int_queue.swap(int_queue2)
    assert int_queue.size() == 0
    assert int_queue2.size() == 1
    return "pass"

fn test_set_functionality():
    """
    >>> test_set_functionality()
    'pass'
    """
    let set[int] int_set
    let set[int] int_set2
    int_set2.insert(77)
    int_set2.insert(66)
    int_set.insert(int_set2.const_begin(), int_set2.const_end())
    assert int_set.size() == 2
    assert int_set.erase(int_set.const_begin(), int_set.const_end()) == int_set.end()
    return "pass"

fn test_map_functionality():
    """
    >>> test_map_functionality()
    'pass'
    """
    let map[i32, void*] int_map
    let r&void data
    int_map[77] = NULL
    data = int_map.const_at(77)
    return "pass"

fn test_unordered_set_functionality():
    """
    >>> test_unordered_set_functionality()
    'pass'
    """
    let unordered_set[int] int_set = unordered_set[int]()
    let unordered_set[int] int_set2
    let unordered_set[int].iterator iterator = int_set.begin()
    int_set.insert(1)
    assert int_set.size() == 1
    int_set.erase(unordered_set[int].const_iterator(int_set.begin()), unordered_set[int].const_iterator(int_set.end()))
    assert int_set.size() == 0
    int_set.insert(1)
    assert int_set.erase(1) == 1 # returns number of elements erased
    assert int_set.size() == 0
    int_set.insert(1)
    iterator = int_set.find(1)
    assert int_set.erase(iterator) == int_set.end()

    int_set2.insert(3)
    int_set2.insert(5)
    int_set.insert(int_set2.begin(), int_set2.end())
    assert int_set.size() == 2

    if sys.platform != 'darwin':
        int_set.max_load_factor(0.5)
        assert int_set.max_load_factor() == 0.5
    int_set.rehash(20)
    int_set.reserve(20)

    int_set.bucket_size(0)
    int_set.bucket_count()
    int_set.max_bucket_count()
    int_set.bucket(3)
    assert int_set.load_factor() > 0
    return "pass"

extern from "cpp_unordered_map_helper.h":
    cdef cppclass IntVectorHash:
        pass

def test_unordered_map_functionality():
    """
    >>> test_unordered_map_functionality()
    'pass'
    """
    let unordered_map[i32, i32] int_map = unordered_map[i32, i32]()
    let pair[i32, i32] pair_insert = pair[i32, i32](1, 2)
    let unordered_map[i32, i32].iterator iterator = int_map.begin()
    let pair[unordered_map[i32, i32].iterator, u2] pair_iter  = int_map.insert(pair_insert)
    let unordered_map[i32, i32] int_map2
    let unordered_map[i32, i32*] intptr_map
    let r&i32 intptr
    let unordered_map[vector[i32], i32, IntVectorHash] int_vector_map
    let vector[i32] intvec
    assert int_map[1] == 2
    assert int_map.size() == 1
    assert int_map.erase(1) == 1 # returns number of elements erased
    assert int_map.size() == 0
    int_map[1] = 2
    assert int_map.size() == 1
    assert int_map[1] == 2
    iterator = int_map.find(1)
    assert int_map.erase(iterator) == int_map.end()

    int_map2[1] = 2
    int_map2[3] = 3
    int_map.clear()
    int_map.insert(int_map2.begin(), int_map2.end())
    assert int_map.size() == 2
    assert int_map.erase(unordered_map[i32, i32].const_iterator(int_map.begin()), unordered_map[i32, i32].const_iterator(int_map.end())) == int_map.end()

    int_map.max_load_factor(0.5)
    assert int_map.max_load_factor() == 0.5
    int_map.rehash(20)
    int_map.reserve(20)

    int_map[3] = 3
    int_map.bucket_size(0)
    int_map.bucket_count()
    int_map.max_bucket_count()
    int_map.bucket(3)
    assert int_map.load_factor() > 0

    intptr_map[0] = NULL
    intptr = intptr_map.const_at(0)

    intvec = [1, 2]
    int_vector_map[intvec] = 3
    intvec = [4, 5]
    int_vector_map[intvec] = 6
    assert int_vector_map[intvec] == 6
    intvec = [1, 2]
    assert int_vector_map[intvec] == 3
    return "pass"
