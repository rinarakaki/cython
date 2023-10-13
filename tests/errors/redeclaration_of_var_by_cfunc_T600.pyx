# ticket: 600
# mode: error

cdef class Bar:
    let list _operands

    fn int _operands(self):
        return -1


_ERRORS = """
7:9: '_operands' redeclared
5:14: Previous declaration is here
"""
