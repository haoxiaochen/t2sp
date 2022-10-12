/*******************************************************************************
* Copyright 2021 Intel Corporation
*
* Licensed under the BSD-2-Clause Plus Patent License (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* https://opensource.org/licenses/BSDplusPatent
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions
* and limitations under the License.
*
*
* SPDX-License-Identifier: BSD-2-Clause-Patent
*******************************************************************************/

#include "util.h"

// The header file generated by syrk.cpp
#include "syrk-interface.h"

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
            a(k, i) = complex64_t(random(), random());
        }
    }
    for (size_t k = 0; k < TOTAL_K; k++) {
        for (size_t j = 0; j < TOTAL_J; j++) {
            b(j, k) = a(k, j);
        }
    }

    Halide::Runtime::Buffer<complex64_t> c(JJJ, III, JJ, II, J, I);
    syrk(a, b, c);

#ifdef TINY
    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
        for (int ii = 0; ii < II; ii++)
        for (int jj = 0; jj < JJ; jj++)
            for (int iii = 0; iii < III; iii++)
            for (int jjj = 0; jjj < JJJ; jjj++) {
                size_t total_i = iii + III * ii + III * II * i;
                size_t total_j = jjj + JJJ * jj + JJJ * JJ * j;
                complex64_t golden = complex64_t(0.0, 0.0);
                for (int k = 0; k < TOTAL_K; k++)
                    golden += a(k, total_i) * b(total_j, k);
                assert(fabs(golden.re() - c(jjj, iii, jj, ii, j, i).re()) < 0.005*fabs(golden.re()) &&
                       fabs(golden.im() - c(jjj, iii, jj, ii, j, i).im()) < 0.005*fabs(golden.im()));
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
    double number_ops = 8 * (double)(III * II * I) * (double)(JJJ * JJ * J) * (double)(KKK * KK * K); // Total operations (GFLOP for GEMM), independent of designs
    double number_bytes = (double)(KKK * III) * (double)(KK * II) * (double)(K * J * I) * 16 +
                          (double)(KKK * JJJ) * (double)(KK * JJ) * (double)(K * J * I) * 16 +
                          (double)(III * II * I) * (double)(JJJ * JJ * J) * 16;
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
