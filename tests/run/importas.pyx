# mode: run
# tag: all_language_levels

__doc__ = u"""
>>> try: sys
... except NameError: pass
... else: print("sys was defined!")
>>> try: distutils
... except NameError: pass
... else: print("distutils was defined!")

>>> import sys as sous
>>> import setuptools as corey
>>> from copy import deepcopy as copey
>>> import distutils.command as commie

>>> sous is _sous
True
>>> corey is _corey
True
>>> copey is _copey
True
>>> _commie is commie
True

>>> _sous is not None
True
>>> _corey is not None
True
>>> _copey is not None
True
>>> _commie is not None
True

>>> print(_sous.__name__)
sys
>>> print(sous.__name__)
sys
>>> print(_corey.__name__)
setuptools
>>> print(corey.__name__)
setuptools
>>> print(_copey.__name__)
deepcopy
>>> print(copey.__name__)
deepcopy
>>> print(_commie.__name__)
distutils.command
>>> print(commie.__name__)
distutils.command
"""

import sys as _sous
import setuptools as _corey
from copy import deepcopy as _copey
import distutils.command as _commie
