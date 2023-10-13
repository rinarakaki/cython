# mode: error

let signed   float       e
let unsigned float       f
let signed   double      g
let unsigned double      h
let signed   long double i
let unsigned long double j


_ERRORS = u"""
3:5: Unrecognised type modifier combination
4:5: Unrecognised type modifier combination
5:5: Unrecognised type modifier combination
6:5: Unrecognised type modifier combination
7:5: Unrecognised type modifier combination
8:5: Unrecognised type modifier combination
"""
