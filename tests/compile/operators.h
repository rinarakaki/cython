#ifndef _OPERATORS_H_
#define _OPERATORS_H_

class Operators
{
public:
    int32_t value;
    Operators() { }
    Operators(int32_t value) { this->value = value; }
    virtual ~Operators() { }
    Operators operator+(Operators f) { return Operators(this->value + f.value); }
    Operators operator-(Operators f) { return Operators(this->value - f.value); }
    Operators operator*(Operators f) { return Operators(this->value * f.value); }
    Operators operator/(Operators f) { return Operators(this->value / f.value); }
    bool operator<(Operators f) { return this->value < f.value; }
    bool operator<=(Operators f) { return this->value <= f.value; }
    bool operator==(Operators f) { return this->value == f.value; }
    bool operator!=(Operators f) { return this->value != f.value; }
    bool operator>(Operators f) { return this->value > f.value; }
    bool operator>=(Operators f) { return this->value >= f.value; }
    Operators operator>>(int32_t v) { return Operators(this->value >> v); }
    Operators operator<<(int32_t v) { return Operators(this->value << v); }
    Operators operator%(int32_t v) { return Operators(this->value % v); }
};

#endif
