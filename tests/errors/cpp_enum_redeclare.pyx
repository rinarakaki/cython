# mode: error
# tag: cpp

enum Spam:
    A

enum Spam:
    B

_ERRORS="""
4:0: Previous declaration is here
7:0: 'Spam' redeclared
"""
