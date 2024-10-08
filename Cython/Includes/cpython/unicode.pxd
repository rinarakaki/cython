from libc.stddef cimport wchar_t

extern from *:
    type Py_UCS1 = u8  # uint8_t
    type Py_UCS2 = u16  # uint16_t

    # Return true if the object o is a Unicode object or an instance
    # of a Unicode subtype. Changed in version 2.2: Allowed subtypes
    # to be accepted.
    fn u2 PyUnicode_Check(object o)

    # Return true if the object o is a Unicode object, but not an
    # instance of a subtype. New in version 2.2.
    fn u2 PyUnicode_CheckExact(object o)

    # Return the size of the object. o has to be a PyUnicodeObject
    # (not checked).
    #
    # Deprecated since version 3.3, will be removed in version 3.10:
    # Part of the old-style Unicode API, please migrate to using
    # PyUnicode_GET_LENGTH().
    fn isize PyUnicode_GET_SIZE(object o)

    # Return the length of the Unicode string, in code points. o has
    # to be a Unicode object in the “canonical” representation (not
    # checked).
    #
    # New in version 3.3.
    fn isize PyUnicode_GET_LENGTH(object o)

    fn Py_UCS1* PyUnicode_1BYTE_DATA(object o)
    fn Py_UCS2* PyUnicode_2BYTE_DATA(object o)
    fn Py_UCS4* PyUnicode_4BYTE_DATA(object o)

    static i32 PyUnicode_WCHAR_KIND  # Deprecated since Python 3.10, removed in 3.12.
    static i32 PyUnicode_1BYTE_KIND
    static i32 PyUnicode_2BYTE_KIND
    static i32 PyUnicode_4BYTE_KIND
    fn void PyUnicode_WRITE(i32 kind, void* data, isize index, Py_UCS4 value)
    fn Py_UCS4 PyUnicode_READ(i32 kind, void* data, isize index)
    fn Py_UCS4 PyUnicode_READ_CHAR(object o, isize index)

    fn u32 PyUnicode_KIND(object o)
    fn void* PyUnicode_DATA(object o)

    # Return the size of the object's internal buffer in bytes. o has
    # to be a PyUnicodeObject (not checked).
    fn isize PyUnicode_GET_DATA_SIZE(object o)

    # Return a pointer to the internal Py_UNICODE buffer of the
    # object. o has to be a PyUnicodeObject (not checked).
    fn Py_UNICODE* PyUnicode_AS_UNICODE(object o)

    # Return a pointer to the internal buffer of the object. o has to
    # be a PyUnicodeObject (not checked).
    fn r&i8 PyUnicode_AS_DATA(object o)

    fn u2 PyUnicode_IsIdentifier(object o)

    # Return 1 or 0 depending on whether ch is a whitespace character.
    fn u2 Py_UNICODE_ISSPACE(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a lowercase character.
    fn u2 Py_UNICODE_ISLOWER(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is an uppercase character.
    fn u2 Py_UNICODE_ISUPPER(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a titlecase character.
    fn u2 Py_UNICODE_ISTITLE(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a linebreak character.
    fn u2 Py_UNICODE_ISLINEBREAK(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a decimal character.
    fn u2 Py_UNICODE_ISDECIMAL(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a digit character.
    fn u2 Py_UNICODE_ISDIGIT(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is a numeric character.
    fn u2 Py_UNICODE_ISNUMERIC(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is an alphabetic character.
    fn u2 Py_UNICODE_ISALPHA(Py_UCS4 ch)

    # Return 1 or 0 depending on whether ch is an alphanumeric character.
    fn u2 Py_UNICODE_ISALNUM(Py_UCS4 ch)

    fn u2 Py_UNICODE_ISPRINTABLE(Py_UCS4 ch)

    # Return the character ch converted to lower case.
    # Used to return a Py_UNICODE value before Py3.3.
    fn Py_UCS4 Py_UNICODE_TOLOWER(Py_UCS4 ch)

    # Return the character ch converted to upper case.
    # Used to return a Py_UNICODE value before Py3.3.
    fn Py_UCS4 Py_UNICODE_TOUPPER(Py_UCS4 ch)

    # Return the character ch converted to title case.
    # Used to return a Py_UNICODE value before Py3.3.
    fn Py_UCS4 Py_UNICODE_TOTITLE(Py_UCS4 ch)

    # Return the character ch converted to a decimal positive
    # integer. Return -1 if this is not possible. This macro does not
    # raise exceptions.
    fn i32 Py_UNICODE_TODECIMAL(Py_UCS4 ch)

    # Return the character ch converted to a single digit
    # integer. Return -1 if this is not possible. This macro does not
    # raise exceptions.
    fn i32 Py_UNICODE_TODIGIT(Py_UCS4 ch)

    # Return the character ch converted to a double. Return -1.0 if
    # this is not possible. This macro does not raise exceptions.
    fn f64 Py_UNICODE_TONUMERIC(Py_UCS4 ch)

    # To create Unicode objects and access their basic sequence
    # properties, use these APIs:

    # Create a Unicode Object from the Py_UNICODE buffer u of the
    # given size. u may be NULL which causes the contents to be
    # undefined. It is the user's responsibility to fill in the needed
    # data. The buffer is copied into the new object. If the buffer is
    # not NULL, the return value might be a shared object. Therefore,
    # modification of the resulting Unicode object is only allowed
    # when u is NULL.
    fn unicode PyUnicode_FromUnicode(Py_UNICODE *u, isize size)

    # Similar to PyUnicode_FromUnicode(), but u points to UTF-8 encoded
    # bytes
    fn unicode PyUnicode_FromStringAndSize(r&i8 u, isize size)

    # Similar to PyUnicode_FromUnicode(), but u points to null-terminated
    # UTF-8 encoded bytes.  The size is determined with strlen().
    fn unicode PyUnicode_FromString(r&i8 u)

    fn unicode PyUnicode_New(isize size, Py_UCS4 maxchar)
    fn unicode PyUnicode_FromKindAndData(i32 kind, const void* buffer, isize size)
    fn unicode PyUnicode_FromFormat(r&i8 format, ...)
    fn isize PyUnicode_GetLength(object unicode) except -1
    fn isize PyUnicode_CopyCharacters(object to, isize to_start, object from_, isize from_start, isize how_many) except -1
    fn isize PyUnicode_Fill(object unicode, isize start, isize length, Py_UCS4 fill_char) except -1
    fn i32 PyUnicode_WriteChar(object unicode, isize index, Py_UCS4 character) except -1
    fn Py_UCS4 PyUnicode_ReadChar(object unicode, isize index) except -1
    fn unicode PyUnicode_Substring(object str, isize start, isize end)
    fn Py_UCS4* PyUnicode_AsUCS4(object u, Py_UCS4* buffer, isize buflen, int copy_null) except NULL
    fn Py_UCS4* PyUnicode_AsUCS4Copy(object u) except NULL

    # Create a Unicode Object from the given Unicode code point ordinal.
    #
    # The ordinal must be in 0..0x10000 on narrow Python builds
    # (UCS2), and range(0x110000) on wide builds (UCS4). A ValueError
    # is raised in case it is not.
    fn unicode PyUnicode_FromOrdinal(i32 ordinal)

    # Return a read-only pointer to the Unicode object's internal
    # Py_UNICODE buffer, NULL if unicode is not a Unicode object.
    fn Py_UNICODE* PyUnicode_AsUnicode(object o) except NULL

    # Return the length of the Unicode object.
    fn isize PyUnicode_GetSize(object o) except -1

    # Coerce an encoded object obj to an Unicode object and return a
    # reference with incremented refcount.
    # String and other char buffer compatible objects are decoded
    # according to the given encoding and using the error handling
    # defined by errors. Both can be NULL to have the interface use
    # the default values (see the next section for details).
    # All other objects, including Unicode objects, cause a TypeError
    # to be set.
    fn object PyUnicode_FromEncodedObject(object o, r&i8 encoding, r&i8 errors)

    # Shortcut for PyUnicode_FromEncodedObject(obj, NULL, "strict")
    # which is used throughout the interpreter whenever coercion to
    # Unicode is needed.
    fn object PyUnicode_FromObject(object obj)

    # If the platform supports wchar_t and provides a header file
    # wchar.h, Python can interface directly to this type using the
    # following functions. Support is optimized if Python's own
    # Py_UNICODE type is identical to the system's wchar_t.

    # Create a Unicode object from the wchar_t buffer w of the given
    # size. Return NULL on failure.
    fn object PyUnicode_FromWideChar(wchar_t *w, isize size)

    # Copy the Unicode object contents into the wchar_t buffer w.
    # At most size wchar_t characters are copied (excluding a possibly
    # trailing null termination character). Return the number of wchar_t
    # characters copied or -1 in case of an error. Note that the
    # esulting wchar_t* string may or may not be null-terminated.
    # It is the responsibility of the caller to make sure that the wchar_t*
    # string is null-terminated in case this is required by the application.
    # Also, note that the wchar_t* string might contain null characters,
    # which would cause the string to be truncated when used with most C functions.
    fn isize PyUnicode_AsWideChar(object o, wchar_t *w, isize size) except -1

    # Convert the Unicode object to a wide character string. The output
    # string always ends with a null character. If size is not NULL,
    # write the number of wide characters (excluding the trailing null
    # termination character) into *size. Note that the resulting wchar_t
    # string might contain null characters, which would cause the string
    # to be truncated when used with most C functions. If size is NULL and
    # the wchar_t* string contains null characters a ValueError is raised.

    # Returns a buffer allocated by PyMem_New (use PyMem_Free() to free it)
    # on success. On error, returns NULL and *size is undefined. Raises a
    # MemoryError if memory allocation is failed.
    fn wchar_t *PyUnicode_AsWideCharString(object o, isize *size) except NULL

# Unicode Methods

    # Concat two strings giving a new Unicode string.
    # Return value: New reference.
    fn unicode PyUnicode_Concat(object left, object right)

    # Split a string giving a list of Unicode strings. If sep is NULL,
    # splitting will be done at all whitespace substrings. Otherwise,
    # splits occur at the given separator. At most maxsplit splits will
    # be done. If negative, no limit is set. Separators are not included
    # in the resulting list.
    # Return value: New reference.
    fn list PyUnicode_Split(object s, object sep, isize maxsplit)

    # Split a Unicode string at line breaks, returning a list of Unicode
    # strings. CRLF is considered to be one line break. If keepend is 0,
    # the Line break characters are not included in the resulting strings.
    # Return value: New reference.
    fn list PyUnicode_Splitlines(object s, u2 keepend)

    # Translate a string by applying a character mapping table to it and
    # return the resulting Unicode object.
    #
    # The mapping table must map Unicode ordinal integers to Unicode ordinal
    # integers or None (causing deletion of the character).
    #
    # Mapping tables need only provide the __getitem__() interface;
    # dictionaries and sequences work well. Unmapped character ordinals (ones
    # which cause a LookupError) are left untouched and are copied as-is.
    #
    # errors has the usual meaning for codecs. It may be NULL which indicates
    # to use the default error handling.
    # Return value: New reference.
    fn unicode PyUnicode_Translate(object str, object table, r&i8 errors)

    # Join a sequence of strings using the given separator and return the
    # resulting Unicode string.
    # Return value: New reference.
    fn unicode PyUnicode_Join(object separator, object seq)

    # Return 1 if substr matches str[start:end] at the given tail end
    # (direction == -1 means to do a prefix match, direction == 1 a
    # suffix match), 0 otherwise.
    # Return -1 if an error occurred.
    fn isize PyUnicode_Tailmatch(object str, object substr,
                                 isize start, isize end, i32 direction) except -1

    # Return the first position of substr in str[start:end] using the given
    # direction (direction == 1 means to do a forward search, direction == -1
    # a backward search). The return value is the index of the first match;
    # a value of -1 indicates that no match was found, and -2 indicates that an
    # error occurred and an exception has been set.
    fn isize PyUnicode_Find(object str, object substr, isize start, isize end, i32 direction) except -2

    # Return the first position of the character ch in str[start:end] using
    # the given direction (direction == 1 means to do a forward search,
    # direction == -1 a backward search). The return value is the index of
    # the first match; a value of -1 indicates that no match was found, and
    # -2 indicates that an error occurred and an exception has been set.
    # New in version 3.3.
    fn isize PyUnicode_FindChar(object str, Py_UCS4 ch, isize start, isize end, i32 direction) except -2

    # Return the number of non-overlapping occurrences of substr in
    # str[start:end]. Return -1 if an error occurred.
    fn isize PyUnicode_Count(object str, object substr, isize start, isize end) except -1

    # Replace at most maxcount occurrences of substr in str with replstr and
    # return the resulting Unicode object. maxcount == -1 means replace all
    # occurrences.
    # Return value: New reference.
    fn unicode PyUnicode_Replace(object str, object substr, object replstr, isize maxcount)

    # Compare two strings and return -1, 0, 1 for less than,
    # equal, and greater than, respectively.
    fn i32 PyUnicode_Compare(object left, object right) except? -1

    # Compare a unicode object, uni, with string and return -1, 0, 1 for less than,
    # equal, and greater than, respectively. It is best to pass only ASCII-encoded
    # strings, but the function interprets the input string as ISO-8859-1 if it
    # contains non-ASCII characters.
    fn i32 PyUnicode_CompareWithASCIIString(object uni, r&i8 string)

    # Rich compare two unicode strings and return one of the following:
    #
    #    NULL in case an exception was raised
    #    Py_True or Py_False for successful comparisons
    #    Py_NotImplemented in case the type combination is unknown
    #
    # Note that Py_EQ and Py_NE comparisons can cause a UnicodeWarning in case
    # the conversion of the arguments to Unicode fails with a UnicodeDecodeError.
    #
    # Possible values for op are Py_GT, Py_GE, Py_EQ, Py_NE, Py_LT, and Py_LE.
    fn object PyUnicode_RichCompare(object left, object right, i32 op)

    # Return a new string object from format and args; this is analogous to
    # format % args.
    # Return value: New reference.
    fn unicode PyUnicode_Format(object format, object args)

    # Check whether element is contained in container and return true or false
    # accordingly.
    #
    # element has to coerce to a one element Unicode string. -1 is returned
    # if there was an error.
    fn i32 PyUnicode_Contains(object container, object element) except -1

    # Intern the argument *string in place. The argument must be the address
    # of a pointer variable pointing to a Python unicode string object. If
    # there is an existing interned string that is the same as *string, it sets
    # *string to it (decrementing the reference count of the old string object
    # and incrementing the reference count of the interned string object),
    # otherwise it leaves *string alone and interns it (incrementing its reference
    # count). (Clarification: even though there is a lot of talk about reference
    # counts, think of this function as reference-count-neutral; you own the object
    # after the call if and only if you owned it before the call.)
    # fn void PyUnicode_InternInPlace(PyObject** string)

    # A combination of PyUnicode_FromString() and PyUnicode_InternInPlace(),
    # returning either a new unicode string object that has been interned, or
    # a new ("owned") reference to an earlier interned string object with the
    # same value.
    fn unicode PyUnicode_InternFromString(r&i8 v)

# Codecs

    # Create a Unicode object by decoding size bytes of the encoded
    # string s. encoding and errors have the same meaning as the
    # parameters of the same name in the unicode() builtin
    # function. The codec to be used is looked up using the Python
    # codec registry. Return NULL if an exception was raised by the
    # codec.
    fn object PyUnicode_Decode(r&i8 s, isize size, r&i8 encoding, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size and return a
    # Python string object. encoding and errors have the same meaning
    # as the parameters of the same name in the Unicode encode()
    # method. The codec to be used is looked up using the Python codec
    # registry. Return NULL if an exception was raised by the codec.
    fn object PyUnicode_Encode(Py_UNICODE* s, isize size,
                               r&i8 encoding, r&i8 errors)

    # Encode a Unicode object and return the result as Python string
    # object. encoding and errors have the same meaning as the
    # parameters of the same name in the Unicode encode() method. The
    # codec to be used is looked up using the Python codec
    # registry. Return NULL if an exception was raised by the codec.
    fn object PyUnicode_AsEncodedString(object unicode, r&i8 encoding, r&i8 errors)

# These are the UTF-8 codec APIs:

    # Create a Unicode object by decoding size bytes of the UTF-8
    # encoded string s. Return NULL if an exception was raised by the
    # codec.
    fn unicode PyUnicode_DecodeUTF8(r&i8 s, isize size, r&i8 errors)

    # If consumed is NULL, behave like PyUnicode_DecodeUTF8(). If
    # consumed is not NULL, trailing incomplete UTF-8 byte sequences
    # will not be treated as an error. Those bytes will not be decoded
    # and the number of bytes that have been decoded will be stored in
    # consumed. New in version 2.4.
    fn unicode PyUnicode_DecodeUTF8Stateful(r&mut i8 s, isize size, r&i8 errors, isize* consumed)

    # Encode the Py_UNICODE buffer of the given size using UTF-8 and
    # return a Python string object. Return NULL if an exception was
    # raised by the codec.
    fn bytes PyUnicode_EncodeUTF8(Py_UNICODE *s, isize size, r&i8 errors)

    # Encode a Unicode objects using UTF-8 and return the result as Python bytes object. Error handling is ``strict''. Return NULL if an exception was raised by the codec.
    fn bytes PyUnicode_AsUTF8String(object unicode)

    # Return a pointer to the UTF-8 encoding of the Unicode object,
    # and store the size of the encoded representation (in bytes) in size.
    # The size argument can be NULL; in this case no size will be stored.
    # The returned buffer always has an extra null byte appended
    # (not included in size), regardless of whether there are any
    # other null code points.

    # In the case of an error, NULL is returned with an exception set and
    # no size is stored.

    # This caches the UTF-8 representation of the string in the Unicode
    # object, and subsequent calls will return a pointer to the same buffer.
    # The caller is not responsible for deallocating the buffer
    fn r&i8 PyUnicode_AsUTF8AndSize(object unicode, isize *size) except NULL


    # As PyUnicode_AsUTF8AndSize(), but does not store the size.
    fn r&i8 PyUnicode_AsUTF8(object unicode) except NULL

# These are the UTF-16 codec APIs:

    # Decode length bytes from a UTF-16 encoded buffer string and
    # return the corresponding Unicode object. errors (if non-NULL)
    # defines the error handling. It defaults to ``strict''.
    #
    # If byteorder is non-NULL, the decoder starts decoding using the
    # given byte order:
    #
    #   *byteorder == -1: little endian
    #   *byteorder == 0:  native order
    #   *byteorder == 1:  big endian
    #
    # and then switches if the first two bytes of the input data are a
    # byte order mark (BOM) and the specified byte order is native
    # order. This BOM is not copied into the resulting Unicode
    # string. After completion, *byteorder is set to the current byte
    # order at the.
    #
    # If byteorder is NULL, the codec starts in native order mode.
    fn unicode PyUnicode_DecodeUTF16(r&i8 s, isize size, r&i8 errors, i32* byteorder)

    # If consumed is NULL, behave like PyUnicode_DecodeUTF16(). If
    # consumed is not NULL, PyUnicode_DecodeUTF16Stateful() will not
    # treat trailing incomplete UTF-16 byte sequences (such as an odd
    # number of bytes or a split surrogate pair) as an error. Those
    # bytes will not be decoded and the number of bytes that have been
    # decoded will be stored in consumed. New in version 2.4.
    fn unicode PyUnicode_DecodeUTF16Stateful(r&i8 s, isize size, r&i8 errors, i32* byteorder, isize* consumed)

    # Return a Python string object holding the UTF-16 encoded value
    # of the Unicode data in s. If byteorder is not 0, output is
    # written according to the following byte order:
    #
    #   byteorder == -1: little endian
    #   byteorder == 0:  native byte order (writes a BOM mark)
    #   byteorder == 1:  big endian
    #
    # If byteorder is 0, the output string will always start with the
    # Unicode BOM mark (U+FEFF). In the other two modes, no BOM mark
    # is prepended.
    #
    # If Py_UNICODE_WIDE is defined, a single Py_UNICODE value may get
    # represented as a surrogate pair. If it is not defined, each
    # Py_UNICODE values is interpreted as an UCS-2 character.
    fn bytes PyUnicode_EncodeUTF16(Py_UNICODE* s, isize size, r&i8 errors, i32 byteorder)

    # Return a Python string using the UTF-16 encoding in native byte
    # order. The string always starts with a BOM mark. Error handling
    # is ``strict''. Return NULL if an exception was raised by the
    # codec.
    fn bytes PyUnicode_AsUTF16String(object unicode)

# These are the ``Unicode Escape'' codec APIs:

    # Create a Unicode object by decoding size bytes of the
    # Unicode-Escape encoded string s. Return NULL if an exception was
    # raised by the codec.
    fn object PyUnicode_DecodeUnicodeEscape(r&i8 s, isize size, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size using
    # Unicode-Escape and return a Python string object. Return NULL if
    # an exception was raised by the codec.
    fn object PyUnicode_EncodeUnicodeEscape(Py_UNICODE *s, isize size)

    # Encode a Unicode objects using Unicode-Escape and return the
    # result as Python string object. Error handling is
    # ``strict''. Return NULL if an exception was raised by the codec.
    fn object PyUnicode_AsUnicodeEscapeString(object unicode)

# These are the ``Raw Unicode Escape'' codec APIs:

    # Create a Unicode object by decoding size bytes of the
    # Raw-Unicode-Escape encoded string s. Return NULL if an exception
    # was raised by the codec.
    fn object PyUnicode_DecodeRawUnicodeEscape(r&i8 s, isize size, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size using
    # Raw-Unicode-Escape and return a Python string object. Return
    # NULL if an exception was raised by the codec.
    fn object PyUnicode_EncodeRawUnicodeEscape(Py_UNICODE* s, isize size, r&i8 errors)

    # Encode a Unicode objects using Raw-Unicode-Escape and return the
    # result as Python string object. Error handling is
    # ``strict''. Return NULL if an exception was raised by the codec.
    fn object PyUnicode_AsRawUnicodeEscapeString(object unicode)

# These are the Latin-1 codec APIs: Latin-1 corresponds to the first 256 Unicode ordinals and only these are accepted by the codecs during encoding.

    # Create a Unicode object by decoding size bytes of the Latin-1
    # encoded string s. Return NULL if an exception was raised by the
    # codec.
    fn unicode PyUnicode_DecodeLatin1(r&i8 s, isize size, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size using Latin-1 and
    # return a Python bytes object. Return NULL if an exception was
    # raised by the codec.
    fn bytes PyUnicode_EncodeLatin1(Py_UNICODE* s, isize size, r&i8 errors)

    # Encode a Unicode objects using Latin-1 and return the result as
    # Python bytes object. Error handling is ``strict''. Return NULL
    # if an exception was raised by the codec.
    fn bytes PyUnicode_AsLatin1String(object unicode)

# These are the ASCII codec APIs. Only 7-bit ASCII data is
# accepted. All other codes generate errors.

    # Create a Unicode object by decoding size bytes of the ASCII
    # encoded string s. Return NULL if an exception was raised by the
    # codec.
    fn unicode PyUnicode_DecodeASCII(r&i8 s, isize size, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size using ASCII and
    # return a Python bytes object. Return NULL if an exception was
    # raised by the codec.
    fn bytes PyUnicode_EncodeASCII(Py_UNICODE* s, isize size, r&i8 errors)

    # Encode a Unicode objects using ASCII and return the result as
    # Python bytes object. Error handling is ``strict''. Return NULL
    # if an exception was raised by the codec.
    fn bytes PyUnicode_AsASCIIString(object o)

# These are the mapping codec APIs:
#
# This codec is special in that it can be used to implement many
# different codecs (and this is in fact what was done to obtain most
# of the standard codecs included in the encodings package). The codec
# uses mapping to encode and decode characters.
#
# Decoding mappings must map single string characters to single
# Unicode characters, integers (which are then interpreted as Unicode
# ordinals) or None (meaning "undefined mapping" and causing an
# error).
#
# Encoding mappings must map single Unicode characters to single
# string characters, integers (which are then interpreted as Latin-1
# ordinals) or None (meaning "undefined mapping" and causing an
# error).
#
# The mapping objects provided must only support the __getitem__
# mapping interface.
#
# If a character lookup fails with a LookupError, the character is
# copied as-is meaning that its ordinal value will be interpreted as
# Unicode or Latin-1 ordinal resp. Because of this, mappings only need
# to contain those mappings which map characters to different code
# points.

    # Create a Unicode object by decoding size bytes of the encoded
    # string s using the given mapping object. Return NULL if an
    # exception was raised by the codec. If mapping is NULL latin-1
    # decoding will be done. Else it can be a dictionary mapping byte
    # or a unicode string, which is treated as a lookup table. Byte
    # values greater that the length of the string and U+FFFE
    # "characters" are treated as "undefined mapping". Changed in
    # version 2.4: Allowed unicode string as mapping argument.
    fn object PyUnicode_DecodeCharmap(r&i8 s, isize size, object mapping, r&i8 errors)

    # Encode the Py_UNICODE buffer of the given size using the given
    # mapping object and return a Python string object. Return NULL if
    # an exception was raised by the codec.
    #
    # Deprecated since version 3.3, will be removed in version 4.0.
    fn object PyUnicode_EncodeCharmap(Py_UNICODE* s, isize size, object mapping, r&i8 errors)

    # Encode a Unicode objects using the given mapping object and
    # return the result as Python string object. Error handling is
    # ``strict''. Return NULL if an exception was raised by the codec.
    fn object PyUnicode_AsCharmapString(object o, object mapping)

# The following codec API is special in that maps Unicode to Unicode.

    # Translate a Py_UNICODE buffer of the given length by applying a
    # character mapping table to it and return the resulting Unicode
    # object. Return NULL when an exception was raised by the codec.
    #
    # The mapping table must map Unicode ordinal integers to Unicode
    # ordinal integers or None (causing deletion of the character).
    #
    # Mapping tables need only provide the __getitem__() interface;
    # dictionaries and sequences work well. Unmapped character
    # ordinals (ones which cause a LookupError) are left untouched and
    # are copied as-is.
    #
    # Deprecated since version 3.3, will be removed in version 4.0.
    fn object PyUnicode_TranslateCharmap(Py_UNICODE* s, isize size,
                                         object table, r&i8 errors)

# These are the MBCS codec APIs. They are currently only available on
# Windows and use the Win32 MBCS converters to implement the
# conversions. Note that MBCS (or DBCS) is a class of encodings, not
# just one. The target encoding is defined by the user settings on the
# machine running the codec.

    # Create a Unicode object by decoding size bytes of the MBCS
    # encoded string s. Return NULL if an exception was raised by the
    # codec.
    fn unicode PyUnicode_DecodeMBCS(r&i8 s, isize size, r&i8 errors)

    # If consumed is NULL, behave like PyUnicode_DecodeMBCS(). If
    # consumed is not NULL, PyUnicode_DecodeMBCSStateful() will not
    # decode trailing lead byte and the number of bytes that have been
    # decoded will be stored in consumed. New in version 2.5.
    # NOTE: Python 2.x uses 'int' values for 'size' and 'consumed' (changed in 3.0)
    fn unicode PyUnicode_DecodeMBCSStateful(r&i8 s, isize size, r&i8 errors, isize* consumed)

    # Encode the Py_UNICODE buffer of the given size using MBCS and
    # return a Python string object. Return NULL if an exception was
    # raised by the codec.
    fn bytes PyUnicode_EncodeMBCS(Py_UNICODE* s, isize size, r&i8 errors)

    # Encode a Unicode objects using MBCS and return the result as
    # Python string object. Error handling is ``strict''. Return NULL
    # if an exception was raised by the codec.
    fn bytes PyUnicode_AsMBCSString(object o)

    # Encode the Unicode object using the specified code page and return
    # a Python bytes object. Return NULL if an exception was raised by the
    # codec. Use CP_ACP code page to get the MBCS encoder.
    #
    # New in version 3.3.
    fn bytes PyUnicode_EncodeCodePage(i32 code_page, object unicode, r&i8 errors)

# Py_UCS4 helpers (new in CPython 3.3)

    # These utility functions work on strings of Py_UCS4 characters and
    # otherwise behave like the C standard library functions with the same name.

    fn usize Py_UCS4_strlen(const Py_UCS4* u)
    fn Py_UCS4* Py_UCS4_strcpy(Py_UCS4* s1, const Py_UCS4* s2)
    fn Py_UCS4* Py_UCS4_strncpy(Py_UCS4* s1, const Py_UCS4* s2, usize n)
    fn Py_UCS4* Py_UCS4_strcat(Py_UCS4* s1, const Py_UCS4* s2)
    fn i32 Py_UCS4_strcmp(const Py_UCS4* s1, const Py_UCS4* s2)
    fn i32 Py_UCS4_strncmp(const Py_UCS4* s1, const Py_UCS4* s2, usize n)
    fn Py_UCS4* Py_UCS4_strchr(const Py_UCS4* s, Py_UCS4 c)
    fn Py_UCS4* Py_UCS4_strrchr(const Py_UCS4* s, Py_UCS4 c)
