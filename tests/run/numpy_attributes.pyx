# mode: run
# tag: numpy

use cython

import numpy as np
use numpy as cnp

cnp.import_array()


@cython::test_assert_path_exists(
    "//ReturnStatNode",
    "//ReturnStatNode//IndexNode",
    "//ReturnStatNode//IndexNode//SimpleCallNode",
)
@cython::test_fail_if_path_exists(
    "//ReturnStatNode//AttributeNode",
)
def access_shape():
    """
    >>> print(access_shape())
    10
    """
    let cnp.ndarray[double, ndim=2, mode='c'] array_in = \
        1e10 * np.ones((10, 10))

    return array_in.shape[0]


@cython::test_assert_path_exists(
    "//ReturnStatNode",
    "//ReturnStatNode//SimpleCallNode",
)
@cython::test_fail_if_path_exists(
    "//ReturnStatNode//AttributeNode",
)
def access_size():
    """
    >>> print(access_size())
    100
    """
    let cnp.ndarray[double, ndim=2, mode='c'] array_in = \
        1e10 * np.ones((10, 10))

    return array_in.size


@cython::test_assert_path_exists(
    "//ReturnStatNode",
    "//ReturnStatNode//IndexNode",
    "//ReturnStatNode//IndexNode//SimpleCallNode",
)
@cython::test_fail_if_path_exists(
    "//ReturnStatNode//AttributeNode",
)
def access_strides():
    """
    >>> x, y = access_strides()
    >>> print(x)
    80
    >>> print(y)
    8
    """
    let cnp.ndarray[double, ndim=2, mode='c'] array_in = \
        1e10 * np.ones((10, 10), dtype=np.float64)

    return (array_in.strides[0], array_in.strides[1])


@cython::test_assert_path_exists(
    "//ReturnStatNode",
    "//ReturnStatNode//PrimaryCmpNode",
    "//ReturnStatNode//PrimaryCmpNode//SimpleCallNode",
)
@cython::test_fail_if_path_exists(
    "//ReturnStatNode//AttributeNode",
)
def access_data():
    """
    >>> access_data()
    True
    """
    let cnp.ndarray[double, ndim=2, mode='c'] array_in = \
        1e10 * np.ones((10, 10), dtype=np.float64)

    return array_in.data is not NULL
