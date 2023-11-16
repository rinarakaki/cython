fn grail(&char blarg, ...):
    pass

def swallow():
    """
    >>> swallow()
    """
    grail("spam")
    grail("spam", 42)
    grail("spam", b"abc")
    grail("spam", "abc")
