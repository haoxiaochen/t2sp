#include "Complex32.h"
#include "Error.h"
#include "IRMutator.h"
#include "Util.h"

#include <cmath>
#include <limits>

namespace Halide {
namespace Internal {

uint64_t float_to_complex32(float re, float im) {
    float f32array[2] = {re, im};
    uint64_t *p64 = (uint64_t *)&f32array[0];
    uint64_t bits = *p64;
    return bits;
}

float re_part(uint64_t data) {
    float f32array[2];
    uint64_t *p64 = (uint64_t *)&f32array[0];
    *p64 = data;
    return f32array[0];
}

float im_part(uint64_t data) {
    float f32array[2];
    uint64_t *p64 = (uint64_t *)&f32array[0];
    *p64 = data;
    return f32array[1];
}

}  // namespace Internal

using namespace Halide::Internal;

complex32_t::complex32_t(float re, float im)
    : data(float_to_complex32(re, im)) {
}

// complex32_t::complex32_t(double re, double im)
//     : data(float_to_complex32(re, im)) {
// }

// complex32_t::complex32_t(int re, int im)
//     : data(float_to_complex32(re, im)) {
// }

complex32_t complex32_t::conj() {
    return complex32_t(re_part(data), -im_part(data));
}

complex32_t complex32_t::operator-() const {
    return complex32_t(-re_part(data), -im_part(data));
}

complex32_t complex32_t::operator+(complex32_t rhs) const {
    return complex32_t(re_part(data) + re_part(rhs.data), im_part(data) + im_part(rhs.data));
}

complex32_t complex32_t::operator-(complex32_t rhs) const {
    return complex32_t(re_part(data) - re_part(rhs.data), im_part(data) - im_part(rhs.data));
}

complex32_t complex32_t::operator*(complex32_t rhs) const {
    return complex32_t(re_part(data) * re_part(rhs.data) - im_part(data) * im_part(rhs.data),
                       re_part(data) * im_part(rhs.data) + im_part(data) * re_part(rhs.data));
}

complex32_t complex32_t::operator/(complex32_t rhs) const {
    float abs_square = re_part(rhs.data) * re_part(rhs.data) + im_part(rhs.data) * im_part(rhs.data);
    return complex32_t((re_part(data) * re_part(rhs.data) + im_part(data) * im_part(rhs.data)) / abs_square,
                       (im_part(data) * re_part(rhs.data) - re_part(data) * im_part(rhs.data)) / abs_square);
}

uint64_t complex32_t::to_bits() const {
    return data;
}


float complex32_t::re() const {
    return re_part(data);
}

float complex32_t::im() const {
    return im_part(data);
}

bool complex32_t::operator==(complex32_t rhs) const {
    return re_part(data) == re_part(rhs.data) && im_part(data) == im_part(rhs.data);
}

}  // namespace Halide
