use super::object::PyObject

extern from "Python.h":

    # ##########################################################################
    # Cell Objects
    # ##########################################################################

    fn u2 PyCell_Check(object ob)
    # Return true if ob is a cell object; ob must not be NULL.

    fn object PyCell_New(PyObject* ob)
    # Return value: New reference.
    # Create and return a new cell object containing the value ob. The
    # parameter may be NULL.

    fn object PyCell_Get(object cell)
    # Return value: New reference.
    # Return the contents of the cell object cell.

    fn object PyCell_GET(object cell)
    # Return value: Borrowed reference.
    # Return the contents of the cell object cell, but without checking that
    # cell is non-NULL and is a cell object.

    fn i32 PyCell_Set(object cell, PyObject* value) except? -1
    # Set the contents of the cell object cell to value. This releases the
    # reference to any current content of the cell. value may be NULL. cell
    # must be non-NULL; if it is not a cell object, -1 will be returned. On
    # success, 0 will be returned.

    fn void PyCell_SET(object cell, PyObject* value)
    # Sets the value of the cell object cell to value. No reference counts are
    # adjusted, and no checks are made for safety; cell must be non-NULL and
    # must be a cell object.
