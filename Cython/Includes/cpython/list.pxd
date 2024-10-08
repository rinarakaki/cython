use super::object::PyObject

extern from "Python.h":
    # ##########################################################################
    # Lists
    # ##########################################################################
    fn list PyList_New(isize len)
    # Return a new list of length len on success, or NULL on failure.
    #
    # Note: If length is greater than zero, the returned list object's
    # items are set to NULL. Thus you cannot use abstract API
    # functions such as PySequence_SetItem() or expose the object to
    # Python code before setting all items to a real object with
    # PyList_SetItem().

    fn u2 PyList_Check(object p)
    # Return true if p is a list object or an instance of a subtype of
    # the list type.

    fn u2 PyList_CheckExact(object p)
    # Return true if p is a list object, but not an instance of a
    # subtype of the list type.

    fn isize PyList_Size(object list) except -1
    # Return the length of the list object in list; this is equivalent
    # to "len(list)" on a list object.

    fn isize PyList_GET_SIZE(object list)
    # Macro form of PyList_Size() without error checking.

    fn PyObject* PyList_GetItem(object list, isize index) except NULL
    # Return value: Borrowed reference.
    # Return the object at position pos in the list pointed to by
    # p. The position must be positive, indexing from the end of the
    # list is not supported. If pos is out of bounds, return NULL and
    # set an IndexError exception.

    fn PyObject* PyList_GET_ITEM(object list, isize i)
    # Return value: Borrowed reference.
    # Macro form of PyList_GetItem() without error checking.

    fn i32 PyList_SetItem(object list, isize index, object item) except -1
    # Set the item at index index in list to item. Return 0 on success
    # or -1 on failure.
    #
    # WARNING: This function _steals_ a reference to item and discards a
    # reference to an item already in the list at the affected position.

    fn void PyList_SET_ITEM(object list, isize i, object o)
    # Macro form of PyList_SetItem() without error checking. This is
    # normally only used to fill in new lists where there is no
    # previous content.
    #
    # WARNING: This function _steals_ a reference to item, and, unlike
    # PyList_SetItem(), does not discard a reference to any item that
    # it being replaced; any reference in list at position i will be *leaked*.

    fn i32 PyList_Insert(object list, isize index, object item) except -1
    # Insert the item item into list list in front of index
    # index. Return 0 if successful; return -1 and set an exception if
    # unsuccessful. Analogous to list.insert(index, item).

    fn i32 PyList_Append(object list, object item) except -1
    # Append the object item at the end of list list. Return 0 if
    # successful; return -1 and set an exception if
    # unsuccessful. Analogous to list.append(item).

    fn list PyList_GetSlice(object list, isize low, isize high)
    # Return value: New reference.
    # Return a list of the objects in list containing the objects
    # between low and high. Return NULL and set an exception if
    # unsuccessful. Analogous to list[low:high].

    fn i32 PyList_SetSlice(object list, isize low, isize high, object itemlist) except -1
    # Set the slice of list between low and high to the contents of
    # itemlist. Analogous to list[low:high] = itemlist. The itemlist
    # may be NULL, indicating the assignment of an empty list (slice
    # deletion). Return 0 on success, -1 on failure.

    fn i32 PyList_Sort(object list) except -1
    # Sort the items of list in place. Return 0 on success, -1 on
    # failure. This is equivalent to "list.sort()".

    fn i32 PyList_Reverse(object list) except -1
    # Reverse the items of list in place. Return 0 on success, -1 on
    # failure. This is the equivalent of "list.reverse()".

    fn tuple PyList_AsTuple(object list)
    # Return value: New reference.
    # Return a new tuple object containing the contents of list;
    # equivalent to "tuple(list)".
