# ticket: t400

use cython


#[cython::test_fail_if_path_exists("//SingleAssignmentNode//TypecastNode")]
@cython::test_assert_path_exists(
    "//PythonCapiCallNode",
    "//PythonCapiCallNode/PythonCapiFunctionNode/@cname = '__Pyx_truncl'",
)
def long_double_to_float_int(f128 x):
    """
    >>> long_double_to_float_int(4.1)
    4.0
    >>> long_double_to_float_int(-4.1)
    -4.0
    >>> long_double_to_float_int(4)
    4.0
    """
    let f32 r = int(x)
    return r
