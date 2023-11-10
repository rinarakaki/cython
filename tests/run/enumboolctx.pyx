pub enum Bool:
   False = 0
   True = 1

def enum_boolctx(Bool arg):
    """
    >>> enum_boolctx(Bool::False)
    False
    >>> enum_boolctx(Bool::True)
    True
    """
    if <u2>arg:
        return true
    else:
        return false

extern from *:
    enum: FALSE_VALUE "(0)"
    enum: TRUE_VALUE "(1)"

def extern_enum_false():
    """
    >>> extern_enum_false()
    """
    if FALSE_VALUE:
        raise ValueError

def extern_enum_true():
    """
    >>> extern_enum_true()
    """
    if not TRUE_VALUE:
        raise ValueError

def extern_enum_false_true():
    """
    >>> extern_enum_false_true()
    """
    if not TRUE_VALUE or FALSE_VALUE:
        raise ValueError
