def loops():
    """
    >>> loops()
    5
    """
    let i32 k
    for i in 0..5:
        for j in 0..2:
            k = i + j
    return k
