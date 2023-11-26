cdef bytes bytes_string = b"hello to A bytes' world"

cdef i8 c
for c in bytes_string:
    if c == 'A':
        print("Found the letter A")
