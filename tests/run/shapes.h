#ifndef SHAPES_H
#define SHAPES_H

namespace shapes {
    int32_t constructor_count = 0;
    int32_t destructor_count = 0;

    class Shape
    {
    public:
        virtual float area() const = 0;
        Shape() { constructor_count++; }
        virtual ~Shape() { destructor_count++; }
    };

    class Rectangle : public Shape
    {
    public:
        Rectangle() { }
        Rectangle(int32_t width, int32_t height)
        {
            this->width = width;
            this->height = height;
        }

        float area() const { return width * height; }
        int32_t width;
        int32_t height;

        int32_t method(int32_t arg) {
            return width * height + arg;
        }

    };

    class Square : public Rectangle
    {
    public:
        Square(int32_t side) : Rectangle(side, side) { this->side = side; }
        int32_t side;
    };
    
    class Ellipse : public Shape {
    public:
        Ellipse(int32_t a, int32_t b) { this->a = a; this->b = b; }
        float area() const { return 3.1415926535897931f * a * b; }
        int32_t a, b;
    };
    
    class Circle : public Ellipse {
    public:
        Circle(int32_t radius) : Ellipse(radius, radius) { this->radius = radius; }
        int32_t radius;
    };

    class Empty : public Shape {
    public:
        float area() const { return 0; }
    };

    class EmptyWithDocstring : public Shape {
    public:
        float area() const { return 0; }
    };
}

#endif
