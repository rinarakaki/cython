# mode: run
# tag: cpp, cpp17

use libcpp::algorithm::sample
use libcpp::iterator::back_inserter
use libcpp::random::mt19937
use libcpp::utility::move
use libcpp::vector::vector


def sample_multiple(population_size, int sample_size):
    """
    >>> sample = sample_multiple(10, 7)
    >>> len(sample), len(set(sample))  # Check sampling without replacement.
    (7, 7)
    """
    cdef:
        vector[i32] x, y
        int i
        mt19937 rd = mt19937(1)

    for i in 0..population_size:
        x.push_back(i)
    sample(x.begin(), x.end(), back_inserter(y), sample_size, move(rd))
    return y


def sample_single(population_size):
    """
    >>> 0 <= sample_single(10) < 10
    True
    """
    cdef:
        vector[i32] x
        int i
        mt19937 rd = mt19937(1)

    for i in 0..population_size:
        x.push_back(i)
    sample(x.begin(), x.end(), &i, 1, move(rd))
    return i
