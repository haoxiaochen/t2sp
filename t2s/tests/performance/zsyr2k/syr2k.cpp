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
#include "Halide.h"
#include "util.h"

// Constant parameters (inner loop bounds) of the design
#include "const-parameters.h"

using namespace Halide;

int main()
{
    // Dependences. We do not flatten i and k because k does not exist in P_Out.
    // We do not flatten i and j either, because we need remove j from A_serializer.
    #define P               kkk,      jjj,  iii,  jj, ii, kk,     k,  j,i
    #define P_kkk_minus_1   kkk-1,    jjj,  iii,  jj, ii, kk,     k,  j,i
    #define P_kk_minus_1    kkk+KKK-1,jjj,  iii,  jj, ii, kk-1,   k,  j,i
    #define P_k_minus_1     kkk+KKK-1,jjj,  iii,  jj, ii, kk+KK-1,k-1,j,i
    #define P_jjj_minus_1   kkk,      jjj-1,iii,  jj, ii, kk,     k,  j,i
    #define P_iii_minus_1   kkk,      jjj,  iii-1,jj, ii, kk,     k,  j,i
    #define P_Out                     jjj,  iii,  jj, ii,             j,i

    // Dependences. We do not flatten i and k because k does not exist in P_Out.
    // We do not flatten i and j either, because we need remove j from A_serializer.
    #define P_T               kkk,      iii,  jjj,  ii, jj, kk,     k,  i,j
    #define P_T_kkk_minus_1   kkk-1,    iii,  jjj,  ii, jj, kk,     k,  i,j
    #define P_T_kk_minus_1    kkk+KKK-1,iii,  jjj,  ii, jj, kk-1,   k,  i,j
    #define P_T_k_minus_1     kkk+KKK-1,iii,  jjj,  ii, jj, kk+KK-1,k-1,i,j
    #define P_T_jjj_minus_1   kkk,      iii,  jjj-1,ii, jj, kk,     k,  i,j
    #define P_T_iii_minus_1   kkk,      iii-1,jjj,  ii, jj, kk,     k,  i,j
    #define P_T_Out                     iii,  jjj,  ii, jj,             i,j

    // Linearized addresses
    #define total_i         (iii + III * ii + III * II * i)
    #define total_j         (jjj + JJJ * jj + JJJ * JJ * j)
    #define total_k         (kkk + KKK * kk + KKK * KK * k)

    // For now, do not flatten i and k. Enable this feature in the next step, and
    // transfer only half of the matrix A.
    // #define i_k             ((((2 * K - i + 1) * i) / 2) + (k - i + 1))

    // Outer loop bounds, which are determined by input sizes
    #define I (A.dim(1).extent() / (III * II))
    #define J (B.dim(0).extent() / (JJJ * JJ))
    #define K (A.dim(0).extent() / (KKK * KK))

    // Type of the data to process in C and T2S 
    #define CTYPE complex64_t
    #define TTYPE Complex(64)

    // Inputs
    ImageParam A("A", TTYPE, 2), B("B", TTYPE, 2);
    // Variables
    Var kkk("kkk"), jjj("jjj"), iii("iii"), jj("jj"), ii("ii"), kk("kk"), k("k"), j("j"), i("i");

    // First systolic array
    URE X("X", TTYPE, {P}), Y("Y", TTYPE, {P}), Z("Z", TTYPE, {P}), Out("Out");
    X(P) = select(jjj == 0, A(total_k, total_i), X(P_jjj_minus_1));
    Y(P) = select(iii == 0, B(total_j, total_k), Y(P_iii_minus_1));
    Z(P) = select(kkk == 0 && kk == 0 && k == 0, 0,
                select(kkk == 0, select(kk == 0, Z(P_k_minus_1), Z(P_kk_minus_1)), Z(P_kkk_minus_1)))
                + X(P) * Y(P);
    Out(P_Out) = select(kkk == KKK-1 && kk == KK-1 && k == K-1, Z(P));
    X.merge_ures(Y, Z, Out);
    X.set_bounds(jjj, 0, JJJ, iii, 0, III, kkk, 0, KKK)
     .set_bounds(jj,  0, JJ,  ii,  0, II,  kk,  0, KK)
     .set_bounds(j,   i, J-i, i,   0, I,   k,   0, K);
    X.space_time_transform(jjj, iii);

    // Second systolic array
    URE X_T("X_T", TTYPE, {P_T}), Y_T("Y_T", TTYPE, {P_T}), Z_T("Z_T", TTYPE, {P_T}), Out_T("Out_T");
    X_T(P_T) = select(jjj == 0, A(total_k, total_i), X_T(P_T_jjj_minus_1));
    Y_T(P_T) = select(iii == 0, B(total_j, total_k), Y_T(P_T_iii_minus_1));
    Z_T(P_T) = select(kkk == 0 && kk == 0 && k == 0, 0,
                select(kkk == 0, select(kk == 0, Z_T(P_T_k_minus_1), Z_T(P_T_kk_minus_1)), Z_T(P_T_kkk_minus_1)))
                + X_T(P_T) * Y_T(P_T);
    Out_T(P_T_Out) = select(kkk == KKK-1 && kk == KK-1 && k == K-1, Z_T(P_T));
    X_T.merge_ures(Y_T, Z_T, Out_T);
    X_T.set_bounds(jjj, 0, JJJ, iii, 0, III, kkk, 0, KKK)
       .set_bounds(jj,  0, JJ,  ii,  0, II,  kk,  0, KK)
       .set_bounds(j,   0, J,   i,   j, I-j, k,   0, K);
    X_T.space_time_transform(jjj, iii);

    // Add the two result
    URE E("E");
    E(P_Out) = Out(P_Out) + Out_T(P_Out);
    E.set_bounds(jjj, 0, JJJ, iii, 0, III)
     .set_bounds(jj,  0, JJ,  ii,  0, II)
     .set_bounds(j,   i, J-i, i,   0, I);

    // I/O network for the first systolic array
    // Input path of matrix A
    Func ASerializer("ASerializer", Place::Host), ALoader("ALoader", Place::Device), AFeeder("AFeeder", Place::Device);
    X.isolate_producer_chain(A, ASerializer, ALoader, AFeeder);
    ASerializer.remove(jjj, jj, j);
    ALoader.remove(jjj, jj);
    ALoader.vectorize(kkk);
    AFeeder.buffer(ALoader, k);
    AFeeder.scatter(ALoader, iii);
    AFeeder.vectorize(kkk);

    // Input path of matrix B
    Func BSerializer("BSerializer", Place::Host), BLoader("BLoader", Place::Device), BFeeder("BFeeder", Place::Device);
    X.isolate_producer_chain(B, BSerializer, BLoader, BFeeder);
    BSerializer.set_bounds(j, 0, J).remove(iii, ii, i);
    BLoader.remove(iii, ii);
    BLoader.vectorize(kkk);
    BFeeder.buffer(BLoader, k);
    BFeeder.scatter(BLoader, jjj);
    BFeeder.vectorize(kkk);

    // Output path
    Out.relay(Z, jjj);
    X.vectorize(kkk);

    // I/O network for the second systolic array
    // Input path of matrix B
    Func ASerializer_T("ASerializer_T", Place::Host), ALoader_T("ALoader_T", Place::Device), AFeeder_T("AFeeder_T", Place::Device);
    X_T.isolate_producer_chain(A, ASerializer_T, ALoader_T, AFeeder_T);
    ASerializer_T.set_bounds(i, 0, I).remove(jjj, jj, j);
    ALoader_T.remove(jjj, jj);
    ALoader_T.vectorize(kkk);
    AFeeder_T.buffer(ALoader_T, k);
    AFeeder_T.scatter(ALoader_T, iii);
    AFeeder_T.vectorize(kkk);

    // Input path of matrix B
    Func BSerializer_T("BSerializer_T", Place::Host), BLoader_T("BLoader_T", Place::Device), BFeeder_T("BFeeder_T", Place::Device);
    X_T.isolate_producer_chain(B, BSerializer_T, BLoader_T, BFeeder_T);
    BSerializer_T.remove(iii, ii, i);
    BLoader_T.remove(iii, ii);
    BLoader_T.vectorize(kkk);
    BFeeder_T.buffer(BLoader_T, k);
    BFeeder_T.scatter(BLoader_T, jjj);
    BFeeder_T.vectorize(kkk);

    // Output path
    // Out_T.relay(Z_T, iii);
    Out_T.relay(Z_T, jjj);
    X_T.vectorize(kkk);

    // I/O network for E
    Func deserializer("deserializer", Place::Host), unloader("unloader", Place::Device);
    E.isolate_consumer_chain(unloader, deserializer);
    E.vectorize(jjj);
    unloader.vectorize(jjj);
    deserializer.vectorize(jjj);

    // Compile the kernel to an FPGA bitstream, and expose a C interface for the host to invoke
    Target acc = get_host_target();
    acc.set_feature(Target::IntelFPGA);
    acc.set_feature(Target::EnableSynthesis);
    deserializer.compile_to_host("syr2k-interface", { A, B }, "syr2k", acc);

    printf("Success\n");
    return 0;
}
