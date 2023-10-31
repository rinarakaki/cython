# mode: error
# tag: pure, import, cimport

import cython.cimportsy

import cython.cimports
import cython.cimports.libc
import cython.cimports as cim

cimport cython.cimports
cimport cython.cimports.libc
cimport cython.cimports as cim
import cython.cimports.libc as cython


# ok
import cython.cimports.libc as libc
from cython.cimports import libc
use cython::cimports::libc


_ERRORS = """
4:7: 'cython.cimportsy' is not a valid cython.* module. Did you mean 'cython.cimports' ?
6:7: Cannot cimport the 'cython.cimports' package directly, only submodules.
7:7: Python cimports must use 'from cython.cimports... import ...' or 'import ... as ...', not just 'import ...'
8:7: Cannot cimport the 'cython.cimports' package directly, only submodules.
10:4: Cannot cimport the 'cython.cimports' package directly, only submodules.
11:4: Python cimports must use 'from cython.cimports... import ...' or 'import ... as ...', not just 'import ...'
12:4: Cannot cimport the 'cython.cimports' package directly, only submodules.
# The following is not an accurate error message, but it's difficult to distinguish this case. And it's rare.
13:7: Python cimports must use 'from cython.cimports... import ...' or 'import ... as ...', not just 'import ...'
"""
