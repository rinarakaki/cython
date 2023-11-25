# mode: error

type     string_t = r&i8
pub type public_string_t = r&i8
api type api_string_t = r&i8

# This should all fail
pub fn pub_func1(string_t x):
    pass

api fn api_func1(string_t x):
    pass

pub fn string_t pub_func2():
    pass

api fn string_t api_func2():
    pass

pub fn opt_pub_func(x = None):
    pass

api fn opt_api_func(x = None):
    pass

# This should all work
pub fn pub_func3(public_string_t x, api_string_t y):
    pass

api fn api_func3(public_string_t x, api_string_t y):
    pass

fn opt_func(x = None):
    pass

_ERRORS = u"""
e_public_cdef_private_types.pyx:8:14: Function declared public or api may not have private types
e_public_cdef_private_types.pyx:11:19: Function declared public or api may not have private types
e_public_cdef_private_types.pyx:14:0: Function declared public or api may not have private types
e_public_cdef_private_types.pyx:17:5: Function declared public or api may not have private types
e_public_cdef_private_types.pyx:20:16: Function with optional arguments may not be declared public or api
e_public_cdef_private_types.pyx:23:21: Function with optional arguments may not be declared public or api
"""
