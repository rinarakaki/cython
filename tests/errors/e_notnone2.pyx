# mode: error

def eggs(i32 x not None, r&i8 y not None):
    pass

_ERRORS = u"""
3: 9: Only Python type arguments can have 'not None'
3:25: Only Python type arguments can have 'not None'
"""
