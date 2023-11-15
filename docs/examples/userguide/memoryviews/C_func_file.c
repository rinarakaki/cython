#include "C_func_file.h"

void multiply_by_10_in_C(double arr[], uint32_t n)
{
    uint32_t i;
    for (i = 0; i < n; i++) {
        arr[i] *= 10;
    }
}
