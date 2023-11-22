extern from "ctypedef_int_types_chdr_T333.h":
    type SChar = i32      # "signed char"
    type UChar = i32      # "unsigned char"
    type SShort = i32     # "signed short"
    type UShort = i32     # "unsigned short"
    type SInt = i32       # "signed int"
    type UInt = i32       # "unsigned int"
    type SLong = i32      # "signed long"
    type ULong = i32      # "unsigned long"
    type SLongLong = i32  # "signed PY_LONG_LONG"
    type ULongLong = i32  # "unsigned PY_LONG_LONG"

extern from *:
    type ExtSInt "signed short" = i32
    type ExtUInt "unsigned short" = i32
