# mode: error

struct struct_type_not_boolean:
    i32 i
    f32 f

if struct_type_not_boolean:
    print("INVALID CODE")

struct struct_not_boolean:
    i32 i
    f32 f

if struct_not_boolean:
    print("INVALID CODE")

union union_type_not_boolean:
    i32 i
    f32 f

if union_type_not_boolean:
    print("INVALID CODE")

union union_not_boolean:
    i32 i
    f32 f

if union_not_boolean:
    print("INVALID CODE")


_ERRORS = u"""
7:3: 'struct_type_not_boolean' is not a constant, variable or function identifier
7:3: Type 'struct_type_not_boolean' not acceptable as a boolean

14:3: 'struct_not_boolean' is not a constant, variable or function identifier
14:3: Type 'struct_not_boolean' not acceptable as a boolean

21:3: 'union_type_not_boolean' is not a constant, variable or function identifier
21:3: Type 'union_type_not_boolean' not acceptable as a boolean

28:3: 'union_not_boolean' is not a constant, variable or function identifier
28:3: Type 'union_not_boolean' not acceptable as a boolean
"""
