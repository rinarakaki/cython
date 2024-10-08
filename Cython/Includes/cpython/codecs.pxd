extern from "Python.h":
    # #########################################################################
    # Codec registry and support functions
    # #########################################################################

    fn i32 PyCodec_Register(object search_function)
    # Register a new codec search function.

    # As side effect, this tries to load the encodings package, if not yet
    # done, to make sure that it is always first in the list of search
    # functions.

    fn i32 PyCodec_KnownEncoding(r&i8 encoding)
    # Return 1 or 0 depending on whether there is a registered codec for the
    # given encoding. This function always succeeds.

    fn object PyCodec_Encode(object o, r&i8 encoding, r&i8 errors)
    # Return value: New reference.
    # Generic codec based encoding API.

    # o is passed through the encoder function found for the given encoding
    # using the error handling method defined by errors. errors may be NULL
    # to use the default method defined for the codec. Raises a LookupError
    # if no encoder can be found.

    fn object PyCodec_Decode(object o, r&i8 encoding, r&i8 errors)
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

    fn object PyCodec_Encoder(r&i8 encoding)
    # Return value: New reference.
    # Get an encoder function for the given encoding.

    fn object PyCodec_Decoder(r&i8 encoding)
    # Return value: New reference.
    # Get a decoder function for the given encoding.

    fn object PyCodec_IncrementalEncoder(r&i8 encoding, r&i8 errors)
    # Return value: New reference.
    # Get an IncrementalEncoder object for the given encoding.

    fn object PyCodec_IncrementalDecoder(r&i8 encoding, r&i8 errors)
    # Return value: New reference.
    # Get an IncrementalDecoder object for the given encoding.

    fn object PyCodec_StreamReader(r&i8 encoding, object stream, r&i8 errors)
    # Return value: New reference.
    # Get a StreamReader factory function for the given encoding.

    fn object PyCodec_StreamWriter(r&i8 encoding, object stream, r&i8 errors)
    # Return value: New reference.
    # Get a StreamWriter factory function for the given encoding.


    # Registry API for Unicode encoding error handlers

    fn i32 PyCodec_RegisterError(r&i8 name, object error) except? -1
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

    fn object PyCodec_LookupError(r&i8 name)
    # Return value: New reference.
    # Lookup the error handling callback function registered under name. As a
    # special case NULL can be passed, in which case the error handling
    # callback for "strict" will be returned.

    fn object PyCodec_StrictErrors(object exc)
    # Return value: Always NULL.
    # Raise exc as an exception.

    fn object PyCodec_IgnoreErrors(object exc)
    # Return value: New reference.
    # Ignore the unicode error, skipping the faulty input.

    fn object PyCodec_ReplaceErrors(object exc)
    # Return value: New reference.
    # Replace the unicode encode error with "?" or "U+FFFD".

    fn object PyCodec_XMLCharRefReplaceErrors(object exc)
    # Return value: New reference.
    # Replace the unicode encode error with XML character references.

    fn object PyCodec_BackslashReplaceErrors(object exc)
    # Return value: New reference.
    # Replace the unicode encode error with backslash escapes ("\x", "\u"
    # and "\U").

    fn object PyCodec_NameReplaceErrors(object exc)
    # Return value: New reference.
    # Replace the unicode encode error with "\N{...}" escapes.

    # New in version 3.5.
