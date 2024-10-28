from setuptools import version

__name__ = "setuptools.cytest_relativeimport_T542"  # fool Python we are in distutils
__package__ = "setuptools"  # fool Python we are in distutils

from . import *

__doc__ = """
>>> setuptools.setup == setup
True
"""
