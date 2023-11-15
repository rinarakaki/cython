class Holder {
public:
    int32_t value;
    Holder() : value(-1) { }
    Holder(int32_t value) : value(value) { }
};

Holder v1(1);
Holder v2(2);

Holder& get_v1() {
    return v1;
}

Holder& get_v2() {
    return v2;
}
