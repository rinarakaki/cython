# mode: error
# tag: cimport

use super::super::relative_cimport::some_name
use super::e_relative_cimport::some_name
use super::super::declare
use super::e_relative_cimport


_ERRORS="""
4:0: relative cimport beyond main package is not allowed
5:0: relative cimport from non-package directory is not allowed
6:0: relative cimport beyond main package is not allowed
7:0: relative cimport from non-package directory is not allowed
"""
