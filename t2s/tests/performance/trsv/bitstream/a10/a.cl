/*OpenCL C x86-64-linux-avx-avx2-enable_synthesis-f16c-fma-intel_fpga-opencl-sse41*/
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
typedef struct { float s[32]; } _cga;
typedef struct { float s; } _cga__1;
channel _cga _aLoader_uA_channel __attribute__((depth(256))) ;
channel _cga__1 _bLoader_uX_channel __attribute__((depth(256))) ;
channel _cga__1 _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#if 536870912 <= MAX_CONSTANT_BUFFER_SIZE && 0 < MAX_CONSTANT_ARGS
#define __address_space__A_serializer_c0_mem_channel __constant
#else
#define __address_space__A_serializer_c0_mem_channel __global
#endif
#if 1073741824 <= MAX_CONSTANT_BUFFER_SIZE && 1 < MAX_CONSTANT_ARGS
#define __address_space__A_serializer_c1_mem_channel __constant
#else
#define __address_space__A_serializer_c1_mem_channel __global
#endif
__kernel void kernel_aLoader(
 __address_space__A_serializer_c0_mem_channel const float *restrict _A_serializer_c0_mem_channel,
 __address_space__A_serializer_c1_mem_channel const float *restrict _A_serializer_c1_mem_channel)
{
 _cga _aLoader_uA_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 for (int _aLoader_s0_k_i = 0; _aLoader_s0_k_i < 0 + 8388608; _aLoader_s0_k_i++)
 {
  float _aLoader_temp[32];
  #pragma unroll
  for (int _aLoader_s0_ii_t = 0; _aLoader_s0_ii_t < 0 + 16; _aLoader_s0_ii_t++)
  {
   int _0 = _addr_temp;
   float _1 = _A_serializer_c0_mem_channel[_0];
   _aLoader_temp[_aLoader_s0_ii_t] = _1;
   int _2 = _addr_temp;
   float _3 = _A_serializer_c1_mem_channel[_2];
   int _4 = _aLoader_s0_ii_t + 16;
   _aLoader_temp[_4] = _3;
   int _5 = _addr_temp;
   int _6 = _5 + 1;
   _addr_temp = _6;
  } // for _aLoader_s0_ii_t
  #pragma unroll
  for (int _aLoader_s0_ii = 0; _aLoader_s0_ii < 0 + 32; _aLoader_s0_ii++)
  {
   float _7 = _aLoader_temp[_aLoader_s0_ii];
   _aLoader_uA_channel_array.s[_aLoader_s0_ii] = _7;
   (void)_aLoader_s0_ii;
  } // for _aLoader_s0_ii
  write_channel_intel(_aLoader_uA_channel, _aLoader_uA_channel_array);
  (void)_aLoader_uA_channel_array;
 } // for _aLoader_s0_k_i
} // kernel kernel_aLoader
#undef __address_space__A_serializer_c0_mem_channel
#undef __address_space__A_serializer_c1_mem_channel
// Address spaces for kernel_bLoader
#if 65536 <= MAX_CONSTANT_BUFFER_SIZE && 0 < MAX_CONSTANT_ARGS
#define __address_space__b_serializer_mem_channel __constant
#else
#define __address_space__b_serializer_mem_channel __global
#endif
__kernel void kernel_bLoader(
 __address_space__b_serializer_mem_channel const float *restrict _b_serializer_mem_channel)
{
 _cga__1 _bLoader_uX_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 for (int _bLoader_s0_k = 0; _bLoader_s0_k < 0 + 16384; _bLoader_s0_k++)
 {
  for (int _bLoader_s0_i = 0; _bLoader_s0_i < 0 + 512; _bLoader_s0_i++)
  {
   #pragma unroll
   for (int _bLoader_s0_ii = 0; _bLoader_s0_ii < 0 + 32; _bLoader_s0_ii++)
   {
    bool _8 = _bLoader_s0_i == 0;
    bool _9 = _bLoader_s0_ii == 0;
    bool _10 = _8 && _9;
    if (_10)
    {
     int _11 = _addr_temp;
     float _12 = _b_serializer_mem_channel[_bLoader_s0_k];
     _bLoader_uX_channel_array.s = _12;
     (void)_12;
    } // if _10
    bool _13 = _bLoader_s0_ii == 0;
    if (_13)
    {
     int _14 = _addr_temp;
     int _15 = _14 + 1;
     _addr_temp = _15;
    } // if _13
   } // for _bLoader_s0_ii
  } // for _bLoader_s0_i
  write_channel_intel(_bLoader_uX_channel, _bLoader_uX_channel_array);
  (void)_bLoader_uX_channel_array;
 } // for _bLoader_s0_k
} // kernel kernel_bLoader
#undef __address_space__b_serializer_mem_channel
// Address spaces for kernel_Out
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_Out(
)
{
 // produce uY
 float _uY_shreg[513][32];
 // produce uX
 float _uX_shreg[32];
 // produce uA
 float _uA_shreg[32];
 _cga__1 _Out_unloader_channel_array;
 _cga__1 _bLoader_uX_channel_array;
 _cga _aLoader_uA_channel_array;
 int _k_temp;
 _k_temp = 0;
 while(1)
 {
  _cga__1 __16 = read_channel_intel(_bLoader_uX_channel);
  _bLoader_uX_channel_array = __16;
  (void)__16;
  for (int _uA_s0_i = 0; _uA_s0_i < 0 + 512; _uA_s0_i++)
  {
   #pragma unroll
   for (int _dummy_s0_ii = 0; _dummy_s0_ii < 0 + 32; _dummy_s0_ii++)
   {
    #pragma unroll
    for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 512; _dummy__1_s0_l0++)
    {
     int _17 = 512 - _dummy__1_s0_l0;
     int _18 = 511 - _dummy__1_s0_l0;
     float _20 = _uY_shreg[_18][_dummy_s0_ii];
     _uY_shreg[_17][_dummy_s0_ii] = _20;
     (void)_20;
    } // for _dummy__1_s0_l0
   } // for _dummy_s0_ii
   _cga __21 = read_channel_intel(_aLoader_uA_channel);
   _aLoader_uA_channel_array = __21;
   (void)__21;
   #pragma unroll
   for (int _uA_s0_ii = 0; _uA_s0_ii < 0 + 32; _uA_s0_ii++)
   {
    float __22 = _aLoader_uA_channel_array.s[_uA_s0_ii];
    _uA_shreg[_uA_s0_ii] = __22;
    (void)__22;
    float _23;
    bool _24 = _uA_s0_i == 0;
    if (_24)
    {
     float _25;
     bool _26 = _uA_s0_ii == 0;
     if (_26)
     {
      float _27;
      int _28 = _k_temp;
      bool _29 = _28 == 0;
      if (_29)
      {
       float _30 = float_from_bits(0 /* 0 */);
       _27 = _30;
      } // if _29
      else
      {
       int _31 = _uA_s0_ii + 1;
       float _33 = _uY_shreg[512][_31];
       _27 = _33;
      } // if _29 else
      float _34 = _27;
      float _35 = _bLoader_uX_channel_array.s - _34;
      float _37 = _uA_shreg[_uA_s0_ii];
      float _38 = _35 / _37;
      _25 = _38;
     } // if _26
     else
     {
      int _39 = _uA_s0_ii + -1;
      float _41 = _uX_shreg[_39];
      _25 = _41;
     } // if _26 else
     float _42 = _25;
     _23 = _42;
    } // if _24
    else
    {
     float _44 = _uX_shreg[_uA_s0_ii];
     _23 = _44;
    } // if _24 else
    float _45 = _23;
    _uX_shreg[_uA_s0_ii] = _45;
    (void)_45;
    float _46;
    int _47 = _k_temp;
    bool _48 = _47 == 0;
    if (_48)
    {
     float _49 = float_from_bits(0 /* 0 */);
     _46 = _49;
    } // if _48
    else
    {
     float _50;
     bool _51 = _uA_s0_ii == 31;
     if (_51)
     {
      float _52;
      bool _53 = _uA_s0_i == 511;
      if (_53)
      {
       float _54 = float_from_bits(0 /* 0 */);
       _52 = _54;
      } // if _53
      else
      {
       int _55 = _uA_s0_ii + -31;
       float _57 = _uY_shreg[511][_55];
       _52 = _57;
      } // if _53 else
      float _58 = _52;
      _50 = _58;
     } // if _51
     else
     {
      int _59 = _uA_s0_ii + 1;
      float _61 = _uY_shreg[512][_59];
      _50 = _61;
     } // if _51 else
     float _62 = _50;
     _46 = _62;
    } // if _48 else
    float _63 = _46;
    float _65 = _uA_shreg[_uA_s0_ii];
    float _67 = _uX_shreg[_uA_s0_ii];
    float _68 = _65 * _67;
    float _69 = _63 + _68;
    _uY_shreg[0][_uA_s0_ii] = _69;
    (void)_69;
    bool _70 = _uA_s0_ii == 31;
    bool _71 = _uA_s0_i == 511;
    bool _72 = _70 && _71;
    if (_72)
    {
     float _74 = _uX_shreg[31];
     _Out_unloader_channel_array.s = _74;
     (void)_74;
    } // if _72
   } // for _uA_s0_ii
  } // for _uA_s0_i
  write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
  (void)_Out_unloader_channel_array;
  int _75 = _k_temp;
  int _76 = _75 + 1;
  _k_temp = _76;
 } // while _uA_s0_k_infinite
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 _cga__1 _Out_unloader_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 for (int _unloader_s0_k = 0; _unloader_s0_k < 0 + 16384; _unloader_s0_k++)
 {
  _cga__1 __77 = read_channel_intel(_Out_unloader_channel);
  _Out_unloader_channel_array = __77;
  (void)__77;
  int _78 = _addr_temp;
  _unloader_mem_channel[_78] = _Out_unloader_channel_array.s;
  int _79 = _addr_temp;
  int _80 = _79 + 1;
  _addr_temp = _80;
 } // for _unloader_s0_k
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

