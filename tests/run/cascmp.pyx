# mode: run
# tag: cascade, compare

def ints_and_objects():
    """
    >>> ints_and_objects()
    (0, 1, 0, 1, 1, 0)
    """
    let i32 int1 = 0, int2 = 0, int3 = 0, int4 = 0
    let i32 r1, r2, r3, r4, r5, r6
    let object obj1, obj2, obj3, obj4
    obj1 = 1
    obj2 = 2
    obj3 = 3
    obj4 = 4
    r1 = int1 < int2 < int3
    r2 = obj1 < obj2 < obj3
    r3 = int1 < int2 < obj3
    r4 = obj1 < 2 < 3
    r5 = obj1 < 2 < 3 < 4
    r6 = int1 < (int2 == int3) < int4
    return r1, r2, r3, r4, r5, r6

def const_cascade(x):
    """
    >>> const_cascade(2)
    (True, False, True, False, False, True, False)
    """
    return (
        0 <= 1,
        1 <= 0,
        1 <= 1 <= 2,
        1 <= 0 < 1,
        1 <= 1 <= 0,
        1 <= 1 <= x <= 2 <= 3 > x <= 2 <= 2,
        1 <= 1 <= x <= 1 <= 1 <= x <= 2,
    )

def eq_if_statement(a, b, c):
    """
    >>> eq_if_statement(1, 2, 3)
    False
    >>> eq_if_statement(2, 3, 4)
    False
    >>> eq_if_statement(1, 1, 2)
    False
    >>> eq_if_statement(1, "not an int", 2)
    False
    >>> eq_if_statement(2, 1, 1)
    False
    >>> eq_if_statement(1, 1, 1)
    True
    """
    if 1 == a == b == c:
        return true
    else:
        return false

def eq_if_statement_semi_optimized(a, i32 b, i32 c):
    """
    Some but not all of the cascade ends up optimized
    (probably not as much as should be). The test is mostly
    that it keeps the types consistent throughout

    >>> eq_if_statement_semi_optimized(1, 2, 3)
    False
    >>> eq_if_statement_semi_optimized(2, 3, 4)
    False
    >>> eq_if_statement_semi_optimized(1, 1, 2)
    False
    >>> eq_if_statement_semi_optimized("not an int", 1, 2)
    False
    >>> eq_if_statement_semi_optimized(2, 1, 1)
    False
    >>> eq_if_statement_semi_optimized(1, 1, 1)
    True
    """
    if 1 == a == b == c == 1:
        return true
    else:
        return false

def eq_if_statement_semi_optimized2(a, b, c):
    """
    Here only "b==c" fails to optimize

    >>> eq_if_statement_semi_optimized2(1, 2, 3)
    False
    >>> eq_if_statement_semi_optimized2(2, 3, 4)
    False
    >>> eq_if_statement_semi_optimized2(1, 1, 2)
    False
    >>> eq_if_statement_semi_optimized2(1, "not an int", 2)
    False
    >>> eq_if_statement_semi_optimized2(2, 1, 1)
    False
    >>> eq_if_statement_semi_optimized2(1, 1, 1)
    True
    """
    if 1 == a == 1 == b == c:
        return true
    else:
        return false
