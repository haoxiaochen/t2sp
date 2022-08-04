#include "util.h"

using namespace Halide;

int main(int argc, char **argv) {
    // Check we can pass a complex32 to a FPGA kernel. 
    Var x, y;
    ImageParam input(Complex(32), 2);
    Param<complex32_t> mul("mul");
    Func output("output", Complex(32), {x, y}, Place::Device);
    complex32_t constant(100.0f, 101.1f);

    output(x, y) = input(x, y) * mul + constant;

    mul.set(complex32_t(2.0f, 2.0f));
    Buffer<complex32_t> in(8, 8);
    in.fill(complex32_t(0.25f, 0.25f));
    input.set(in);

    Target target = get_host_target();
    target.set_feature(Target::IntelFPGA);
    target.set_feature(Target::Debug);
    // output.compile_jit(target);
    Buffer<complex32_t> buf = output.realize({8, 8}, target);
    for (int y = 0; y < 8; y++) {
        for (int x = 0; x < 8; x++) {
            complex32_t correct = complex32_t(100.0f, 102.1f);
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
