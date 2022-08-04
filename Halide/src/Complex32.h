#ifndef HALIDE_COMPLEX32_H
#define HALIDE_COMPLEX32_H
#include "Util.h"
#include "runtime/HalideRuntime.h"
#include <stdint.h>
#include <string>

namespace Halide {

struct complex32_t {

    /// \name Constructors
    /// @{

    /** Construct from a float, double, or int using
     * round-to-nearest-ties-to-even. Out-of-range values become +/-
     * infinity.
     */
    // @{
    explicit complex32_t(float re, float im);
    // explicit complex32_t(double re, double im);
    // explicit complex32_t(int re, int im);
    // @}

    /** Construct a complex32_t with the bits initialised to 0. This represents
     * positive zero.*/
    complex32_t() = default;

    /// @}

    /** Cast to double */
    // explicit operator double() const;

    complex32_t conj();
    /** Return a new complex32_t with a negated sign bit*/
    complex32_t operator-() const;

    /** Arithmetic operators. */
    // @{
    complex32_t operator+(complex32_t rhs) const;
    complex32_t operator-(complex32_t rhs) const;
    complex32_t operator*(complex32_t rhs) const;
    complex32_t operator/(complex32_t rhs) const;
    complex32_t operator+=(complex32_t rhs) {
        return (*this = *this + rhs);
    }
    complex32_t operator-=(complex32_t rhs) {
        return (*this = *this - rhs);
    }
    complex32_t operator*=(complex32_t rhs) {
        return (*this = *this * rhs);
    }
    complex32_t operator/=(complex32_t rhs) {
        return (*this = *this / rhs);
    }
    // @}

    float re() const;
    float im() const;

    /** Comparison operators */
    // @{
    bool operator==(complex32_t rhs) const;
    bool operator!=(complex32_t rhs) const {
        return !(*this == rhs);
    }
    // @}

    /** Returns the bits that represent this complex32.
     *
     *  An alternative method to access the bits is to cast a pointer
     *  to this instance as a pointer to a uint64_t.
     **/
    uint64_t to_bits() const;

private:
    // The raw bits.
    uint64_t data = 0;
};

static_assert(sizeof(complex32_t) == 8, "complex32_t should occupy eight bytes");

}  // namespace Halide

template<>
HALIDE_ALWAYS_INLINE halide_type_t halide_type_of<Halide::complex32_t>() {
    return halide_type_t(halide_type_complex, 64, 1);
}

#endif
