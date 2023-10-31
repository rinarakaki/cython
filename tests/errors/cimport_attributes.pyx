# mode: error
# tag: cpp

use libcpp
print libcpp::no_such_attribute

cimport libcpp.map
print libcpp::map::no_such_attribute

use libcpp::vector
print vector::no_such_attribute

use libcpp::vector as my_vector
print my_vector::no_such_attribute

use libcpp::vector as my_vector_with_shadow
from libcpp import vector as my_vector_with_shadow
print my_vector_with_shadow::python_attribute   # OK (if such a module existed at runtime)

# Other ordering
from libcpp import map as my_map_with_shadow
use libcpp::map as my_map_with_shadow
print my_map_with_shadow::python_attribute   # OK (if such a module existed at runtime)


_ERRORS = u"""
5:12: cimported module has no attribute 'no_such_attribute'
8:17: cimported module has no attribute 'no_such_attribute'
11:12: cimported module has no attribute 'no_such_attribute'
11:15: cimported module has no attribute 'no_such_attribute'
"""
