#include <stdexcept>

class CountAllocDealloc {
public:
    CountAllocDealloc(int32_t* alloc_count, int32_t* dealloc_count)
        : _alloc_count(alloc_count), _dealloc_count(dealloc_count) {
        (*_alloc_count)++;
    }
    ~CountAllocDealloc() {
        (*_dealloc_count)++;
    }
private:
    int32_t* _alloc_count;
    int32_t* _dealloc_count;
};

template<typename T>
struct FreePtr {
    void operator()(T* t)
    {
        if(t != nullptr) {
            delete t;
            t = nullptr;
        }
    }
};

class RaiseOnConstruct {
public:
    RaiseOnConstruct() {
        throw std::runtime_error("Oh no!");
    }
};
