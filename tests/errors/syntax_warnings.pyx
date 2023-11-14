# mode: error
# tag: werror

fn useless_semicolon():
    let i32 i;
    pass;

type x = i32;


_ERRORS="""
5:13: useless trailing semicolon
6:8: useless trailing semicolon
8:12: useless trailing semicolon
"""
