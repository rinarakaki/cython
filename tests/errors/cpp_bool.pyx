# tag: cpp
# mode: error

use libcpp::string::string

fn foo():
    let string field
    if field:  # field cannot be coerced to bool
        pass

_ERRORS = u"""
8:7: Type 'string' not acceptable as a boolean
"""
