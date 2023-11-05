extern from *:
    cpdef enum:  # ExternPxd
        Four "4"
        Eight "8"

    enum:  # ExternSecretPxd
        Sixteen "16"

cpdef enum PxdEnum:
    Rank0 = 11
    Rank1 = 37
    Rank2 = 389

cpdef enum CpdefPxdDocEnum:
    """Home is where...
    """
    Rank6 = 159

cpdef enum CpdefPxdDocLineEnum:
    """Home is where..."""
    Rank7 = 889

enum PxdSecretEnum:
    Rank8 = 5077

enum cdefPxdDocEnum:
    """the heart is.
    """
    Rank9 = 2458
