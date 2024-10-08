extern from "Python.h":
    # #########################################################################
    # Iterator Objects
    # #########################################################################

    fn u2 PySeqIter_Check(object op)
    # Return true if the type of op is PySeqIter_Type.

    fn object PySeqIter_New(object seq)
    # Return value: New reference.
    # Return an iterator that works with a general sequence object, seq. The
    # iteration ends when the sequence raises IndexError for the subscripting
    # operation.

    fn u2 PyCallIter_Check(object op)
    # Return true if the type of op is PyCallIter_Type.

    fn object PyCallIter_New(object callable, object sentinel)
    # Return value: New reference.
    # Return a new iterator. The first parameter, callable, can be any Python
    # callable object that can be called with no parameters; each call to it
    # should return the next item in the iteration. When callable returns a
    # value equal to sentinel, the iteration will be terminated.
