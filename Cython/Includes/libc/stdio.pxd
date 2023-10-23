# 7.19 Input/output <stdio.h>


# deprecated cimports for backwards compatibility:
from libc.string cimport const_char, const_void

extern from "<stdio.h>" nogil:
    ctypedef struct FILE
    cdef FILE *stdin
    cdef FILE *stdout
    cdef FILE *stderr

    enum: FOPEN_MAX
    enum: FILENAME_MAX
    FILE *fopen   (const char *filename, const char  *opentype)
    FILE *freopen (const char *filename, const char *opentype, FILE *stream)
    FILE *fdopen  (int fdescriptor, const char *opentype)
    fn i32  fclose(FILE *stream)
    fn i32  remove(const char *filename)
    fn i32  rename(const char *oldname, const char *newname)
    FILE *tmpfile ()

    fn i32 remove(const char *pathname)
    fn i32 rename(const char *oldpath, const char *newpath)

    enum: _IOFBF
    enum: _IOLBF
    enum: _IONBF
    fn i32 setvbuf(FILE *stream, char *buf, int mode, size_t size)
    enum: BUFSIZ
    fn void setbuf(FILE *stream, char *buf)

    fn usize fread(void *data, size_t size, size_t count, FILE *stream)
    fn usize fwrite(const void *data, size_t size, size_t count, FILE *stream)
    fn i32   fflush(FILE *stream)

    enum: EOF
    fn void clearerr(FILE *stream)
    fn i32  feof(FILE *stream)
    fn i32  ferror(FILE *stream)

    enum: SEEK_SET
    enum: SEEK_CUR
    enum: SEEK_END
    fn i32  fseek(FILE *stream, long int offset, int whence)
    fn void rewind(FILE *stream)
    long int ftell(FILE *stream)

    ctypedef struct fpos_t
    ctypedef const fpos_t const_fpos_t "const fpos_t"
    fn i32 fgetpos(FILE *stream, fpos_t *position)
    fn i32 fsetpos(FILE *stream, const fpos_t *position)

    fn i32 scanf(const char *template, ...)
    fn i32 sscanf(const char *s, const char *template, ...)
    fn i32 fscanf(FILE *stream, const char *template, ...)

    fn i32 printf(const char *template, ...)
    fn i32 sprintf(char *s, const char *template, ...)
    fn i32 snprintf(char *s, size_t size, const char *template, ...)
    fn i32 fprintf(FILE *stream, const char *template, ...)

    fn void perror(const char *message)

    fn char *gets(char *s)
    fn char *fgets(char *s, int count, FILE *stream)
    fn i32 getchar()
    fn i32 fgetc(FILE *stream)
    fn i32 getc(FILE *stream)
    fn i32 ungetc(i32 c, FILE *stream)

    fn i32 puts(const char *s)
    fn i32 fputs(const char *s, FILE *stream)
    fn i32 putchar(i32 c)
    fn i32 fputc(i32 c, FILE *stream)
    fn i32 putc(i32 c, FILE *stream)

    fn usize getline(char **lineptr, size_t *n, FILE *stream)
