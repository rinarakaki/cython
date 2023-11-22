cdef r&i8 c_string = "Hello to A C-string's world"

cdef i8 c
for c in c_string[:11]:
    if c == 'A':
        print("Found the letter A")
