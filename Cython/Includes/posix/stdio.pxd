# POSIX additions to <stdio.h>.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdio.h.html

use libc::stdio::FILE
use libc::stddef::wchar_t
use posix::types::off_t

extern from "<stdio.h>" nogil:
    # File descriptors
    fn FILE *fdopen(i32, r&i8)
    fn i32 fileno(FILE *)

    # Pipes
    fn FILE *popen(r&i8 , r&i8)
    fn i32 pclose(FILE *)

    # Memory streams (POSIX.2008)
    fn FILE *fmemopen(void *, usize, r&i8)
    fn FILE *open_memstream(i8**, usize *)
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
    fn isize getline(i8**, usize *, FILE *)
    fn isize getdelim(i8**, usize *, i32, FILE *)
