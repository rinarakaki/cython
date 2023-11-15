#ifndef _TEMPLATE_ARGS_H_
#define _TEMPLATE_ARGS_H_

template <typename T>
struct Bar {
    Bar & ref() { return *this; }
    const Bar & const_ref() { return *this; }
    const Bar & const_ref_const() const { return *this; }
    T value;
};

template <typename T>
struct Foo {
    int32_t bar_value(const Bar<int32_t> & bar) { return bar.value; }
};

#endif
