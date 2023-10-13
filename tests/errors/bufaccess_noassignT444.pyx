# ticket: t444
# mode: error

def test():
     let object[int] not_assigned_to
     not_assigned_to[2] = 3

_ERRORS = """
6:5: local variable 'not_assigned_to' referenced before assignment
"""
