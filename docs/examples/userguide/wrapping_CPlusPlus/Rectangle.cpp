#include <iostream>
#include "Rectangle.h"

namespace shapes {
	// Default constructor
	Rectangle::Rectangle () {}

	// Overloaded constructor
	Rectangle::Rectangle (int32_t x0, int32_t y0, int32_t x1, int32_t y1) {
		this->x0 = x0;
		this->y0 = y0;
		this->x1 = x1;
		this->y1 = y1;
	}

	// Destructor
	Rectangle::~Rectangle () {}

	// Return the area of the rectangle
	int32_t Rectangle::get_area () {
		return (this->x1 - this->x0) * (this->y1 - this->y0);
	}

	// Get the size of the rectangle.
	// Put the size in the pointer args
	void Rectangle::get_size (int32_t *width, int32_t *height) {
		(*width) = x1 - x0;
		(*height) = y1 - y0;
	}

	// Move the rectangle by dx dy
	void Rectangle::move (int32_t dx, int32_t dy) {
		this->x0 += dx;
		this->y0 += dy;
		this->x1 += dx;
		this->y1 += dy;
	}
}

