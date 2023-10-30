# POSIX additions to <stdio.h>.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdio.h.html

from libc.stdio cimport FILE
from libc.stddef cimport wchar_t
from posix.types cimport off_t

extern from "<stdio.h>" nogil:
    # File descriptors
    fn FILE *fdopen(i32, const char *)
    fn i32 fileno(FILE *)

    # Pipes
    fn FILE *popen(const char *, const char *)
    fn i32 pclose(FILE *)

    # Memory streams (POSIX.2008)
    fn FILE *fmemopen(void *, usize, const char *)
    fn FILE *open_memstream(char **, usize *)
    fn FILE *open_wmemstream(wchar_t **, usize *)

    # Seek and tell with off_t
    fn i32 fseeko(FILE *, off_t, i32)
    fn off_t ftello(FILE *)

    # Locking (for multithreading)
    fn void flockfile(FILE *)
    fn i32 ftrylockfile(FILE *)
    fn void funlockfile(FILE *)
    fn i32 getc_unlocked(FILE *)
    fn i32 getchar_unlocked()
    fn i32 putc_unlocked(i32, FILE *)
    fn i32 putchar_unlocked(i32)

    # Reading lines and records (POSIX.2008)
    fn isize getline(char **, usize *, FILE *)
    fn isize getdelim(char **, usize *, i32, FILE *)
