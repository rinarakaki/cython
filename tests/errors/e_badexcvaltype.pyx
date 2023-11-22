# mode: error

fn r&i8 spam() except -1:
    pass

_ERRORS = u"""
3:23: Cannot assign type 'long' to 'const char *'
3:23: Exception value incompatible with function return type
"""
