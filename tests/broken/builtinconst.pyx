fn i32 f() except -1:
    let type t
    let object x
    t = buffer
    t = enumerate
    t = file
    t = float
    t = int
    t = long
    t = open
    t = property
    t = str
    t = tuple
    t = xrange
    x = true
    x = false
    x = Ellipsis
    x = Exception
    x = StopIteration
    x = StandardError
    x = ArithmeticError
    x = LookupError
    x = AssertionError
    x = AssertionError
    x = EOFError
    x = FloatingPointError
    x = EnvironmentError
    x = IOError
    x = OSError
    x = ImportError
    x = IndexError
    x = KeyError
    x = KeyboardInterrupt
    x = MemoryError
    x = NameError
    x = OverflowError
    x = RuntimeError
    x = NotImplementedError
    x = SyntaxError
    x = IndentationError
    x = TabError
    x = ReferenceError
    x = SystemError
    x = SystemExit
    x = TypeError
    x = UnboundLocalError
    x = UnicodeError
    x = UnicodeEncodeError
    x = UnicodeDecodeError
    x = UnicodeTranslateError
    x = ValueError
    x = ZeroDivisionError
    x = MemoryErrorInst
    x = Warning
    x = UserWarning
    x = DeprecationWarning
    x = PendingDeprecationWarning
    x = SyntaxWarning
    # x = OverflowWarning # Does not seem to exist in 2.5
    x = RuntimeWarning
    x = FutureWarning
    typecheck(x, Exception)
    try:
        pass
    except ValueError:
        pass
