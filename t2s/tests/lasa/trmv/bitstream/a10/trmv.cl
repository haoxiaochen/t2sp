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
typedef struct { float s[32]; } _cga;
typedef struct { float s; } _cga__1;
channel _cga _aLoader_uA_channel __attribute__((depth(256))) ;
channel float _xLoader_xFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _xFeeder_uX_channel __attribute__((depth(256))) ;
channel _cga _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_serializer_c0_mem_channel __global
#define __address_space__A_serializer_c1_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_serializer_c0_mem_channel const float *restrict _A_serializer_c0_mem_channel,
 __address_space__A_serializer_c1_mem_channel const float *restrict _A_serializer_c1_mem_channel)
{
 _cga _aLoader_uA_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_1 >> 8;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _0; _aLoader_s0_i++)
 {
  int _1 = _A_extent_0 >> 8;
  int _2 = _1 - _aLoader_s0_i;
  for (int _aLoader_s0_k = _aLoader_s0_i; _aLoader_s0_k < _aLoader_s0_i + _2; _aLoader_s0_k++)
  {
   for (int _aLoader_s0_kk_ii = 0; _aLoader_s0_kk_ii < 0 + 2048; _aLoader_s0_kk_ii++)
   {
    float _aLoader_temp[32];
    #pragma unroll
    for (int _aLoader_s0_iii_t = 0; _aLoader_s0_iii_t < 0 + 16; _aLoader_s0_iii_t++)
    {
     int _3 = _addr_temp;
     float _4 = _A_serializer_c0_mem_channel[_3];
     _aLoader_temp[_aLoader_s0_iii_t] = _4;
     int _5 = _addr_temp;
     float _6 = _A_serializer_c1_mem_channel[_5];
     int _7 = _aLoader_s0_iii_t + 16;
     _aLoader_temp[_7] = _6;
     int _8 = _addr_temp;
     int _9 = _8 + 1;
     _addr_temp = _9;
    } // for _aLoader_s0_iii_t
    #pragma unroll
    for (int _aLoader_s0_iii = 0; _aLoader_s0_iii < 0 + 32; _aLoader_s0_iii++)
    {
     float _10 = _aLoader_temp[_aLoader_s0_iii];
     _aLoader_uA_channel_array.s[_aLoader_s0_iii] = _10;
     (void)_aLoader_s0_iii;
    } // for _aLoader_s0_iii
    write_channel_intel(_aLoader_uA_channel, _aLoader_uA_channel_array);
    (void)_aLoader_uA_channel_array;
   } // for _aLoader_s0_kk_ii
  } // for _aLoader_s0_k
 } // for _aLoader_s0_i
} // kernel kernel_aLoader
#undef __address_space__A_serializer_c0_mem_channel
#undef __address_space__A_serializer_c1_mem_channel
// Address spaces for kernel_xLoader
#define __address_space__X_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__X_serializer_mem_channel const float *restrict _X_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _11 = _A_extent_1 >> 8;
 int _12 = _11 + 1;
 for (int _xLoader_s0_i = 0; _xLoader_s0_i < 0 + _12; _xLoader_s0_i++)
 {
  int _13 = _A_extent_1 >> 8;
  int _14 = _xLoader_s0_i / _13;
  int _15 = _A_extent_0 >> 8;
  int _16 = _15 - _xLoader_s0_i;
  int _17 = _14 + _16;
  for (int _xLoader_s0_k = _xLoader_s0_i; _xLoader_s0_k < _xLoader_s0_i + _17; _xLoader_s0_k++)
  {
   for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 256; _xLoader_s0_kk++)
   {
    int _18 = _A_extent_1 >> 8;
    bool _19 = _xLoader_s0_i < _18;
    bool _20 = _xLoader_s0_k == _xLoader_s0_i;
    bool _21 = _19 || _20;
    if (_21)
    {
     float _22;
     int _23 = _A_extent_1 >> 8;
     bool _24 = _xLoader_s0_i < _23;
     if (_24)
     {
      int _25 = _xLoader_s0_k * 256;
      int _26 = _addr_temp;
      int _27 = _26 & 255;
      int _28 = _25 + _27;
      float _29 = _X_serializer_mem_channel[_28];
      _22 = _29;
     } // if _24
     else
     {
      float _30 = float_from_bits(0 /* 0 */);
      _22 = _30;
     } // if _24 else
     float _31 = _22;
     write_channel_intel(_xLoader_xFeeder_channel, _31);
     (void)_31;
    } // if _21
    int _32 = _addr_temp;
    int _33 = _32 + 1;
    _addr_temp = _33;
   } // for _xLoader_s0_kk
  } // for _xLoader_s0_k
 } // for _xLoader_s0_i
} // kernel kernel_xLoader
#undef __address_space__X_serializer_mem_channel
// Address spaces for kernel_xFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_xFeeder(
)
{
 _cga__1 _xFeeder_uX_channel_array;
 int _xFeeder_cycle_temp;
 float __attribute__((memory, numbanks(1), singlepump)) _xFeeder_DB_0_ibuffer[2][256];
 _xFeeder_cycle_temp = 1792;
 while(1)
 {
  int _34 = _xFeeder_cycle_temp;
  int _35 = _34 & 2047;
  bool _36 = 1792 <= _35;
  if (_36)
  {
   float __37 = read_channel_intel(_xLoader_xFeeder_channel);
   int _38 = _xFeeder_cycle_temp;
   int _39 = _38 >> 11;
   int _40 = _39 & 1;
   bool _41 = (bool)(_40);
   int _42 = _38 & 2047;
   int _43 = _42 & 255;
   _xFeeder_DB_0_ibuffer[_41][_43] = __37;
  } // if _36
  int _44 = _xFeeder_cycle_temp;
  bool _45 = 2047 < _44;
  if (_45)
  {
   int _46 = _xFeeder_cycle_temp;
   int _47 = _46 >> 11;
   int _48 = _47 & 1;
   bool _49 = (bool)(_48);
   bool _50 = !(_49);
   int _51 = _46 >> 3;
   int _52 = _51 & 255;
   float _53 = _xFeeder_DB_0_ibuffer[_50][_52];
   _xFeeder_uX_channel_array.s = _53;
   (void)_53;
  } // if _45
  int _54 = _xFeeder_cycle_temp;
  bool _55 = 2047 < _54;
  if (_55)
  {
   write_channel_intel(_xFeeder_uX_channel, _xFeeder_uX_channel_array);
   (void)_xFeeder_uX_channel_array;
  } // if _55
  int _56 = _xFeeder_cycle_temp;
  int _57 = _56 + 1;
  _xFeeder_cycle_temp = _57;
 } // while _xFeeder_s0_outermost_loop_infinite
} // kernel kernel_xFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce uZ
 float _uZ_shreg[8][32];
 // produce uX
 float _uX_shreg;
 float _uZ_temp[32];
 // produce uA
 float _uA_shreg[32];
 _cga _Out_unloader_channel_array;
 _cga__1 _xFeeder_uX_channel_array;
 _cga _aLoader_uA_channel_array;
 int _58 = _A_extent_1 >> 8;
 for (int _uA_s0_i = 0; _uA_s0_i < 0 + _58; _uA_s0_i++)
 {
  int _59 = _A_extent_0 >> 8;
  int _60 = _59 - _uA_s0_i;
  for (int _uA_s0_k = _uA_s0_i; _uA_s0_k < _uA_s0_i + _60; _uA_s0_k++)
  {
   for (int _uA_s0_kk_ii = 0; _uA_s0_kk_ii < 0 + 2048; _uA_s0_kk_ii++)
   {
    #pragma unroll
    for (int _dummy_s0_iii = 0; _dummy_s0_iii < 0 + 32; _dummy_s0_iii++)
    {
     float _62 = _uZ_shreg[7][_dummy_s0_iii];
     _uZ_temp[_dummy_s0_iii] = _62;
     #pragma unroll
     for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 7; _dummy__1_s0_l0++)
     {
      int _63 = 7 - _dummy__1_s0_l0;
      int _64 = 6 - _dummy__1_s0_l0;
      float _66 = _uZ_shreg[_64][_dummy_s0_iii];
      _uZ_shreg[_63][_dummy_s0_iii] = _66;
      (void)_66;
     } // for _dummy__1_s0_l0
     float _67 = _uZ_temp[_dummy_s0_iii];
     _uZ_shreg[0][_dummy_s0_iii] = _67;
     (void)_67;
    } // for _dummy_s0_iii
    bool _Out_unloader_channel_cond_temp;
    _Out_unloader_channel_cond_temp = 0;
    _cga__1 __68 = read_channel_intel(_xFeeder_uX_channel);
    _xFeeder_uX_channel_array = __68;
    (void)__68;
    _cga __69 = read_channel_intel(_aLoader_uA_channel);
    _aLoader_uA_channel_array = __69;
    (void)__69;
    #pragma unroll
    for (int _uA_s0_iii = 0; _uA_s0_iii < 0 + 32; _uA_s0_iii++)
    {
     float __70 = _aLoader_uA_channel_array.s[_uA_s0_iii];
     _uA_shreg[_uA_s0_iii] = __70;
     (void)__70;
     float _71;
     bool _72 = _uA_s0_iii == 0;
     if (_72)
     {
      _71 = _xFeeder_uX_channel_array.s;
     } // if _72
     else
     {
      float _74 = _uX_shreg;
      _71 = _74;
     } // if _72 else
     float _75 = _71;
     _uX_shreg = _75;
     (void)_75;
     float _77 = _uX_shreg;
     float _78 = __fpga_reg(__fpga_reg(_77));
     _uX_shreg = _78;
     (void)_78;
     float _79;
     int _80 = _uA_s0_kk_ii >> 3;
     bool _81 = _80 == 0;
     bool _82 = _uA_s0_k == _uA_s0_i;
     bool _83 = _81 && _82;
     if (_83)
     {
      float _84 = float_from_bits(0 /* 0 */);
      _79 = _84;
     } // if _83
     else
     {
      float _86 = _uZ_shreg[0][_uA_s0_iii];
      _79 = _86;
     } // if _83 else
     float _87 = _79;
     float _89 = _uA_shreg[_uA_s0_iii];
     float _91 = _uX_shreg;
     float _92 = _89 * _91;
     float _93 = _87 + _92;
     _uZ_shreg[0][_uA_s0_iii] = _93;
     (void)_93;
     int _94 = _uA_s0_kk_ii >> 3;
     bool _95 = _94 == 255;
     int _96 = _A_extent_0 >> 8;
     int _97 = _96 + -1;
     bool _98 = _uA_s0_k == _97;
     bool _99 = _95 && _98;
     if (_99)
     {
      float _101 = _uZ_shreg[0][_uA_s0_iii];
      _Out_unloader_channel_array.s[_uA_s0_iii] = _101;
      (void)_uA_s0_iii;
      _Out_unloader_channel_cond_temp = 1;
     } // if _99
    } // for _uA_s0_iii
    bool _102 = _Out_unloader_channel_cond_temp;
    if (_102)
    {
     write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
     (void)_Out_unloader_channel_array;
    } // if _102
   } // for _uA_s0_kk_ii
  } // for _uA_s0_k
 } // for _uA_s0_i
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 _cga _Out_unloader_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _103 = _A_extent_1 >> 8;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _103; _unloader_s0_i++)
 {
  for (int _unloader_s0_ii = 0; _unloader_s0_ii < 0 + 8; _unloader_s0_ii++)
  {
   _cga __104 = read_channel_intel(_Out_unloader_channel);
   _Out_unloader_channel_array = __104;
   (void)__104;
   for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 32; _unloader_s0_iii++)
   {
    float __105 = _Out_unloader_channel_array.s[_unloader_s0_iii];
    int _106 = _addr_temp;
    _unloader_mem_channel[_106] = __105;
    int _107 = _addr_temp;
    int _108 = _107 + 1;
    _addr_temp = _108;
   } // for _unloader_s0_iii
  } // for _unloader_s0_ii
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

