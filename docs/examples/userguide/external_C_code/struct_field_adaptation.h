typedef struct {
    int32_t field1;
    int32_t field2;
    int32_t newly_added_field;
} StructType;

static StructType global_struct;

static StructType *get_struct_ptr() {
    return &global_struct;
}

#define C_LIB_VERSION 20
