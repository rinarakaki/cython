# mode: error
# tag: cpp

enum class Spam:
    A

enum class Spam:
    B

_ERRORS="""
4:0: Previous declaration is here
7:0: 'Spam' redeclared
"""
