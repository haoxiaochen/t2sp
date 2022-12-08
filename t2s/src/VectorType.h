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
#ifndef T2S_VECTOR_TYPE_H
#define T2S_VECTOR_TYPE_H

/** \file
 *
 * Provide a mechanism to create customized vector types in the IR, including vectors
 * whose lanes are not standard to OpenCL, and whose lanes are symbolic.
 *
 */

#include "../../Halide/src/IR.h"
#include "../../Halide/src/IREquality.h"

namespace Halide {
namespace Internal {

using std::string;
using std::vector;
using std::pair;

class GeneratedVectorType {
public:
    // Non-standard vector types: basic type is standard, but #lanes is not. For example: float9 is not
    // a standard OpenCL type, and here we can create it. For another example, lanes can be symbolic.
    static vector<pair<Type, Expr>> vectors; // Each entry: basic type, lanes.
                                             // For example, for float9: (float, 9)
                                             // The lanes Expr can be an integer, or a symbolic constant.

    // A dummy handle named "CGV" (compiler_generated_vector)
    static halide_handle_cplusplus_type dummy;

    // Test if the given basic type with lanes is already recorded as a nonstandard vector type. If so, return
    // true and the index of the nonstandard vector type in vectors.
    static bool nonstandard_vector_type_exists(const Type &basic_type, const Expr &lanes, size_t &index) {
        for (size_t i = 0; i < vectors.size(); i++) {
            auto v = vectors[i];
            if (v.first == basic_type && equal(v.second, lanes)) {
                index = i;
                return true;
            }
        }
        return false;
    }

    // Record the given basic type with lanes as a nonstandard vector type if it is not recorded yet.
    static void record_nonstandard_vector_type(const Type &basic_type, const Expr &lanes, size_t &index) {
        if (nonstandard_vector_type_exists(basic_type, lanes, index)) {
            return;
        }
        index = vectors.size();
        internal_assert(index <= 0xFF) << "Too many vector types generated.";
        string vector_name = unique_name("cgv");
        vectors.push_back(pair<Type, Expr>(basic_type, lanes));
    }
};

/* Generate a nonstandard vector type whose lanes is not standard or symbolic. Return this generated
 * vector type as a Halide type so that it can be used in the Halide IR. */
Type generate_vector(const Type &basic_type, const Expr & lanes);

}// Internal
} // Halide

#endif
