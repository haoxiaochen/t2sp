#include "util.h"

using namespace Halide;

int main(int argc, char **argv) {
    // Check constants are emitted correctly
    Func out;
    complex32_t constant(100.0f, 101.1f);
    out() = constant;
    Buffer<complex32_t> buf = out.realize();
    if (buf(0) != constant) {
        printf("buf(0) = (%f, %fi) instead of (%f, %fi)\n", buf(0).re(), buf(0).im(), constant.re(), constant.im());
        abort();
    }

    printf("Success!\n");
    return 0;
}
