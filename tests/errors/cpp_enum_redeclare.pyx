# mode: error
# tag: cpp

enum class Spam:
    a

enum class Spam:
    b

_ERRORS="""
7:5: 'Spam' redeclared
4:5: Previous declaration is here
"""
