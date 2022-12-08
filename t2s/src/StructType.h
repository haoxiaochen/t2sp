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
#ifndef T2S_STRUCT_TYPE_H
#define T2S_STRUCT_TYPE_H

/** \file
 *
 * Provide a mechanism to create struct types in the IR.
 *
 */

#include "../../Halide/src/IR.h"
#include "../../Halide/src/IREquality.h"
#include "./VectorType.h"

namespace Halide {
namespace Internal {

using std::string;
using std::vector;
using std::pair;

class GeneratedStructType {
private:
    static bool struct_type_exists(const vector<Type> &field_types, size_t &index) {
        for (size_t i = 0; i < structs.size(); i++) {
            if (structs[i].second.size() != field_types.size()) {
                continue;
            }
            bool equal = true;
            for (size_t j = 0; j < field_types.size(); j++) {
                if (structs[i].second[j] != field_types[j]) {
                    equal = false;
                    break;
                }
            }
            if (equal) {
                index = i;
                return true;
            }
        }
        return false;
    }

public:
    // Structs, composed of multiple fields.
    static vector<pair<string, vector<Type>>> structs; // Each entry: struct name, field types
    static halide_handle_cplusplus_type dummy;         // A dummy handle named "CGS" (compiler_generated_struct)

    static void record_struct_type(const vector<Type> &field_types, size_t &index) {
        if (struct_type_exists(field_types, index)) {
            return;
        }
        index = structs.size();
        internal_assert(index <= 0xFF) << "Too many structs generated.";
        string struct_name = unique_name("cgs");
        structs.push_back(pair<string, vector<Type>>(struct_name, field_types));
    }
};

/* Given the types of the fields, generate a struct wrapped up as a Halide type so that it can be
 * used in the Halide IR. */
Type generate_struct(const vector<Type> &field_types);

}// Internal
} // Halide

#endif
