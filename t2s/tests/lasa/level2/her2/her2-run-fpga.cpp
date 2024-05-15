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
// The header file generated by ger.cpp
#include "her2-interface.h"

// Constant parameters (inner loop bounds) of the design
#include "const-parameters.h"

// Outer loop bounds for testing
#ifdef TINY // For verifying correctness only
    #define J           2
    #define I           2
#else
    #define J           1024
    #define I           1024
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
    const int TOTAL_I = II * I;
    const int TOTAL_J = JJ * J;

    Halide::Runtime::Buffer<complex32_t> a(TOTAL_J, TOTAL_I), x(TOTAL_I), y(TOTAL_J);
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t j = i; j < TOTAL_J; j++) {
            a(j, i) = complex32_t(random(), random());
            a(i, j) = a(j, i);
        }
    }
    for (size_t i = 0; i < TOTAL_I; i++) {
        x(i) = complex32_t(random(), random());
        y(i) = complex32_t(random(), random());
    }

    Halide::Runtime::Buffer<complex32_t> z(JJ, II, J, I);
    her2(a, x, y, z);

#ifdef TINY
    // Validate the results
    for (int i = 0; i < I; i++)
     for (int j = 0; j < J; j++)
        for (int ii = 0; ii < II; ii++)
         for (int jj = 0; jj < JJ; jj++) {
            size_t total_i = ii + II * i;
            size_t total_j = jj + JJ * j;
            if (i < j) {
                complex32_t golden = x(total_i) * y(total_j).conj() + x(total_j).conj() * y(total_i) + a(total_j, total_i);
                assert(fabs(golden.re() - z(jj, ii, j, i).re()) <= 0.005 * fabs(golden.re()) &&
                       fabs(golden.im() - z(jj, ii, j, i).im()) <= 0.005 * fabs(golden.im()));
            } else {
                complex32_t golden = x(total_i) * y(total_j).conj() + x(total_j).conj() * y(total_i) + a(total_j, total_i).conj();
                assert(fabs(golden.re() - z(ii, jj, i, j).re()) <= 0.005 * fabs(golden.re()) &&
                       fabs(golden.im() + z(ii, jj, i, j).im()) <= 0.005 * fabs(golden.im()));
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
    double number_ops = 8 * (double)(II * I) * (double)(JJ * J); // Total operations (GFLOP for GER), independent of designs
    double number_bytes = (double)(II * I) * (double)(JJ * J) * 4 +
                          (double)(II * I) * 4 + 
                          (double)(JJ * J) * 4;
    double exec_time = ExecTime("kernel_unloader");
    roofline(mem_bandwidth, compute_roof, number_ops, number_bytes, exec_time);
    if (fopen("roofline.png", "r") == NULL) {
        cout << "Failed to draw roofline!\n";
        return 1;
    }
#endif

    printf("Success\n");
    return 0;
}
