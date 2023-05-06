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
typedef union {
bool __attribute__ ((aligned(4))) s[4];
struct {bool s0,  s1,  s2,  s3;};
} bool4;
typedef struct { complexd s; } _cga;
channel complexd4 _xLoader_uX_channel __attribute__((depth(256))) ;
channel complexd4 _yLoader_uY_channel __attribute__((depth(256))) ;
channel complexd _Z_uZ_2_channel[64] __attribute__((depth(0))) ;
channel _cga _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_xLoader
#define __address_space__X_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int _X_extent_0,
 __address_space__X_serializer_mem_channel const complexd *restrict _X_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _X_extent_0 >> 8;
 for (int _xLoader_s0_k = 0; _xLoader_s0_k < 0 + _0; _xLoader_s0_k++)
 {
  for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 64; _xLoader_s0_kk++)
  {
   int _1 = _addr_temp;
   int _2 = _1 * 4;
   complexd4 _3 = {vload8(0, (__address_space__X_serializer_mem_channel double*)(_X_serializer_mem_channel + _2))};
   write_channel_intel(_xLoader_uX_channel, _3);
   (void)_3;
   int _4 = _1 + 1;
   _addr_temp = _4;
  } // for _xLoader_s0_kk
 } // for _xLoader_s0_k
} // kernel kernel_xLoader
#undef __address_space__X_serializer_mem_channel
// Address spaces for kernel_yLoader
#define __address_space__Y_serializer_mem_channel __global
__kernel void kernel_yLoader(
 const int _X_extent_0,
 __address_space__Y_serializer_mem_channel const complexd *restrict _Y_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _5 = _X_extent_0 >> 8;
 for (int _yLoader_s0_k = 0; _yLoader_s0_k < 0 + _5; _yLoader_s0_k++)
 {
  for (int _yLoader_s0_kk = 0; _yLoader_s0_kk < 0 + 64; _yLoader_s0_kk++)
  {
   int _6 = _addr_temp;
   int _7 = _6 * 4;
   complexd4 _8 = {vload8(0, (__address_space__Y_serializer_mem_channel double*)(_Y_serializer_mem_channel + _7))};
   write_channel_intel(_yLoader_uY_channel, _8);
   (void)_8;
   int _9 = _6 + 1;
   _addr_temp = _9;
  } // for _yLoader_s0_kk
 } // for _yLoader_s0_k
} // kernel kernel_yLoader
#undef __address_space__Y_serializer_mem_channel
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _X_extent_0)
{
 // produce uZ_2
 complexd _uZ_2_shreg[64];
 _cga _Out_unloader_channel_array;
 complexd _uZ_1_temp;
 complexd _Z_uZ_2_temp_shreg[64];
 complexd _uZ_1_shreg[64];
 complexd4 _uY_shreg;
 int _addr_temp;
 _addr_temp = 0;
 complexd4 _uX_shreg;
 complexd _uZ_1_shreg_temp;
 int _10 = _X_extent_0 >> 8;
 for (int _uX_s0_k = 0; _uX_s0_k < 0 + _10; _uX_s0_k++)
 {
  for (int _uX_s0_kk = 0; _uX_s0_kk < 0 + 64; _uX_s0_kk++)
  {
   complexd _12 = _uZ_1_shreg[63];
   _uZ_1_temp = _12;
   #pragma unroll
   for (int _dummy_s0_l1 = 0; _dummy_s0_l1 < 0 + 63; _dummy_s0_l1++)
   {
    int _13 = 63 - _dummy_s0_l1;
    int _14 = 62 - _dummy_s0_l1;
    complexd _16 = _uZ_1_shreg[_14];
    _uZ_1_shreg[_13] = _16;
    (void)_16;
   } // for _dummy_s0_l1
   complexd _17 = _uZ_1_temp;
   _uZ_1_shreg[0] = _17;
   (void)_17;
   complexd4 __18 = read_channel_intel(_xLoader_uX_channel);
   _uX_shreg = __18;
   (void)__18;
   complexd4 __19 = read_channel_intel(_yLoader_uY_channel);
   _uY_shreg = __19;
   (void)__19;
   complexd _20;
   bool _21 = _uX_s0_k == 0;
   if (_21)
   {
    complexd _22 = (complexd)(ADD_UINT64_T_SUFFIX(0));
    _20 = _22;
   } // if _21
   else
   {
    complexd _24 = _uZ_1_shreg[0];
    complexd _25 = __fpga_reg(_24);
    _20 = _25;
   } // if _21 else
   complexd _26 = _20;
   _uZ_1_shreg_temp = _26;
   #pragma unroll
   for (int _uX_s0_kkk = 0; _uX_s0_kkk < 0 + 4; _uX_s0_kkk++)
   {
    complexd _27 = _uZ_1_shreg_temp;
    complexd _29 = _uX_shreg.s[_uX_s0_kkk];
    complexd _31 = _uY_shreg.s[_uX_s0_kkk];
    complexd _32 = (complexd) {_29.s0 * _31.s0 - _29.s1 * _31.s1, _29.s0 * _31.s1 + _29.s1 * _31.s0};
    complexd _33 = _27 + _32;
    _uZ_1_shreg_temp = _33;
    bool _34 = _uX_s0_kkk == 3;
    if (_34)
    {
     complexd _35 = _uZ_1_shreg_temp;
     complexd _36 = __fpga_reg(_35);
     _uZ_1_shreg_temp = _36;
    } // if _34
   } // for _uX_s0_kkk
   complexd _37 = _uZ_1_shreg_temp;
   _uZ_1_shreg[0] = _37;
   (void)_37;
   #pragma unroll
   for (int _uX_s0_kkk = 0; _uX_s0_kkk < 0 + 4; _uX_s0_kkk++)
   {
    int _38 = _X_extent_0 >> 8;
    int _39 = _38 + -1;
    bool _40 = _uX_s0_k == _39;
    bool _41 = _uX_s0_kkk == 3;
    bool _42 = _40 && _41;
    if (_42)
    {
     int _43 = _addr_temp;
     complexd _45 = _uZ_1_shreg[0];
     _Z_uZ_2_temp_shreg[_43] = _45;
     (void)_45;
     int _46 = _43 + 1;
     _addr_temp = _46;
    } // if _42
   } // for _uX_s0_kkk
  } // for _uX_s0_kk
 } // for _uX_s0_k
 _addr_temp = 0;
 #pragma unroll
 for (int _uZ_2_s0_kk = 0; _uZ_2_s0_kk < 0 + 64; _uZ_2_s0_kk++)
 {
  int _47 = _addr_temp;
  complexd _49 = _Z_uZ_2_temp_shreg[_47];
  complexd _50;
  bool _51 = _uZ_2_s0_kk == 0;
  if (_51)
  {
   complexd _52 = (complexd)(ADD_UINT64_T_SUFFIX(0));
   _50 = _52;
  } // if _51
  else
  {
   int _53 = _uZ_2_s0_kk + -1;
   complexd _55 = _uZ_2_shreg[_53];
   _50 = _55;
  } // if _51 else
  complexd _56 = _50;
  complexd _57 = _49 + _56;
  _uZ_2_shreg[_uZ_2_s0_kk] = _57;
  (void)_57;
  bool _58 = _uZ_2_s0_kk == 63;
  if (_58)
  {
   complexd _60 = _uZ_2_shreg[63];
   _Out_unloader_channel_array.s = _60;
   (void)_60;
  } // if _58
  int _61 = _addr_temp;
  int _62 = _61 + 1;
  _addr_temp = _62;
 } // for _uZ_2_s0_kk
 write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
 (void)_Out_unloader_channel_array;
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 __address_space__unloader_mem_channel complexd *restrict _unloader_mem_channel)
{
 _cga _Out_unloader_channel_array;
 _cga __63 = read_channel_intel(_Out_unloader_channel);
 _Out_unloader_channel_array = __63;
 (void)__63;
 int _addr_temp;
 _addr_temp = 0;
 int _64 = _addr_temp;
 _unloader_mem_channel[_64] = _Out_unloader_channel_array.s;
 int _65 = _addr_temp;
 int _66 = _65 + 1;
 _addr_temp = _66;
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

