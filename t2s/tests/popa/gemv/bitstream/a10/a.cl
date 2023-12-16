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
channel _cga _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga _aFeeder_uA_channel __attribute__((depth(256))) ;
channel float _xLoader_xFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _xFeeder_uX_channel __attribute__((depth(256))) ;
channel _cga _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_uA_serializer_c0_mem_channel __global
#define __address_space__A_uA_serializer_c1_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_uA_serializer_c0_mem_channel const float *restrict _A_uA_serializer_c0_mem_channel,
 __address_space__A_uA_serializer_c1_mem_channel const float *restrict _A_uA_serializer_c1_mem_channel)
{
 _cga _aLoader_aFeeder_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_0 >> 10;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _0; _aLoader_s0_i++)
 {
  int _1 = _A_extent_1 >> 10;
  for (int _aLoader_s0_k = 0; _aLoader_s0_k < 0 + _1; _aLoader_s0_k++)
  {
   for (int _aLoader_s0_kk_iii = 0; _aLoader_s0_kk_iii < 0 + 32768; _aLoader_s0_kk_iii++)
   {
    float _aLoader_temp[32];
    #pragma unroll
    for (int _aLoader_s0_vi_t = 0; _aLoader_s0_vi_t < 0 + 16; _aLoader_s0_vi_t++)
    {
     int _2 = _addr_temp;
     float _3 = _A_uA_serializer_c0_mem_channel[_2];
     _aLoader_temp[_aLoader_s0_vi_t] = _3;
     int _4 = _addr_temp;
     float _5 = _A_uA_serializer_c1_mem_channel[_4];
     int _6 = _aLoader_s0_vi_t + 16;
     _aLoader_temp[_6] = _5;
     int _7 = _addr_temp;
     int _8 = _7 + 1;
     _addr_temp = _8;
    } // for _aLoader_s0_vi_t
    #pragma unroll
    for (int _aLoader_s0_vi = 0; _aLoader_s0_vi < 0 + 32; _aLoader_s0_vi++)
    {
     float _9 = _aLoader_temp[_aLoader_s0_vi];
     _aLoader_aFeeder_channel_array.s[_aLoader_s0_vi] = _9;
     (void)_aLoader_s0_vi;
    } // for _aLoader_s0_vi
    write_channel_intel(_aLoader_aFeeder_channel, _aLoader_aFeeder_channel_array);
    (void)_aLoader_aFeeder_channel_array;
   } // for _aLoader_s0_kk_iii
  } // for _aLoader_s0_k
 } // for _aLoader_s0_i
} // kernel kernel_aLoader
#undef __address_space__A_uA_serializer_c0_mem_channel
#undef __address_space__A_uA_serializer_c1_mem_channel
// Address spaces for kernel_aFeeder
__kernel void kernel_aFeeder(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga _aLoader_aFeeder_channel_array;
 _cga _aFeeder_uA_channel_array;
 int _10 = _A_extent_0 >> 10;
 for (int _aFeeder_s0_i = 0; _aFeeder_s0_i < 0 + _10; _aFeeder_s0_i++)
 {
  int _11 = _A_extent_1 >> 10;
  for (int _aFeeder_s0_k = 0; _aFeeder_s0_k < 0 + _11; _aFeeder_s0_k++)
  {
   for (int _aFeeder_s0_kk_iii = 0; _aFeeder_s0_kk_iii < 0 + 32768; _aFeeder_s0_kk_iii++)
   {
    _cga __12 = read_channel_intel(_aLoader_aFeeder_channel);
    _aLoader_aFeeder_channel_array = __12;
    (void)__12;
    #pragma unroll
    for (int _aFeeder_s0_vi = 0; _aFeeder_s0_vi < 0 + 32; _aFeeder_s0_vi++)
    {
     float __13 = _aLoader_aFeeder_channel_array.s[_aFeeder_s0_vi];
     _aFeeder_uA_channel_array.s[_aFeeder_s0_vi] = __13;
     (void)_aFeeder_s0_vi;
    } // for _aFeeder_s0_vi
    write_channel_intel(_aFeeder_uA_channel, _aFeeder_uA_channel_array);
    (void)_aFeeder_uA_channel_array;
   } // for _aFeeder_s0_kk_iii
  } // for _aFeeder_s0_k
 } // for _aFeeder_s0_i
} // kernel kernel_aFeeder
// Address spaces for kernel_xLoader
#define __address_space__X_uA_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__X_uA_serializer_mem_channel const float *restrict _X_uA_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _14 = _A_extent_0 >> 10;
 for (int _xLoader_s0_i = 0; _xLoader_s0_i < 0 + _14; _xLoader_s0_i++)
 {
  int _15 = _A_extent_1 >> 10;
  for (int _xLoader_s0_k = 0; _xLoader_s0_k < 0 + _15; _xLoader_s0_k++)
  {
   for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 1024; _xLoader_s0_kk++)
   {
    int _16 = _addr_temp;
    int _17 = _A_extent_1 >> 10;
    int _18 = _17 * 1024;
    int _19 = _16 % _18;
    float _20 = _X_uA_serializer_mem_channel[_19];
    write_channel_intel(_xLoader_xFeeder_channel, _20);
    (void)_20;
    int _21 = _16 + 1;
    _addr_temp = _21;
   } // for _xLoader_s0_kk
  } // for _xLoader_s0_k
 } // for _xLoader_s0_i
} // kernel kernel_xLoader
#undef __address_space__X_uA_serializer_mem_channel
// Address spaces for kernel_xFeeder
__kernel void kernel_xFeeder(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga__1 _xFeeder_uX_channel_array;
 int _22 = _A_extent_0 >> 10;
 int _23 = _A_extent_1 >> 10;
 int _24 = _22 * _23;
 int _xFeeder_cycle_temp;
 float __attribute__((memory, numbanks(1), singlepump)) _xFeeder_DB_0_ibuffer[2][1024];
 _xFeeder_cycle_temp = 31744;
 int _25 = _A_extent_0 >> 10;
 int _26 = _A_extent_1 >> 10;
 int _27 = _25 * _26;
 int _28 = _27 * 32768;
 int _29 = _28 + 32768;
 for (int _xFeeder_s0_outermost_loop = 0; _xFeeder_s0_outermost_loop < 0 + _29; _xFeeder_s0_outermost_loop++)
 {
  int _30 = _xFeeder_cycle_temp;
  int _31 = _30 & 32767;
  bool _32 = 31744 <= _31;
  int _33 = _30 >> 15;
  bool _34 = _33 < _24;
  bool _35 = _32 && _34;
  if (_35)
  {
   float __36 = read_channel_intel(_xLoader_xFeeder_channel);
   int _37 = _xFeeder_cycle_temp;
   int _38 = _37 >> 15;
   int _39 = _38 & 1;
   bool _40 = (bool)(_39);
   int _41 = _37 & 32767;
   int _42 = _41 & 1023;
   _xFeeder_DB_0_ibuffer[_40][_42] = __36;
  } // if _35
  int _43 = _xFeeder_cycle_temp;
  int _44 = _43 >> 15;
  bool _45 = _44 <= _24;
  bool _46 = 32767 < _43;
  bool _47 = _45 && _46;
  if (_47)
  {
   int _48 = _xFeeder_cycle_temp;
   int _49 = _48 >> 15;
   int _50 = _49 & 1;
   bool _51 = (bool)(_50);
   bool _52 = !(_51);
   int _53 = _48 >> 5;
   int _54 = _53 & 1023;
   float _55 = _xFeeder_DB_0_ibuffer[_52][_54];
   _xFeeder_uX_channel_array.s = _55;
   (void)_55;
  } // if _47
  int _56 = _xFeeder_cycle_temp;
  int _57 = _56 >> 15;
  bool _58 = _57 <= _24;
  bool _59 = 32767 < _56;
  bool _60 = _58 && _59;
  if (_60)
  {
   write_channel_intel(_xFeeder_uX_channel, _xFeeder_uX_channel_array);
   (void)_xFeeder_uX_channel_array;
  } // if _60
  int _61 = _xFeeder_cycle_temp;
  int _62 = _61 + 1;
  _xFeeder_cycle_temp = _62;
 } // for _xFeeder_s0_outermost_loop
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
 _cga _aFeeder_uA_channel_array;
 int _63 = _A_extent_0 >> 10;
 for (int _uA_s0_i = 0; _uA_s0_i < 0 + _63; _uA_s0_i++)
 {
  int _64 = _A_extent_1 >> 10;
  for (int _uA_s0_k = 0; _uA_s0_k < 0 + _64; _uA_s0_k++)
  {
   for (int _uA_s0_kk_iii = 0; _uA_s0_kk_iii < 0 + 32768; _uA_s0_kk_iii++)
   {
    #pragma unroll
    for (int _dummy_s0_vi = 0; _dummy_s0_vi < 0 + 32; _dummy_s0_vi++)
    {
     float _66 = _uZ_shreg[31][_dummy_s0_vi];
     _uZ_temp[_dummy_s0_vi] = _66;
     #pragma unroll
     for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 31; _dummy__1_s0_l0++)
     {
      int _67 = 31 - _dummy__1_s0_l0;
      int _68 = 30 - _dummy__1_s0_l0;
      float _70 = _uZ_shreg[_68][_dummy_s0_vi];
      _uZ_shreg[_67][_dummy_s0_vi] = _70;
      (void)_70;
     } // for _dummy__1_s0_l0
     float _71 = _uZ_temp[_dummy_s0_vi];
     _uZ_shreg[0][_dummy_s0_vi] = _71;
     (void)_71;
    } // for _dummy_s0_vi
    bool _Out_unloader_channel_cond_temp;
    _Out_unloader_channel_cond_temp = 0;
    _cga__1 __72 = read_channel_intel(_xFeeder_uX_channel);
    _xFeeder_uX_channel_array = __72;
    (void)__72;
    _cga __73 = read_channel_intel(_aFeeder_uA_channel);
    _aFeeder_uA_channel_array = __73;
    (void)__73;
    #pragma unroll
    for (int _uA_s0_vi = 0; _uA_s0_vi < 0 + 32; _uA_s0_vi++)
    {
     float __74 = _aFeeder_uA_channel_array.s[_uA_s0_vi];
     _uA_shreg[_uA_s0_vi] = __74;
     (void)__74;
     float _75;
     bool _76 = _uA_s0_vi == 0;
     if (_76)
     {
      _75 = _xFeeder_uX_channel_array.s;
     } // if _76
     else
     {
      float _78 = _uX_shreg;
      _75 = _78;
     } // if _76 else
     float _79 = _75;
     _uX_shreg = _79;
     (void)_79;
     float _81 = _uX_shreg;
     float _82 = __fpga_reg(__fpga_reg(_81));
     _uX_shreg = _82;
     (void)_82;
     float _83;
     int _84 = _uA_s0_kk_iii >> 5;
     bool _85 = _84 == 0;
     bool _86 = _uA_s0_k == 0;
     bool _87 = _85 && _86;
     if (_87)
     {
      float _88 = float_from_bits(0 /* 0 */);
      _83 = _88;
     } // if _87
     else
     {
      float _90 = _uZ_shreg[0][_uA_s0_vi];
      _83 = _90;
     } // if _87 else
     float _91 = _83;
     float _93 = _uA_shreg[_uA_s0_vi];
     float _95 = _uX_shreg;
     float _96 = _93 * _95;
     float _97 = _91 + _96;
     _uZ_shreg[0][_uA_s0_vi] = _97;
     (void)_97;
     int _98 = _uA_s0_kk_iii >> 5;
     bool _99 = _98 == 1023;
     int _100 = _A_extent_1 >> 10;
     int _101 = _100 + -1;
     bool _102 = _uA_s0_k == _101;
     bool _103 = _99 && _102;
     if (_103)
     {
      float _105 = _uZ_shreg[0][_uA_s0_vi];
      _Out_unloader_channel_array.s[_uA_s0_vi] = _105;
      (void)_uA_s0_vi;
      _Out_unloader_channel_cond_temp = 1;
     } // if _103
    } // for _uA_s0_vi
    bool _106 = _Out_unloader_channel_cond_temp;
    if (_106)
    {
     write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
     (void)_Out_unloader_channel_array;
    } // if _106
   } // for _uA_s0_kk_iii
  } // for _uA_s0_k
 } // for _uA_s0_i
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_0,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 _cga _Out_unloader_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _107 = _A_extent_0 >> 10;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _107; _unloader_s0_i++)
 {
  for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 32; _unloader_s0_iii++)
  {
   _cga __108 = read_channel_intel(_Out_unloader_channel);
   _Out_unloader_channel_array = __108;
   (void)__108;
   for (int _unloader_s0_vi = 0; _unloader_s0_vi < 0 + 32; _unloader_s0_vi++)
   {
    float __109 = _Out_unloader_channel_array.s[_unloader_s0_vi];
    int _110 = _addr_temp;
    _unloader_mem_channel[_110] = __109;
    int _111 = _addr_temp;
    int _112 = _111 + 1;
    _addr_temp = _112;
   } // for _unloader_s0_vi
  } // for _unloader_s0_iii
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

