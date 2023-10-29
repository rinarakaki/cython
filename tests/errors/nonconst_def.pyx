# mode: error

import os
const ospath = os.path

_ERRORS = u"""
4:13: Compile-time name 'os' not defined
4:15: Error in compile-time expression: AttributeError: 'NoneType' object has no attribute 'path'
"""
