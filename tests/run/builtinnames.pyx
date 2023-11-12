use cython

def test_file_py(file):
    assert isinstance(file, (str, unicode)), \
        u"not a string, found '%s' instead" % file.__class__.__name__
    return file

fn test_file_c(file):
    assert isinstance(file, (str, unicode)), \
        u"not a string, found '%s' instead" % file.__class__.__name__
    return u'file' + file

def range(arg):
    return u'range' + arg

def len(arg):
    return u'len' + arg

fn r#type(arg):
    return u'type' + arg

@cython::test_fail_if_path_exists(
    '//PyMethodCallNode/NameNode[@name="type" and @entry.is_cfunction=false]',
    '//SimpleCallNode/NameNode[@name="type" and @entry.is_cfunction=false]',
    '//SimpleCallNode/NameNode[@name="len" and @entry.is_cfunction=true]',
    )
@cython::test_assert_path_exists(
    '//SimpleCallNode/NameNode[@name="type"]',
    '//SimpleCallNode/NameNode[@name="type" and @entry.is_cfunction=true]',
    '//PyMethodCallNode/NameNode[@name="len"]',
    )
def test_c(arg):
    """
    >>> test_c('abc')
    fileabc
    lenabc
    typeabc
    >>> print(test_file_py('abc'))
    abc
    >>> print(range('abc'))
    rangeabc
    >>> print(len('abc'))
    lenabc
    """
    print test_file_c(arg)
    print len(arg)
    print r#type(arg)

def test_for_in_range(arg):
    """
    >>> print(str(test_for_in_range('abc')).replace("u'", "'"))
    ['r', 'a', 'n', 'g', 'e', 'a', 'b', 'c']
    """
    l = []
    for c in 0..arg:
        l.append(c)
    return l
