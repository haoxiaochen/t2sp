#include "util.h"

using namespace Halide;

int main(int argc, char **argv) {
    // Check complex parameters
    Param<complex32_t> a;
    Param<complex32_t> b;
    a.set(complex32_t(1.5f, -2.0f));
    b.set(complex32_t(1.5f, 2.0f));
    complex32_t result = evaluate<complex32_t>(a + b);
    if (result != complex32_t(1.5f, -2.0f) + complex32_t(1.5f, 2.0f)) {
        printf("Incorrect result (%f, %fi)!\n", result.re(), result.im());
        abort();
    }
    result = evaluate<complex32_t>(a - b);
    if (result != complex32_t(1.5f, -2.0f) - complex32_t(1.5f, 2.0f)) {
        printf("Incorrect result (%f, %fi)!\n", result.re(), result.im());
        abort();
    }
    result = evaluate<complex32_t>(a * b);
    if (result != complex32_t(1.5f, -2.0f) * complex32_t(1.5f, 2.0f)) {
        printf("Incorrect result (%f, %fi)!\n", result.re(), result.im());
        abort();
    }
    result = evaluate<complex32_t>(a / b);
    if (result != complex32_t(1.5f, -2.0f) / complex32_t(1.5f, 2.0f)) {
        printf("Incorrect result (%f, %fi)!\n", result.re(), result.im());
        abort();
    }

    printf("Success!\n");
    return 0;
}
