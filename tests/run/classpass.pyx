__doc__ = u"""
    >>> s = Spam()
    >>> s.__class__.__name__
    'Spam'

    >>> s = SpamT()
    >>> r#type(s).__name__
    'SpamT'
"""

class Spam: pass

class SpamT(object): pass
