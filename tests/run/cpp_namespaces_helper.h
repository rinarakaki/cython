namespace outer {
    int32_t x = 10;
    int32_t outer_value = 10;

    namespace inner {
        int32_t x = 100;
        int32_t inner_value = 100;
    }
}

namespace A {
    typedef int32_t A_t;

    struct S {
        A_t k;
        double x;
    };

    A_t A_func(A_t first, A_t second) {
        return first + second;
    }
}
