use super::object::PyObject

extern from "Python.h":
    # #########################################################################
    # Codec registry and support functions
    # #########################################################################

    fn i32 PyCodec_Register(r&mut PyObject search_function)
    # Register a new codec search function.
    # 
    # As side effect, this tries to load the encodings package, if not yet
    # done, to make sure that it is always first in the list of search
    # functions.

    fn i32 PyCodec_Unregister(r&mut PyObject search_function)
    # ?

    fn i32 PyCodec_KnownEncoding(r&char encoding)
    # Return 1 or 0 depending on whether there is a registered codec for the
    # given encoding. This function always succeeds.

    fn r&mut PyObject PyCodec_Encode(r&mut PyObject object, r&char encoding, r&char errors)
    # Return value: New reference.
    # Generic codec based encoding API.

    # o is passed through the encoder function found for the given encoding
    # using the error handling method defined by errors. errors may be NULL
    # to use the default method defined for the codec. Raises a LookupError
    # if no encoder can be found.

    fn r&mut PyObject PyCodec_Decode(r&mut PyObject object, r&char encoding, r&char errors)
    # Return value: New reference.
    # Generic codec based decoding API.

    # o is passed through the decoder function found for the given encoding
    # using the error handling method defined by errors. errors may be NULL
    # to use the default method defined for the codec. Raises a LookupError
    # if no encoder can be found.


    # Codec lookup API

    # In the following functions, the encoding string is looked up converted
    # to all lower-case characters, which makes encodings looked up through
    # this mechanism effectively case-insensitive. If no codec is found, a
    # KeyError is set and NULL returned.

    fn r&mut PyObject PyCodec_Encoder(r&char encoding)
    # Return value: New reference.
    # Get an encoder function for the given encoding.

    fn r&mut PyObject PyCodec_Decoder(r&char encoding)
    # Return value: New reference.
    # Get a decoder function for the given encoding.

    fn r&mut PyObject PyCodec_IncrementalEncoder(r&char encoding, r&char errors)
    # Return value: New reference.
    # Get an IncrementalEncoder object for the given encoding.

    fn r&mut PyObject PyCodec_IncrementalDecoder(r&char encoding, r&char errors)
    # Return value: New reference.
    # Get an IncrementalDecoder object for the given encoding.

    fn r&mut PyObject PyCodec_StreamReader(r&char encoding, r&mut PyObject stream, r&char errors)
    # Return value: New reference.
    # Get a StreamReader factory function for the given encoding.

    fn r&mut PyObject PyCodec_StreamWriter(r&char encoding, r&mut PyObject stream, r&char errors)
    # Return value: New reference.
    # Get a StreamWriter factory function for the given encoding.


    # Registry API for Unicode encoding error handlers

    fn i32 PyCodec_RegisterError(r&char name, r&mut PyObject error) except? -1
    # Register the error handling callback function error under the given
    # name. This callback function will be called by a codec when it
    # encounters unencodable characters/undecodable bytes and name is
    # specified as the error parameter in the call to the encode/decode
    # function.

    # The callback gets a single argument, an instance of
    # UnicodeEncodeError, UnicodeDecodeError or UnicodeTranslateError that
    # holds information about the problematic sequence of characters or bytes
    # and their offset in the original string (see Unicode Exception Objects
    # for functions to extract this information). The callback must either
    # raise the given exception, or return a two-item tuple containing the
    # replacement for the problematic sequence, and an integer giving the
    # offset in the original string at which encoding/decoding should be
    # resumed.

    # Return 0 on success, -1 on error.

    fn r&mut PyObject PyCodec_LookupError(r&char name)
    # Return value: New reference.
    # Lookup the error handling callback function registered under name. As a
    # special case NULL can be passed, in which case the error handling
    # callback for "strict" will be returned.

    fn r&mut PyObject PyCodec_StrictErrors(r&mut PyObject exc)
    # Return value: Always NULL.
    # Raise exc as an exception.

    fn r&mut PyObject PyCodec_IgnoreErrors(r&mut PyObject exc)
    # Return value: New reference.
    # Ignore the unicode error, skipping the faulty input.

    fn r&mut PyObject PyCodec_ReplaceErrors(r&mut PyObject exc)
    # Return value: New reference.
    # Replace the unicode encode error with "?" or "U+FFFD".

    fn r&mut PyObject PyCodec_XMLCharRefReplaceErrors(object exc)
    # Return value: New reference.
    # Replace the unicode encode error with XML character references.

    fn r&mut PyObject PyCodec_BackslashReplaceErrors(r&mut PyObject exc)
    # Return value: New reference.
    # Replace the unicode encode error with backslash escapes ("\x", "\u"
    # and "\U").

    fn r&mut PyObject PyCodec_NameReplaceErrors(r&mut PyObject exc)
    # Return value: New reference.
    # Replace the unicode encode error with "\N{...}" escapes.

    # New in version 3.5.
