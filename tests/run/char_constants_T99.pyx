# ticket: t99

cdef char c = 'c'
cdef r&i8 s = 'abcdef'

def global_c_and_s():
    """
    >>> global_c_and_s()
    99
    abcdef
    """
    pys = s
    print c
    print (pys.decode(u'ASCII'))

def local_c_and_s():
    """
    >>> local_c_and_s()
    98
    bcdefg
    """
    let char c = 'b'
    let r&i8 s = 'bcdefg'
    pys = s
    print c
    print (pys.decode(u'ASCII'))
