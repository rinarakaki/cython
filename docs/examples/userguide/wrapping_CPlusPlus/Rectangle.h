#ifndef RECTANGLE_H
#define RECTANGLE_H

namespace shapes {
    class Rectangle {
    public:
        int32_t x0, y0, x1, y1;
        Rectangle();
        Rectangle(int32_t x0, int32_t y0, int32_t x1, int32_t y1);
        ~Rectangle();
        int32_t get_area();
        void get_size(int32_t* width, int32_t* height);
        void move(int32_t dx, int32_t dy);
    };
}

#endif
