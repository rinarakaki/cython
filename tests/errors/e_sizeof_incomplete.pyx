# mode: error

struct unbekannt
let int n
n = sizeof(unbekannt)
_ERRORS = """
5:4: Cannot take sizeof incomplete type 'unbekannt'
"""
