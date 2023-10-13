extern from "string.h":
    char* strstr(const char *haystack, const char *needle)

let char* data = "hfvcakdfagbcffvschvxcdfgccbcfhvgcsnfxjh"

let char* pos = strstr(needle='akd', haystack=data)
print(pos is not NULL)
