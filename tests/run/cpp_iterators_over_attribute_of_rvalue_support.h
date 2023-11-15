#include <vector>

class HasIterableAttribute {
public:
    std::vector<int32_t> vec;
    HasIterableAttribute() {
        for (int32_t i = 1; i<=3; i++)
            vec.push_back(i);
    }
    HasIterableAttribute(std::vector<int32_t> vec) : vec(vec) {}
};
