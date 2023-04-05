#include "trmm-interface.h"

// Constant parameters (inner loop bounds) of the design
#include "const-parameters.h"

// Outer loop bounds for testing
#ifdef TINY // For verifying correctness only
    #define K           4//4
    #define J           4//4
    #define I           4//4
#else
    #define K           32
    #define J           32
    #define I           32
#endif

// Roofline utilities
#include "Roofline.h"

// The only header file needed for including T2S.
#include "HalideBuffer.h"

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

    assert(I == K);
    assert(TOTAL_I == TOTAL_K);

    Halide::Runtime::Buffer<double> a(TOTAL_K, TOTAL_I), b(TOTAL_J, TOTAL_K);
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            a(k, i) = (k < i) ? 0 : random(); //random();
        }
    }
    for (size_t k = 0; k < TOTAL_K; k++) {
        for (size_t j = 0; j < TOTAL_J; j++) {
            b(j, k) = random(); //random();
        }
    }

#ifdef TINY
    // Validate the results
    Halide::Runtime::Buffer<double> golden(JJJ, III, JJ, II, J, I);
    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
        for (int ii = 0; ii < II; ii++)
        for (int jj = 0; jj < JJ; jj++)
            for (int iii = 0; iii < III; iii++)
            for (int jjj = 0; jjj < JJJ; jjj++) {
                golden(jjj, iii, jj, ii, j, i) = 0.0f;
            }

    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
    for (int k = i; k < K; k++)
        for (int kk = 0; kk < KK; kk++)
        for (int ii = 0; ii < II; ii++)
        for (int jj = 0; jj < JJ; jj++)
            for (int iii = 0; iii < III; iii++)
            for (int jjj = 0; jjj < JJJ; jjj++)
            for (int kkk = 0; kkk < KKK; kkk++) {
                size_t total_i = iii + III * ii + III * II * i;
                size_t total_j = jjj + JJJ * jj + JJJ * JJ * j;
                size_t total_k = kkk + KKK * kk + KKK * KK * k;
                // if (jjj==1 && iii==0 && jj==0 && ii==0 && j == 0 && i == 0)
                // printf("jjj=%i iii=%i jj=%i ii=%i j=%i i=%i: a=%f, b=%f\n",
                //         jjj, iii, jj, ii, j, i, a(total_k, total_i), b(total_j, total_k)
                // );
                golden(jjj, iii, jj, ii, j, i) += a(total_k, total_i) * b(total_j, total_k);
            }
#endif

    Halide::Runtime::Buffer<double> c(JJJ, III, JJ, II, J, I);
    trmm(a, b, c);

#ifdef TINY
    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
        for (int ii = 0; ii < II; ii++)
        for (int jj = 0; jj < JJ; jj++)
            for (int iii = 0; iii < III; iii++)
            for (int jjj = 0; jjj < JJJ; jjj++) {
                // printf("jjj=%i iii=%i jj=%i ii=%i j=%i i=%i: golden=%f, c=%f\n",
                //         jjj, iii, jj, ii, j, i, golden(jjj, iii, jj, ii, j, i), c(jjj, iii, jj, ii, j, i)
                // );
                if (!(fabs(golden(jjj, iii, jj, ii, j, i) - c(jjj, iii, jj, ii, j, i))
                        < 0.005*fabs(golden(jjj, iii, jj, ii, j, i)))) {
                    printf("%f, %f\n", c(jjj, iii, jj, ii, j, i), golden(jjj, iii, jj, ii, j, i));
                    exit(1);
                }
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
    double number_ops = 2 * (double)(III * II * I) * (double)(JJJ * JJ * J) * (double)(KKK * KK * K); // Total operations (GFLOP for GEMM), independent of designs
    double number_bytes = (double)(KKK * III) * (double)(KK * II) * (double)(K * J * I) * 8.0 +
                          (double)(KKK * JJJ) * (double)(KK * JJ) * (double)(K * J * I) * 8.0 +
                          (double)(III * II * I) * (double)(JJJ * JJ * J) * 8.0;
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
