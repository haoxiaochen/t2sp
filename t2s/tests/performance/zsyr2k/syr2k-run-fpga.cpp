#include "util.h"
#include "syr2k-interface.h"

// Constant parameters (inner loop bounds) of the design
#include "const-parameters.h"

// Outer loop bounds for testing
#ifdef TINY // For verifying correctness only
    #define K           4//4
    #define J           4//4
    #define I           4//4
#else
    #define K           64
    #define J           64
    #define I           64
#endif

// Roofline utilities
#include "Roofline.h"

// For printing output
#include <stdio.h>
#include <iostream>

// For validation of results.
#include <assert.h>

using namespace std;

int main()
{
    const int TOTAL_I = III * II * I;
    const int TOTAL_J = JJJ * JJ * J;
    const int TOTAL_K = KKK * KK * K;

    assert(I == J);
    assert(TOTAL_I == TOTAL_J);

    Halide::Runtime::Buffer<complex64_t> a(TOTAL_K, TOTAL_I), b(TOTAL_J, TOTAL_K);
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            a(k, i) = 1;
        }
    }
    for (size_t k = 0; k < TOTAL_K; k++) {
        for (size_t j = 0; j < TOTAL_J; j++) {
            b(j, k) = 1;
        }
    }

    Halide::Runtime::Buffer<complex64_t> c(JJJ, III, JJ, II, J, I);
    syr2k(a, b, c);
#ifdef TINY
    // Validate the results
    Halide::Runtime::Buffer<double> golden(JJJ, III, JJ, II, J, I);
    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
    for (int ii = 0; ii < II; ii++)
    for (int jj = 0; jj < JJ; jj++)
    for (int iii = 0; iii < III; iii++)
    for (int jjj = 0; jjj < JJJ; jjj++) {
        size_t total_i = iii + III * ii + III * II * i;
        size_t total_j = jjj + JJJ * jj + JJJ * JJ * j;
        double golden = 0.0f;
        for (int k = 0; k < TOTAL_K; k++) {
            golden += a(k, total_i) * b(total_j, k) + b(k, total_j) * a(total_i, k);
        }
        assert(fabs(golden - c(jjj, iii, jj, ii, j, i)) < 0.005*fabs(golden));
    }
#else
    // Report performance. DSPs, FMax and ExecTime are automatically figured out from the static analysis
    // during FPGA synthesis and and the dynamic profile during the FGPA execution.
#ifdef S10
    double mem_bandwidth = 75;
#else
    double mem_bandwidth = 33;
#endif
    double compute_roof = 2 * DSPs() * FMax();
    double number_ops = 8.0 * (double)(III * II * I) * (double)(JJJ * JJ * J) * (double)(KKK * KK * K); // Total operations (GFLOP for GEMM), independent of designs
    double number_bytes = (double)(KKK * III) * (double)(KK * II) * (double)(K * J * I) * 16.0 +
                          (double)(KKK * JJJ) * (double)(KK * JJ) * (double)(K * J * I) * 16.0 +
                          (double)(III * II * I) * (double)(JJJ * JJ * J) * 16.0;
    double exec_time = ExecTime("kernel_unloader");
    roofline(mem_bandwidth, compute_roof, number_ops, number_bytes, exec_time);
    if (fopen("roofline.png", "r") == NULL) {
        cout << "Failed to draw roofline!\n";
        return 1;
    }
    cout << "Size of matrix A: " << TOTAL_I << " * " << TOTAL_K << "\n";
    cout << "Size of matrix B: " << TOTAL_K << " * " << TOTAL_J << "\n";
#endif

    printf("Success\n");
    return 0;
}
