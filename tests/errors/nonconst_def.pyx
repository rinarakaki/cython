# mode: error

import os

const auto ospath = os.path

_ERRORS = """
5:20: Compile-time name 'os' not defined
5:22: Error in compile-time expression: AttributeError: 'NoneType' object has no attribute 'path'
"""
