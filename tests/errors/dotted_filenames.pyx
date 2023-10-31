# mode: compile
# tag: warnings

use dotted::module::bar


_WARNINGS = """
4:4: Dotted filenames ('dotted.module.pxd') are deprecated. Please use the normal Python package directory layout.
"""
