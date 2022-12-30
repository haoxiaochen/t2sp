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
#ifndef T2S_STRENGTH_REDUCTION_H
#define T2S_STRENGTH_REDUCTION_H

/** \file
 * Reduce strength of some commonly seen arithmetic operations
 */

#include "../../Halide/src/IR.h"

using std::map;
using std::pair;
using std::set;
using std::string;
using std::vector;

namespace Halide {
namespace Internal {

/** Reduce strength of some commonly seen arithmetic operations, e.g. x/4 ==> x>>2. */
Stmt strength_reduction(Stmt s, const Target &t, const std::map<std::string, Function> &env);

}
}

#endif
