# mode: error
# tag: cpp, cpp11

fn foo(object& x): pass
fn bar(object&& x): pass

_ERRORS="""
4:15: Reference base type cannot be a Python object
5:15: Rvalue-reference base type cannot be a Python object
"""
