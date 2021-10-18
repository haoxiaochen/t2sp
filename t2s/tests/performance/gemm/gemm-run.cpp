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
// The header file generated by gemm.cpp
#include "gemm-interface.h"

// Loop bounds
#include "sizes.h"

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

    Halide::Runtime::Buffer<float> a(TOTAL_K, TOTAL_I), b(TOTAL_J, TOTAL_K);
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            a(k, i) = random();
        }
    }
    for (size_t k = 0; k < TOTAL_K; k++) {
        for (size_t j = 0; j < TOTAL_J; j++) {
            b(j, k) = random();
        }
    }

    Halide::Runtime::Buffer<float> c(JJJ, III, JJ, II, J, I);
    GEMM(a, b, c);

#ifdef TINY
    // Validate the results
    for (int i = 0; i < I; i++)
    for (int j = 0; j < J; j++)
        for (int ii = 0; ii < II; ii++)
        for (int jj = 0; jj < JJ; jj++)
            for (int iii = 0; iii < III; iii++)
            for (int jjj = 0; jjj < JJJ; jjj++) {
                size_t total_i = iii + III * ii + III * II * i;
                size_t total_j = jjj + JJJ * jj + JJJ * JJ * j;
                float golden = 0.0f;
                for (int k = 0; k < TOTAL_K; k++)
                    golden += a(k, total_i) * b(total_j, k);
                assert(fabs(golden - c(jjj, iii, jj, ii, j, i)) < 0.005*fabs(golden));
            }
#else
    // Report performance. DSPs, FMax and ExecTime are automatically figured out from the static analysis
    // during FPGA synthesis and and the dynamic profile during the FGPA execution.
    double mem_bandwidth = 34; // pac_a10 on DevCloud has 34GB/s memory bandwidth
    double compute_roof = 2 * DSPs() * FMax();
    double number_ops = 2 * (double)(III * II * I) * (double)(JJJ * JJ * J) * (double)(KKK * KK * K); // Total operations (GFLOP for GEMM), independent of designs
    double number_bytes = (double)(KKK * III) * (double)(KK * II) * (double)(K * J * I) * 4 +
                          (double)(KKK * JJJ) * (double)(KK * JJ) * (double)(K * J * I) * 4 +
                          (double)(III * II * I) * (double)(JJJ * JJ * J) * 4;
    double exec_time= ExecTime();
    roofline(mem_bandwidth, compute_roof, number_ops, number_bytes,exec_time);
    if (fopen("roofline.png", "r") == NULL) {
        cout << "Failed to draw roofline!\n";
        return 1;
    }
#endif

    printf("Success\n");
    return 0;
}
