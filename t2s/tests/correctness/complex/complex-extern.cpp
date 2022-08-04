#include "util.h"

using namespace Halide;

int main(int argc, char **argv) {
    // Check if the external call works for complex32_t on FPGA. 
    Var x, y;
    Func output("output", Complex(32), {x, y}, Place::Device);
    complex32_t constant(100.0f, 0.0f);

    output(x, y) = fast_inverse_sqrt(constant) + sqrt(constant);

    Target target = get_host_target();
    target.set_feature(Target::IntelFPGA);
    target.set_feature(Target::Debug);
    // output.compile_jit(target);
    Buffer<complex32_t> buf = output.realize({8, 8}, target);
    for (int y = 0; y < 8; y++) {
        for (int x = 0; x < 8; x++) {
            complex32_t correct = complex32_t(10.1f, 0.0f);
            if (buf(x, y) != correct) {
                printf("buf(%d, %d) = (%f, %fi) instead of (%f, %fi)\n",
                        x, y, buf(x, y).re(), buf(x, y).im(), correct.re(), correct.im());
                abort();
            }
        }
    }

    printf("Success!\n");
    return 0;
}
