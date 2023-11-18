# 7.19 Input/output <stdio.h>


# deprecated cimports for backwards compatibility:
use libc::string::(const_char, const_void)

extern from "<stdio.h>" nogil:
    struct FILE
    static FILE* stdin
    static FILE* stdout
    static FILE* stderr

    enum: FOPEN_MAX
    enum: FILENAME_MAX
    fn FILE* fopen(&char filename, const char  *opentype)
    fn FILE* freopen(&char filename, &char opentype, FILE* stream)
    fn FILE* fdopen(i32 fdescriptor, &char opentype)
    fn i32 fclose(FILE* stream)
    fn i32 remove(&char filename)
    fn i32 rename(&char oldname, &char newname)
    fn FILE* tmpfile ()

    fn i32 remove(&char pathname)
    fn i32 rename(&char oldpath, &char newpath)

    enum: _IOFBF
    enum: _IOLBF
    enum: _IONBF
    fn i32 setvbuf(FILE* stream, &char buf, i32 mode, usize size)
    enum: BUFSIZ
    fn void setbuf(FILE* stream, &char buf)

    fn usize fread(void* data, usize size, usize count, FILE* stream)
    fn usize fwrite(const void* data, usize size, usize count, FILE* stream)
    fn i32   fflush(FILE* stream)

    enum: EOF
    fn void clearerr(FILE* stream)
    fn i32 feof(FILE* stream)
    fn i32 ferror(FILE* stream)

    enum: SEEK_SET
    enum: SEEK_CUR
    enum: SEEK_END
    fn i32 fseek(FILE* stream, i64 offset, i32 whence)
    fn void rewind(FILE* stream)
    fn i64 ftell(FILE* stream)

    struct fpos_t
    type const_fpos_t "const fpos_t" = const fpos_t
    fn i32 fgetpos(FILE* stream, fpos_t* position)
    fn i32 fsetpos(FILE* stream, const fpos_t* position)

    fn i32 scanf(&char template, ...)
    fn i32 sscanf(&char s, &char template, ...)
    fn i32 fscanf(FILE* stream, &char template, ...)

    fn i32 printf(&char template, ...)
    fn i32 sprintf(&char s, &char template, ...)
    fn i32 snprintf(&char s, usize size, &char template, ...)
    fn i32 fprintf(FILE* stream, &char template, ...)

    fn void perror(&char message)

    fn &char gets(&char s)
    fn &char fgets(&char s, i32 count, FILE* stream)
    fn i32 getchar()
    fn i32 fgetc(FILE* stream)
    fn i32 getc(FILE* stream)
    fn i32 ungetc(i32 c, FILE* stream)

    fn i32 puts(&char s)
    fn i32 fputs(&char s, FILE* stream)
    fn i32 putchar(i32 c)
    fn i32 fputc(i32 c, FILE* stream)
    fn i32 putc(i32 c, FILE* stream)

    fn usize getline(&char* lineptr, usize *n, FILE* stream)
