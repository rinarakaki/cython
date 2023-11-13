# define a global name for whatever char type is used in the module
type char_type = u8

fn char_type[:] _chars(s):
    if isinstance(s, unicode):
        # encode to the specific encoding used inside of the module
        s = (<unicode>s).encode('utf8')
    return s
