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
#include "../../Halide/src/CodeGen_Internal.h"
#include "../../Halide/src/IR.h"
#include "../../Halide/src/IRMutator.h"
#include "DebugPrint.h"

namespace Halide {
namespace Internal {

class StrengthReduction : public IRMutator {
    bool in_function;
    bool on_device;

    using IRMutator::visit;

public:
    StrengthReduction() : in_function(false), on_device(false) { }

public:
    Stmt visit(const ProducerConsumer* op) override {
        if (op->is_producer) {
            in_function = true;
        } else {
            in_function = false;
        }
        return IRMutator::visit(op);
    }

    Stmt visit(const For *op) override {
        if (!in_function) {
            return IRMutator::visit(op);
        }

        bool prev_on_device = on_device;
        if (ends_with(op->name, ".run_on_device")) {
            on_device = true;
        }
        Stmt s = IRMutator::visit(op);
        if (ends_with(op->name, ".run_on_device")) {
            on_device = prev_on_device;
        }
        return s;
    }

    Expr visit(const Div *op) override {
        if (on_device) {
            int bits;
            char* ediv = getenv("EUCLIDEAN_DIVISION");
            if (is_const_power_of_two_integer(op->b, &bits)) {
                return Call::make(op->type, Internal::Call::shift_right, {op->a,  make_const(op->a.type(), bits)}, Internal::Call::PureIntrinsic);
            } else if (ediv && op->type.is_int()) {
                return lower_euclidean_div(op->a, op->b);
            }
        }
        return IRMutator::visit(op);
    }

    Expr visit(const Mod *op) override {
        if (on_device) {
            int bits;
            char* ediv = getenv("EUCLIDEAN_DIVISION");
            if (is_const_power_of_two_integer(op->b, &bits)) {
                return Call::make(op->type, Internal::Call::bitwise_and, {op->a,  make_const(op->a.type(), (1 << bits) - 1)}, Internal::Call::PureIntrinsic);
            } else if (ediv && op->type.is_int()) {
                return lower_euclidean_mod(op->a, op->b);
            } else if (op->type.is_float()) {
                return Call::make(op->type, Call::fmod, {op->a, op->b}, Call::CallType::PureIntrinsic);
            }
        }
        return IRMutator::visit(op);
    }
};

Stmt strength_reduction(Stmt s, const Target &t, const std::map<std::string, Function> &env) {
    StrengthReduction sr;
    s = sr.mutate(s);
    return s;
}

} // namespace Internal
} // namespace Halide
