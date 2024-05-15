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
    #define JJJ         8
    #define III         32
    #define JJ          8
    #define II          2
    #define KK          1
#else // FPGA
    #ifdef TINY // For verifying correctness only
        #define JJJ         16
        #define III         16
        #define JJ          16
        #define II          16
    #elif S10
        #define JJJ         32
        #define III         32
        #define JJJ         16
        #define III         16
    #else
        #define JJJ         16
        #define III         16
        #define JJ          16
        #define II          16
    #endif
#endif

#endif
