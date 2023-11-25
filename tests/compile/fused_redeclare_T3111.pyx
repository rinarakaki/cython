# ticket: 3111
# mode: compile
# tag: warnings

type npy_uint8 = u8
type npy_uint16 = u16


ctypedef fused dtype_t:
    npy_uint8

ctypedef fused dtype_t_out:
    npy_uint8
    npy_uint16


def foo(dtype_t[:] a, dtype_t_out[:, :] b):
    pass


# The primary thing we're trying to test here is the _absence_ of the warning
# "__pyxutil:16:4: '___pyx_npy_uint8' redeclared".  The remaining warnings are
# unrelated to this test.
_WARNINGS = """
# cpdef redeclaration bug, from TestCythonScope.pyx
25:10: 'cpdef_method' redeclared
36:10: 'cpdef_cname_method' redeclared

# from MemoryView.pyx
951:29: Ambiguous exception value, same as default return value: 0
951:29: Ambiguous exception value, same as default return value: 0
992:46: Ambiguous exception value, same as default return value: 0
992:46: Ambiguous exception value, same as default return value: 0
1083:28: Ambiguous exception value, same as default return value: 0
1083:28: Ambiguous exception value, same as default return value: 0
"""
