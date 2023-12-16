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
#ifndef GEMM_CONST_PARAMS_H
#define GEMM_CONST_PARAMS_H

// Inner loop bounds, which are static constant parameters of the design
#ifdef GPU
    #define VI          16
    #define III         1
    #define II          8
    #define KK          32
#else // FPGA
    #ifdef TINY // For verifying correctness only
        #define VI          32
        #define III         32
        #define II          1
        #define KK          32
    #elif S10
        #define VI          64
        #define III         32
        #define II          1
        #define KK          1024
    #else
        #define VI          32
        #define III         32
        #define II          1
        #define KK          1024
    #endif
#endif

#endif
