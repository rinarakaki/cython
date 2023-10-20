# mode: error

let signed   float       e
let unsigned float       f
let signed   double      g
let unsigned double      h
let signed   long double i
let unsigned long double j


_ERRORS = u"""
3:5: Unrecognised type modifier combination: (2, 0, float)
4:5: Unrecognised type modifier combination: (0, 0, float)
5:5: Unrecognised type modifier combination: (2, 0, double)
6:5: Unrecognised type modifier combination: (0, 0, double)
7:5: Unrecognised type modifier combination: (2, 1, double)
8:5: Unrecognised type modifier combination: (0, 1, double)
"""
