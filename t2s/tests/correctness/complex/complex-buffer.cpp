#include "util.h"

using namespace Halide;

int main(int argc, char **argv) {
    // Write a constant value and check we can read it back. Mostly
    // this checks the addressing math is doing the right thing for
    // complex32_t.
    Halide::Buffer<complex32_t> img(10, 3);
    img.set_min(4, -6);

    img.for_each_element([&](int x, int y) {
        img(x, y) = complex32_t(x + y / 8.0, y + x / 8.0);
    });

    if (img.size_in_bytes() != img.number_of_elements() * 8) {
        printf("Incorrect amount of memory allocated\n");
        abort();
    }

    for (int y = img.dim(1).min(); y <= img.dim(1).max(); y++) {
        for (int x = img.dim(0).min(); x <= img.dim(0).max(); x++) {
            complex32_t correct = complex32_t(x + y / 8.0, y + x / 8.0);
            complex32_t actual = img(x, y);
            if (correct != actual) {
                printf("img(%d, %d) = (%f, %fi) instead of (%f, %fi)\n",
                    x, y, actual.re(), actual.im(), correct.re(), correct.im());
                abort();
            }
        }
    }

    printf("Success!\n");
    return 0;
}
