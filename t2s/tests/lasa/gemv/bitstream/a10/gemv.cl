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
 int _0 = _A_extent_1 >> 10;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _0; _aLoader_s0_i++)
 {
  int _1 = _A_extent_0 >> 5;
  for (int _aLoader_s0_k = 0; _aLoader_s0_k < 0 + _1; _aLoader_s0_k++)
  {
   for (int _aLoader_s0_kk_ii = 0; _aLoader_s0_kk_ii < 0 + 1024; _aLoader_s0_kk_ii++)
   {
    float _aLoader_temp[32];
    #pragma unroll
    for (int _aLoader_s0_iii_t = 0; _aLoader_s0_iii_t < 0 + 16; _aLoader_s0_iii_t++)
    {
     int _2 = _addr_temp;
     float _3 = _A_serializer_c0_mem_channel[_2];
     _aLoader_temp[_aLoader_s0_iii_t] = _3;
     int _4 = _addr_temp;
     float _5 = _A_serializer_c1_mem_channel[_4];
     int _6 = _aLoader_s0_iii_t + 16;
     _aLoader_temp[_6] = _5;
     int _7 = _addr_temp;
     int _8 = _7 + 1;
     _addr_temp = _8;
    } // for _aLoader_s0_iii_t
    #pragma unroll
    for (int _aLoader_s0_iii = 0; _aLoader_s0_iii < 0 + 32; _aLoader_s0_iii++)
    {
     float _9 = _aLoader_temp[_aLoader_s0_iii];
     _aLoader_uA_channel_array.s[_aLoader_s0_iii] = _9;
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
 int _10 = _A_extent_1 >> 10;
 int _11 = _10 + 1;
 for (int _xLoader_s0_i = 0; _xLoader_s0_i < 0 + _11; _xLoader_s0_i++)
 {
  int _12 = _A_extent_0 >> 5;
  for (int _xLoader_s0_k = 0; _xLoader_s0_k < 0 + _12; _xLoader_s0_k++)
  {
   for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 32; _xLoader_s0_kk++)
   {
    int _13 = _A_extent_1 >> 10;
    bool _14 = _xLoader_s0_i < _13;
    bool _15 = _xLoader_s0_k == 0;
    bool _16 = _14 || _15;
    if (_16)
    {
     float _17;
     int _18 = _A_extent_1 >> 10;
     bool _19 = _xLoader_s0_i < _18;
     if (_19)
     {
      int _20 = _addr_temp;
      int _21 = _A_extent_0 >> 5;
      int _22 = _21 * 32;
      int _23 = _20 % _22;
      float _24 = _X_serializer_mem_channel[_23];
      _17 = _24;
     } // if _19
     else
     {
      float _25 = float_from_bits(0 /* 0 */);
      _17 = _25;
     } // if _19 else
     float _26 = _17;
     write_channel_intel(_xLoader_xFeeder_channel, _26);
     (void)_26;
    } // if _16
    int _27 = _addr_temp;
    int _28 = _27 + 1;
    _addr_temp = _28;
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
 float __attribute__((memory, numbanks(1), singlepump)) _xFeeder_DB_0_ibuffer[2][32];
 _xFeeder_cycle_temp = 992;
 while(1)
 {
  int _29 = _xFeeder_cycle_temp;
  int _30 = _29 & 1023;
  bool _31 = 992 <= _30;
  if (_31)
  {
   float __32 = read_channel_intel(_xLoader_xFeeder_channel);
   int _33 = _xFeeder_cycle_temp;
   int _34 = _33 >> 10;
   int _35 = _34 & 1;
   bool _36 = (bool)(_35);
   int _37 = _33 & 1023;
   int _38 = _37 & 31;
   _xFeeder_DB_0_ibuffer[_36][_38] = __32;
  } // if _31
  int _39 = _xFeeder_cycle_temp;
  bool _40 = 1023 < _39;
  if (_40)
  {
   int _41 = _xFeeder_cycle_temp;
   int _42 = _41 >> 10;
   int _43 = _42 & 1;
   bool _44 = (bool)(_43);
   bool _45 = !(_44);
   int _46 = _41 >> 5;
   int _47 = _46 & 31;
   float _48 = _xFeeder_DB_0_ibuffer[_45][_47];
   _xFeeder_uX_channel_array.s = _48;
   (void)_48;
  } // if _40
  int _49 = _xFeeder_cycle_temp;
  bool _50 = 1023 < _49;
  if (_50)
  {
   write_channel_intel(_xFeeder_uX_channel, _xFeeder_uX_channel_array);
   (void)_xFeeder_uX_channel_array;
  } // if _50
  int _51 = _xFeeder_cycle_temp;
  int _52 = _51 + 1;
  _xFeeder_cycle_temp = _52;
 } // while _xFeeder_s0_outermost_loop_infinite
} // kernel kernel_xFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce uZ
 float _uZ_shreg[32][32];
 // produce uX
 float _uX_shreg;
 float _uZ_temp[32];
 // produce uA
 float _uA_shreg[32];
 _cga _Out_unloader_channel_array;
 _cga__1 _xFeeder_uX_channel_array;
 _cga _aLoader_uA_channel_array;
 int _53 = _A_extent_1 >> 10;
 for (int _uA_s0_i = 0; _uA_s0_i < 0 + _53; _uA_s0_i++)
 {
  int _54 = _A_extent_0 >> 5;
  for (int _uA_s0_k = 0; _uA_s0_k < 0 + _54; _uA_s0_k++)
  {
   for (int _uA_s0_kk_ii = 0; _uA_s0_kk_ii < 0 + 1024; _uA_s0_kk_ii++)
   {
    #pragma unroll
    for (int _dummy_s0_iii = 0; _dummy_s0_iii < 0 + 32; _dummy_s0_iii++)
    {
     float _56 = _uZ_shreg[31][_dummy_s0_iii];
     _uZ_temp[_dummy_s0_iii] = _56;
     #pragma unroll
     for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 31; _dummy__1_s0_l0++)
     {
      int _57 = 31 - _dummy__1_s0_l0;
      int _58 = 30 - _dummy__1_s0_l0;
      float _60 = _uZ_shreg[_58][_dummy_s0_iii];
      _uZ_shreg[_57][_dummy_s0_iii] = _60;
      (void)_60;
     } // for _dummy__1_s0_l0
     float _61 = _uZ_temp[_dummy_s0_iii];
     _uZ_shreg[0][_dummy_s0_iii] = _61;
     (void)_61;
    } // for _dummy_s0_iii
    bool _Out_unloader_channel_cond_temp;
    _Out_unloader_channel_cond_temp = 0;
    _cga__1 __62 = read_channel_intel(_xFeeder_uX_channel);
    _xFeeder_uX_channel_array = __62;
    (void)__62;
    _cga __63 = read_channel_intel(_aLoader_uA_channel);
    _aLoader_uA_channel_array = __63;
    (void)__63;
    #pragma unroll
    for (int _uA_s0_iii = 0; _uA_s0_iii < 0 + 32; _uA_s0_iii++)
    {
     float __64 = _aLoader_uA_channel_array.s[_uA_s0_iii];
     _uA_shreg[_uA_s0_iii] = __64;
     (void)__64;
     float _65;
     bool _66 = _uA_s0_iii == 0;
     if (_66)
     {
      _65 = _xFeeder_uX_channel_array.s;
     } // if _66
     else
     {
      float _68 = _uX_shreg;
      _65 = _68;
     } // if _66 else
     float _69 = _65;
     _uX_shreg = _69;
     (void)_69;
     float _71 = _uX_shreg;
     float _72 = __fpga_reg(__fpga_reg(_71));
     _uX_shreg = _72;
     (void)_72;
     float _73;
     int _74 = _uA_s0_kk_ii >> 5;
     bool _75 = _74 == 0;
     bool _76 = _uA_s0_k == 0;
     bool _77 = _75 && _76;
     if (_77)
     {
      float _78 = float_from_bits(0 /* 0 */);
      _73 = _78;
     } // if _77
     else
     {
      float _80 = _uZ_shreg[0][_uA_s0_iii];
      _73 = _80;
     } // if _77 else
     float _81 = _73;
     float _83 = _uA_shreg[_uA_s0_iii];
     float _85 = _uX_shreg;
     float _86 = _83 * _85;
     float _87 = _81 + _86;
     _uZ_shreg[0][_uA_s0_iii] = _87;
     (void)_87;
     int _88 = _uA_s0_kk_ii >> 5;
     bool _89 = _88 == 31;
     int _90 = _A_extent_0 >> 5;
     int _91 = _90 + -1;
     bool _92 = _uA_s0_k == _91;
     bool _93 = _89 && _92;
     if (_93)
     {
      float _95 = _uZ_shreg[0][_uA_s0_iii];
      _Out_unloader_channel_array.s[_uA_s0_iii] = _95;
      (void)_uA_s0_iii;
      _Out_unloader_channel_cond_temp = 1;
     } // if _93
    } // for _uA_s0_iii
    bool _96 = _Out_unloader_channel_cond_temp;
    if (_96)
    {
     write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
     (void)_Out_unloader_channel_array;
    } // if _96
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
 int _97 = _A_extent_1 >> 10;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _97; _unloader_s0_i++)
 {
  for (int _unloader_s0_ii = 0; _unloader_s0_ii < 0 + 32; _unloader_s0_ii++)
  {
   _cga __98 = read_channel_intel(_Out_unloader_channel);
   _Out_unloader_channel_array = __98;
   (void)__98;
   for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 32; _unloader_s0_iii++)
   {
    float __99 = _Out_unloader_channel_array.s[_unloader_s0_iii];
    int _100 = _addr_temp;
    _unloader_mem_channel[_100] = __99;
    int _101 = _addr_temp;
    int _102 = _101 + 1;
    _addr_temp = _102;
   } // for _unloader_s0_iii
  } // for _unloader_s0_ii
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

