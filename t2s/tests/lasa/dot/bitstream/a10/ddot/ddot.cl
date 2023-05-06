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
bool __attribute__ ((aligned(8))) s[8];
struct {bool s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7;};
} bool8;
typedef struct { double s; } _cga;
channel double8 _xLoader_uX_channel __attribute__((depth(256))) ;
channel double8 _yLoader_uY_channel __attribute__((depth(256))) ;
channel double _Z_uZ_2_channel[64] __attribute__((depth(0))) ;
channel _cga _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_xLoader
#define __address_space__X_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int _X_extent_0,
 __address_space__X_serializer_mem_channel const double *restrict _X_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _X_extent_0 >> 9;
 for (int _xLoader_s0_k = 0; _xLoader_s0_k < 0 + _0; _xLoader_s0_k++)
 {
  for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 64; _xLoader_s0_kk++)
  {
   int _1 = _addr_temp;
   int _2 = _1 * 8;
   double8 _3 = vload8(0, (__address_space__X_serializer_mem_channel double*)_X_serializer_mem_channel + _2);
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
 __address_space__Y_serializer_mem_channel const double *restrict _Y_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _5 = _X_extent_0 >> 9;
 for (int _yLoader_s0_k = 0; _yLoader_s0_k < 0 + _5; _yLoader_s0_k++)
 {
  for (int _yLoader_s0_kk = 0; _yLoader_s0_kk < 0 + 64; _yLoader_s0_kk++)
  {
   int _6 = _addr_temp;
   int _7 = _6 * 8;
   double8 _8 = vload8(0, (__address_space__Y_serializer_mem_channel double*)_Y_serializer_mem_channel + _7);
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
 double _uZ_2_shreg[64];
 _cga _Out_unloader_channel_array;
 double _uZ_1_temp;
 double _Z_uZ_2_temp_shreg[64];
 double _uZ_1_shreg[64];
 double8 _uY_shreg;
 int _addr_temp;
 _addr_temp = 0;
 double8 _uX_shreg;
 double _uZ_1_shreg_temp;
 int _10 = _X_extent_0 >> 9;
 for (int _uX_s0_k = 0; _uX_s0_k < 0 + _10; _uX_s0_k++)
 {
  for (int _uX_s0_kk = 0; _uX_s0_kk < 0 + 64; _uX_s0_kk++)
  {
   double _12 = _uZ_1_shreg[63];
   _uZ_1_temp = _12;
   #pragma unroll
   for (int _dummy_s0_l1 = 0; _dummy_s0_l1 < 0 + 63; _dummy_s0_l1++)
   {
    int _13 = 63 - _dummy_s0_l1;
    int _14 = 62 - _dummy_s0_l1;
    double _16 = _uZ_1_shreg[_14];
    _uZ_1_shreg[_13] = _16;
    (void)_16;
   } // for _dummy_s0_l1
   double _17 = _uZ_1_temp;
   _uZ_1_shreg[0] = _17;
   (void)_17;
   double8 __18 = read_channel_intel(_xLoader_uX_channel);
   _uX_shreg = __18;
   (void)__18;
   double8 __19 = read_channel_intel(_yLoader_uY_channel);
   _uY_shreg = __19;
   (void)__19;
   double _20;
   bool _21 = _uX_s0_k == 0;
   if (_21)
   {
    double _22 = (double) float_from_bits(0 /* 0 */);
    _20 = _22;
   } // if _21
   else
   {
    double _24 = _uZ_1_shreg[0];
    double _25 = __fpga_reg(_24);
    _20 = _25;
   } // if _21 else
   double _26 = _20;
   _uZ_1_shreg_temp = _26;
   #pragma unroll
   for (int _uX_s0_kkk = 0; _uX_s0_kkk < 0 + 8; _uX_s0_kkk++)
   {
    double _27 = _uZ_1_shreg_temp;
    double _29 = _uX_shreg[_uX_s0_kkk];
    double _31 = _uY_shreg[_uX_s0_kkk];
    double _32 = _29 * _31;
    double _33 = _27 + _32;
    _uZ_1_shreg_temp = _33;
    int _34 = _uX_s0_kkk & 3;
    bool _35 = _34 == 3;
    if (_35)
    {
     double _36 = _uZ_1_shreg_temp;
     double _37 = __fpga_reg(_36);
     _uZ_1_shreg_temp = _37;
    } // if _35
   } // for _uX_s0_kkk
   double _38 = _uZ_1_shreg_temp;
   _uZ_1_shreg[0] = _38;
   (void)_38;
   #pragma unroll
   for (int _uX_s0_kkk = 0; _uX_s0_kkk < 0 + 8; _uX_s0_kkk++)
   {
    int _39 = _X_extent_0 >> 9;
    int _40 = _39 + -1;
    bool _41 = _uX_s0_k == _40;
    bool _42 = _uX_s0_kkk == 7;
    bool _43 = _41 && _42;
    if (_43)
    {
     int _44 = _addr_temp;
     double _46 = _uZ_1_shreg[0];
     _Z_uZ_2_temp_shreg[_44] = _46;
     (void)_46;
     int _47 = _44 + 1;
     _addr_temp = _47;
    } // if _43
   } // for _uX_s0_kkk
  } // for _uX_s0_kk
 } // for _uX_s0_k
 _addr_temp = 0;
 #pragma unroll
 for (int _uZ_2_s0_kk = 0; _uZ_2_s0_kk < 0 + 64; _uZ_2_s0_kk++)
 {
  int _48 = _addr_temp;
  double _50 = _Z_uZ_2_temp_shreg[_48];
  double _51;
  bool _52 = _uZ_2_s0_kk == 0;
  if (_52)
  {
   double _53 = (double) float_from_bits(0 /* 0 */);
   _51 = _53;
  } // if _52
  else
  {
   int _54 = _uZ_2_s0_kk + -1;
   double _56 = _uZ_2_shreg[_54];
   _51 = _56;
  } // if _52 else
  double _57 = _51;
  double _58 = _50 + _57;
  _uZ_2_shreg[_uZ_2_s0_kk] = _58;
  (void)_58;
  bool _59 = _uZ_2_s0_kk == 63;
  if (_59)
  {
   double _61 = _uZ_2_shreg[63];
   _Out_unloader_channel_array.s = _61;
   (void)_61;
  } // if _59
  int _62 = _addr_temp;
  int _63 = _62 + 1;
  _addr_temp = _63;
 } // for _uZ_2_s0_kk
 write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
 (void)_Out_unloader_channel_array;
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 __address_space__unloader_mem_channel double *restrict _unloader_mem_channel)
{
 _cga _Out_unloader_channel_array;
 _cga __64 = read_channel_intel(_Out_unloader_channel);
 _Out_unloader_channel_array = __64;
 (void)__64;
 int _addr_temp;
 _addr_temp = 0;
 int _65 = _addr_temp;
 _unloader_mem_channel[_65] = _Out_unloader_channel_array.s;
 int _66 = _addr_temp;
 int _67 = _66 + 1;
 _addr_temp = _67;
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

