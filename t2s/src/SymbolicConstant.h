#ifndef HALIDE_SYMBOLIC_CONSTANT_H
#define HALIDE_SYMBOLIC_CONSTANT_H

#include "../../Halide/src/Param.h"

/** \file
 *
 * Class for declaring symbolic constant parameters
 */

namespace Halide {

/** A symbolic constant parameter. */
template<typename T = void>
class SymbolicConstant : public Param<T> {
public:
    /** Construct a symbolic constant parameter of type T with the given name. */
    // @{
    explicit SymbolicConstant(const std::string &n)
        : Param<T>(n, true /*is symbolic constant*/) {
    }
    /** Construct a symbolic constant parameter of type T with the given name and a minimum value. */
    // @{
    explicit SymbolicConstant(const std::string &n, Expr min)
        : Param<T>(n, true /*is symbolic constant*/) {
        Param<T>::set_min_value(min);
    }
    /** Construct a symbolic constant parameter of type T with the given name and min/max value. */
    // @{
    explicit SymbolicConstant(const std::string &n, Expr min, Expr max)
        : Param<T>(n, true /*is symbolic constant*/) {
        Param<T>::set_min_value(min);
        Param<T>::set_max_value(max);
    }
};

namespace Internal {

/** Can the expression be resolved as a constant eventually? Return true
 *  when all variables it contains are (immediate) constants or symbolic constants. */
bool can_resolve_as_const(const Expr &e);
}  // namespace Internal

}  // namespace Halide

#endif
