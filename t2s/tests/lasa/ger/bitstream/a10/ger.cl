/*OpenCL C x86-64-linux-avx-avx2-avx512-avx512_skylake-enable_synthesis-f16c-fma-intel_fpga-opencl-sse41*/
#pragma OPENCL FP_CONTRACT ON
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#define float_from_bits(x) as_float(x)
inline float nan_f32() { return NAN; }
inline float neg_inf_f32() { return -INFINITY; }
inline float inf_f32() { return INFINITY; }
inline bool is_nan_f32(float x) {return isnan(x); }
inline bool is_inf_f32(float x) {return isinf(x); }
inline bool is_finite_f32(float x) {return isfinite(x); }
#define sqrt_f32 sqrt 
#define sin_f32 sin 
#define cos_f32 cos 
#define exp_f32 exp 
#define log_f32 log 
#define abs_f32 fabs 
#define floor_f32 floor 
#define ceil_f32 ceil 
#define round_f32 round 
#define trunc_f32 trunc 
#define pow_f32 pow
#define asin_f32 asin 
#define acos_f32 acos 
#define tan_f32 tan 
#define atan_f32 atan 
#define atan2_f32 atan2
#define sinh_f32 sinh 
#define asinh_f32 asinh 
#define cosh_f32 cosh 
#define acosh_f32 acosh 
#define tanh_f32 tanh 
#define atanh_f32 atanh 
#define fast_inverse_f32 native_recip 
#define fast_inverse_sqrt_f32 native_rsqrt 
typedef float2 complex;
typedef union { float4 t; float2 s[2]; } complex2;
typedef union { float8 t; float2 s[4]; } complex4;
typedef union { float16 t; float2 s[8]; } complex8;
inline float2 conjugate_c32(float2 x) {return (float2)(x.s0, -x.s1); }
inline float2 sqrt_c32(float2 x) {return (float2)(sqrt_f32(x.s0), 0.0f); }
inline float2 fast_inverse_c32(float2 x) {return (float2)(fast_inverse_f32(x.s0), 0.0f); }
inline float2 fast_inverse_sqrt_c32(float2 x) {return (float2)(fast_inverse_sqrt_f32(x.s0), 0.0f); }
typedef double2 complexd;
typedef union { double4 t; double2 s[2]; } complexd2;
typedef union { double8 t; double2 s[4]; } complexd4;
typedef union { double16 t; double2 s[8]; } complexd8;
inline double2 conjugate_c64(double2 x) {return (double2)(x.s0, -x.s1); }
#define __address_space___shared __local


// ll suffix in OpenCL is reserved for 128-bit integers.
#if defined __OPENCL_VERSION__
#define ADD_INT64_T_SUFFIX(x) x##l
#define ADD_UINT64_T_SUFFIX(x) x##ul
// HLSL doesn't have any suffixes.
#elif defined HLSL_VERSION
#define ADD_INT64_T_SUFFIX(x) x
#define ADD_UINT64_T_SUFFIX(x) x
#else
#define ADD_INT64_T_SUFFIX(x) x##ll
#define ADD_UINT64_T_SUFFIX(x) x##ull
#endif
#pragma OPENCL EXTENSION cl_intel_channels : enable
typedef struct { float s; } _cga;
typedef struct { float s[16]; } _cga__1;
channel _cga _xLoader_uX_channel __attribute__((depth(256))) ;
channel _cga__1 _yLoader_uY_channel __attribute__((depth(256))) ;
channel _cga__1 _aLoader_uZ_channel __attribute__((depth(256))) ;
channel _cga__1 _uZ_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_xLoader
#define __address_space__X_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__X_serializer_mem_channel const float *restrict _X_serializer_mem_channel)
{
 _cga _xLoader_uX_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_1 >> 4;
 for (int _xLoader_s0_i = 0; _xLoader_s0_i < 0 + _0; _xLoader_s0_i++)
 {
  int _1 = _A_extent_0 >> 4;
  for (int _xLoader_s0_j = 0; _xLoader_s0_j < 0 + _1; _xLoader_s0_j++)
  {
   for (int _xLoader_s0_ii = 0; _xLoader_s0_ii < 0 + 16; _xLoader_s0_ii++)
   {
    #pragma unroll
    for (int _xLoader_s0_jj = 0; _xLoader_s0_jj < 0 + 16; _xLoader_s0_jj++)
    {
     bool _2 = _xLoader_s0_jj == 0;
     if (_2)
     {
      int _3 = _addr_temp;
      int _4 = _A_extent_0 >> 4;
      int _5 = _4 * 16;
      int _6 = _3 / _5;
      int _7 = _6 * 16;
      int _8 = _3 & 15;
      int _9 = _7 + _8;
      float _10 = _X_serializer_mem_channel[_9];
      _xLoader_uX_channel_array.s = _10;
      (void)_10;
      int _11 = _3 + 1;
      _addr_temp = _11;
     } // if _2
    } // for _xLoader_s0_jj
    write_channel_intel(_xLoader_uX_channel, _xLoader_uX_channel_array);
    (void)_xLoader_uX_channel_array;
   } // for _xLoader_s0_ii
  } // for _xLoader_s0_j
 } // for _xLoader_s0_i
} // kernel kernel_xLoader
#undef __address_space__X_serializer_mem_channel
// Address spaces for kernel_yLoader
#define __address_space__Y_serializer_mem_channel __global
__kernel void kernel_yLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__Y_serializer_mem_channel const float *restrict _Y_serializer_mem_channel)
{
 _cga__1 _yLoader_uY_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _12 = _A_extent_1 >> 4;
 for (int _yLoader_s0_i = 0; _yLoader_s0_i < 0 + _12; _yLoader_s0_i++)
 {
  int _13 = _A_extent_0 >> 4;
  for (int _yLoader_s0_j = 0; _yLoader_s0_j < 0 + _13; _yLoader_s0_j++)
  {
   for (int _yLoader_s0_ii = 0; _yLoader_s0_ii < 0 + 16; _yLoader_s0_ii++)
   {
    #pragma unroll
    for (int _yLoader_s0_jj = 0; _yLoader_s0_jj < 0 + 16; _yLoader_s0_jj++)
    {
     int _14 = _addr_temp;
     int _15 = _14 >> 8;
     int _16 = _15 * 16;
     int _17 = _14 & 15;
     int _18 = _16 + _17;
     int _19 = _A_extent_0 >> 4;
     int _20 = _19 * 16;
     int _21 = _18 % _20;
     float _22 = _Y_serializer_mem_channel[_21];
     _yLoader_uY_channel_array.s[_yLoader_s0_jj] = _22;
     (void)_yLoader_s0_jj;
     int _23 = _14 + 1;
     _addr_temp = _23;
    } // for _yLoader_s0_jj
    write_channel_intel(_yLoader_uY_channel, _yLoader_uY_channel_array);
    (void)_yLoader_uY_channel_array;
   } // for _yLoader_s0_ii
  } // for _yLoader_s0_j
 } // for _yLoader_s0_i
} // kernel kernel_yLoader
#undef __address_space__Y_serializer_mem_channel
// Address spaces for kernel_aLoader
#define __address_space__A_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_serializer_mem_channel const float *restrict _A_serializer_mem_channel)
{
 _cga__1 _aLoader_uZ_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _24 = _A_extent_1 >> 4;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _24; _aLoader_s0_i++)
 {
  int _25 = _A_extent_0 >> 4;
  for (int _aLoader_s0_j = 0; _aLoader_s0_j < 0 + _25; _aLoader_s0_j++)
  {
   for (int _aLoader_s0_ii = 0; _aLoader_s0_ii < 0 + 16; _aLoader_s0_ii++)
   {
    #pragma unroll
    for (int _aLoader_s0_jj = 0; _aLoader_s0_jj < 0 + 16; _aLoader_s0_jj++)
    {
     int _26 = _addr_temp;
     float _27 = _A_serializer_mem_channel[_26];
     _aLoader_uZ_channel_array.s[_aLoader_s0_jj] = _27;
     (void)_aLoader_s0_jj;
     int _28 = _26 + 1;
     _addr_temp = _28;
    } // for _aLoader_s0_jj
    write_channel_intel(_aLoader_uZ_channel, _aLoader_uZ_channel_array);
    (void)_aLoader_uZ_channel_array;
   } // for _aLoader_s0_ii
  } // for _aLoader_s0_j
 } // for _aLoader_s0_i
} // kernel kernel_aLoader
#undef __address_space__A_serializer_mem_channel
// Address spaces for kernel_uZ
__kernel void kernel_uZ(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce uY
 float _uY_shreg[16];
 // produce uX
 float _uX_shreg;
 _cga__1 _aLoader_uZ_channel_array;
 _cga__1 _uZ_unloader_channel_array;
 _cga__1 _yLoader_uY_channel_array;
 _cga _xLoader_uX_channel_array;
 int _29 = _A_extent_1 >> 4;
 for (int _uX_s0_i = 0; _uX_s0_i < 0 + _29; _uX_s0_i++)
 {
  int _30 = _A_extent_0 >> 4;
  for (int _uX_s0_j = 0; _uX_s0_j < 0 + _30; _uX_s0_j++)
  {
   for (int _uX_s0_ii = 0; _uX_s0_ii < 0 + 16; _uX_s0_ii++)
   {
    _cga__1 __31 = read_channel_intel(_aLoader_uZ_channel);
    _aLoader_uZ_channel_array = __31;
    (void)__31;
    _cga__1 __32 = read_channel_intel(_yLoader_uY_channel);
    _yLoader_uY_channel_array = __32;
    (void)__32;
    _cga __33 = read_channel_intel(_xLoader_uX_channel);
    _xLoader_uX_channel_array = __33;
    (void)__33;
    #pragma unroll
    for (int _uX_s0_jj = 0; _uX_s0_jj < 0 + 16; _uX_s0_jj++)
    {
     float _34;
     bool _35 = _uX_s0_jj == 0;
     if (_35)
     {
      _34 = _xLoader_uX_channel_array.s;
     } // if _35
     else
     {
      float _37 = _uX_shreg;
      _34 = _37;
     } // if _35 else
     float _38 = _34;
     _uX_shreg = _38;
     (void)_38;
     float _40 = _uX_shreg;
     float _41 = __fpga_reg(__fpga_reg(_40));
     _uX_shreg = _41;
     (void)_41;
     float __42 = _yLoader_uY_channel_array.s[_uX_s0_jj];
     _uY_shreg[_uX_s0_jj] = __42;
     (void)__42;
     float __43 = _aLoader_uZ_channel_array.s[_uX_s0_jj];
     float _45 = _uX_shreg;
     float _47 = _uY_shreg[_uX_s0_jj];
     float _48 = _45 * _47;
     float _49 = __43 + _48;
     _uZ_unloader_channel_array.s[_uX_s0_jj] = _49;
     (void)_uX_s0_jj;
    } // for _uX_s0_jj
    write_channel_intel(_uZ_unloader_channel, _uZ_unloader_channel_array);
    (void)_uZ_unloader_channel_array;
   } // for _uX_s0_ii
  } // for _uX_s0_j
 } // for _uX_s0_i
} // kernel kernel_uZ
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 _cga__1 _uZ_unloader_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _50 = _A_extent_1 >> 4;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _50; _unloader_s0_i++)
 {
  int _51 = _A_extent_0 >> 4;
  for (int _unloader_s0_j = 0; _unloader_s0_j < 0 + _51; _unloader_s0_j++)
  {
   for (int _unloader_s0_ii = 0; _unloader_s0_ii < 0 + 16; _unloader_s0_ii++)
   {
    _cga__1 __52 = read_channel_intel(_uZ_unloader_channel);
    _uZ_unloader_channel_array = __52;
    (void)__52;
    for (int _unloader_s0_jj = 0; _unloader_s0_jj < 0 + 16; _unloader_s0_jj++)
    {
     float __53 = _uZ_unloader_channel_array.s[_unloader_s0_jj];
     int _54 = _addr_temp;
     _unloader_mem_channel[_54] = __53;
     int _55 = _addr_temp;
     int _56 = _55 + 1;
     _addr_temp = _56;
    } // for _unloader_s0_jj
   } // for _unloader_s0_ii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

