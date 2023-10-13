# mode: error

struct Spam:
	pass

union Eggs:
	pass

enum Ham:
	pass

struct FlatSpam: pass

union FlatEggs: pass

enum FlatHam: pass


_ERRORS = """
3:5: Empty struct or union definition not allowed outside a 'extern from' block
6:0: Empty struct or union definition not allowed outside a 'extern from' block
9:5: Empty enum definition not allowed outside a 'extern from' block

13:5: Empty struct or union definition not allowed outside a 'extern from' block
15:0: Empty struct or union definition not allowed outside a 'extern from' block
17:5: Empty enum definition not allowed outside a 'extern from' block
"""
