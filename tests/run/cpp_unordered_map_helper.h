#include <functional>
#include <vector>

struct IntVectorHash {
    size_t operator()(const std::vector<int32_t>& v) const {
        std::hash<int32_t> hasher;
        size_t seed = 0;
        for (int32_t i : v) {
            seed ^= hasher(i) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
        }
        return seed;
    }
};
