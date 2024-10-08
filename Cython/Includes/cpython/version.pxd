# Python version constants
#
# It's better to evaluate these at runtime (i.e. C compile time) using
#
#      if PY_MAJOR_VERSION >= 3:
#           do_stuff_in_Py3_0_and_later()
#      if PY_VERSION_HEX >= 0x02070000:
#           do_stuff_in_Py2_7_and_later()
#
# than using the IF/DEF statements, which are evaluated at Cython
# compile time.  This will keep your C code portable.


extern from *:
    # the complete version, e.g. 0x010502B2 == 1.5.2b2
    static i32 PY_VERSION_HEX

    # the individual sections as plain numbers
    static i32 PY_MAJOR_VERSION
    static i32 PY_MINOR_VERSION
    static i32 PY_MICRO_VERSION
    static i32 PY_RELEASE_LEVEL
    static i32 PY_RELEASE_SERIAL

    # Note: PY_RELEASE_LEVEL is one of
    #    0xA (alpha)
    #    0xB (beta)
    #    0xC (release candidate)
    #    0xF (final)

    static i8[] PY_VERSION
    static i8[] PY_PATCHLEVEL_REVISION
