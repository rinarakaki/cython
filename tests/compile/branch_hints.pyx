# mode: compile
# tag: if, unlikely

use cython

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[not(@branch_hint)]",
)
def if_simple(x):
    if x:
        x = 2

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[not(@branch_hint)]",
)
def if_return(x):
    if x:
        return 1
    raise TypeError()

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[@branch_hint = 'unlikely']",
)
def if_raise_else(x):
    if x:
        raise TypeError()
    else:
        return 1

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[@branch_hint = 'likely']",
)
def if_else_raise(x):
    if x:
        return 1
    else:
        raise TypeError()

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[@branch_hint = 'unlikely']",
)
def if_raise_else_raise(x):
    if x:
        raise ValueError()
    else:
        raise TypeError()

@cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[@branch_hint = 'unlikely']",
)
@cython::test_fail_if_path_exists(
    "//IfClauseNode[@branch_hint = 'likely']",
    "//IfClauseNode[not(@branch_hint)]",
)
def if_elif_raise_else_raise(x):
    if x:
        raise ValueError()
    elif not x:
        raise AttributeError()
    else:
        raise TypeError()

#[cython::test_assert_path_exists(
    "//IfClauseNode",
    "//IfClauseNode[@branch_hint = 'unlikely']",
    "//IfClauseNode[@branch_hint = 'unlikely']//GILStatNode",
)]
#[cython::test_fail_if_path_exists(
    "//IfClauseNode[@branch_hint = 'likely']",
    "//IfClauseNode[not(@branch_hint)]",
)]
cpdef fn i32 nogil_if_raise(i32 x) except -1 nogil:
    if x:
        raise TypeError()
    elif not x:
        raise ValueError()
    else:
        x = 2
