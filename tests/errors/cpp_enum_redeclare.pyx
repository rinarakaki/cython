# mode: error
# tag: cpp

enum class Spam:
    A

enum class Spam:
    B

_ERRORS="""
7:5: 'Spam' redeclared
4:5: Previous declaration is here
"""
