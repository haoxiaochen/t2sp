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
typedef struct { float s[64]; } _cga;
typedef struct { float s; } _cga__1;
channel _cga _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga _aFeeder_uA_channel __attribute__((depth(256))) ;
channel float _xLoader_xFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _xFeeder_uX_channel __attribute__((depth(256))) ;
channel _cga _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_uA_serializer_c0_mem_channel __global
#define __address_space__A_uA_serializer_c1_mem_channel __global
#define __address_space__A_uA_serializer_c2_mem_channel __global
#define __address_space__A_uA_serializer_c3_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_uA_serializer_c0_mem_channel const float *restrict _A_uA_serializer_c0_mem_channel,
 __address_space__A_uA_serializer_c1_mem_channel const float *restrict _A_uA_serializer_c1_mem_channel,
 __address_space__A_uA_serializer_c2_mem_channel const float *restrict _A_uA_serializer_c2_mem_channel,
 __address_space__A_uA_serializer_c3_mem_channel const float *restrict _A_uA_serializer_c3_mem_channel)
{
 _cga _aLoader_aFeeder_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_0 >> 11;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _0; _aLoader_s0_i++)
 {
  int _1 = _A_extent_1 >> 10;
  for (int _aLoader_s0_k = 0; _aLoader_s0_k < 0 + _1; _aLoader_s0_k++)
  {
   for (int _aLoader_s0_kk_iii = 0; _aLoader_s0_kk_iii < 0 + 32768; _aLoader_s0_kk_iii++)
   {
    float _aLoader_temp[64];
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
     float _8 = _A_uA_serializer_c2_mem_channel[_7];
     int _9 = _aLoader_s0_vi_t + 32;
     _aLoader_temp[_9] = _8;
     int _10 = _addr_temp;
     float _11 = _A_uA_serializer_c3_mem_channel[_10];
     int _12 = _aLoader_s0_vi_t + 48;
     _aLoader_temp[_12] = _11;
     int _13 = _addr_temp;
     int _14 = _13 + 1;
     _addr_temp = _14;
    } // for _aLoader_s0_vi_t
    #pragma unroll
    for (int _aLoader_s0_vi = 0; _aLoader_s0_vi < 0 + 64; _aLoader_s0_vi++)
    {
     float _15 = _aLoader_temp[_aLoader_s0_vi];
     _aLoader_aFeeder_channel_array.s[_aLoader_s0_vi] = _15;
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
#undef __address_space__A_uA_serializer_c2_mem_channel
#undef __address_space__A_uA_serializer_c3_mem_channel
// Address spaces for kernel_aFeeder
__kernel void kernel_aFeeder(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga _aLoader_aFeeder_channel_array;
 _cga _aFeeder_uA_channel_array;
 int _16 = _A_extent_0 >> 11;
 for (int _aFeeder_s0_i = 0; _aFeeder_s0_i < 0 + _16; _aFeeder_s0_i++)
 {
  int _17 = _A_extent_1 >> 10;
  for (int _aFeeder_s0_k = 0; _aFeeder_s0_k < 0 + _17; _aFeeder_s0_k++)
  {
   for (int _aFeeder_s0_kk_iii = 0; _aFeeder_s0_kk_iii < 0 + 32768; _aFeeder_s0_kk_iii++)
   {
    _cga __18 = read_channel_intel(_aLoader_aFeeder_channel);
    _aLoader_aFeeder_channel_array = __18;
    (void)__18;
    #pragma unroll
    for (int _aFeeder_s0_vi = 0; _aFeeder_s0_vi < 0 + 64; _aFeeder_s0_vi++)
    {
     float __19 = _aLoader_aFeeder_channel_array.s[_aFeeder_s0_vi];
     _aFeeder_uA_channel_array.s[_aFeeder_s0_vi] = __19;
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
 int _20 = _A_extent_0 >> 11;
 for (int _xLoader_s0_i = 0; _xLoader_s0_i < 0 + _20; _xLoader_s0_i++)
 {
  int _21 = _A_extent_1 >> 10;
  for (int _xLoader_s0_k = 0; _xLoader_s0_k < 0 + _21; _xLoader_s0_k++)
  {
   for (int _xLoader_s0_kk = 0; _xLoader_s0_kk < 0 + 1024; _xLoader_s0_kk++)
   {
    int _22 = _addr_temp;
    int _23 = _A_extent_1 >> 10;
    int _24 = _23 * 1024;
    int _25 = _22 % _24;
    float _26 = _X_uA_serializer_mem_channel[_25];
    write_channel_intel(_xLoader_xFeeder_channel, _26);
    (void)_26;
    int _27 = _22 + 1;
    _addr_temp = _27;
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
 int _28 = _A_extent_0 >> 11;
 int _29 = _A_extent_1 >> 10;
 int _30 = _28 * _29;
 int _xFeeder_cycle_temp;
 float __attribute__((memory, numbanks(1), singlepump)) _xFeeder_DB_0_ibuffer[2][1024];
 _xFeeder_cycle_temp = 31744;
 int _31 = _A_extent_0 >> 11;
 int _32 = _A_extent_1 >> 10;
 int _33 = _31 * _32;
 int _34 = _33 * 32768;
 int _35 = _34 + 32768;
 for (int _xFeeder_s0_outermost_loop = 0; _xFeeder_s0_outermost_loop < 0 + _35; _xFeeder_s0_outermost_loop++)
 {
  int _36 = _xFeeder_cycle_temp;
  int _37 = _36 & 32767;
  bool _38 = 31744 <= _37;
  int _39 = _36 >> 15;
  bool _40 = _39 < _30;
  bool _41 = _38 && _40;
  if (_41)
  {
   float __42 = read_channel_intel(_xLoader_xFeeder_channel);
   int _43 = _xFeeder_cycle_temp;
   int _44 = _43 >> 15;
   int _45 = _44 & 1;
   bool _46 = (bool)(_45);
   int _47 = _43 & 32767;
   int _48 = _47 & 1023;
   _xFeeder_DB_0_ibuffer[_46][_48] = __42;
  } // if _41
  int _49 = _xFeeder_cycle_temp;
  int _50 = _49 >> 15;
  bool _51 = _50 <= _30;
  bool _52 = 32767 < _49;
  bool _53 = _51 && _52;
  if (_53)
  {
   int _54 = _xFeeder_cycle_temp;
   int _55 = _54 >> 15;
   int _56 = _55 & 1;
   bool _57 = (bool)(_56);
   bool _58 = !(_57);
   int _59 = _54 >> 5;
   int _60 = _59 & 1023;
   float _61 = _xFeeder_DB_0_ibuffer[_58][_60];
   _xFeeder_uX_channel_array.s = _61;
   (void)_61;
  } // if _53
  int _62 = _xFeeder_cycle_temp;
  int _63 = _62 >> 15;
  bool _64 = _63 <= _30;
  bool _65 = 32767 < _62;
  bool _66 = _64 && _65;
  if (_66)
  {
   write_channel_intel(_xFeeder_uX_channel, _xFeeder_uX_channel_array);
   (void)_xFeeder_uX_channel_array;
  } // if _66
  int _67 = _xFeeder_cycle_temp;
  int _68 = _67 + 1;
  _xFeeder_cycle_temp = _68;
 } // for _xFeeder_s0_outermost_loop
} // kernel kernel_xFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce uZ
 float _uZ_shreg[32][64];
 // produce uX
 float _uX_shreg;
 float _uZ_temp[64];
 // produce uA
 float _uA_shreg[64];
 _cga _Out_unloader_channel_array;
 _cga__1 _xFeeder_uX_channel_array;
 _cga _aFeeder_uA_channel_array;
 int _69 = _A_extent_0 >> 11;
 for (int _uA_s0_i = 0; _uA_s0_i < 0 + _69; _uA_s0_i++)
 {
  int _70 = _A_extent_1 >> 10;
  for (int _uA_s0_k = 0; _uA_s0_k < 0 + _70; _uA_s0_k++)
  {
   for (int _uA_s0_kk_iii = 0; _uA_s0_kk_iii < 0 + 32768; _uA_s0_kk_iii++)
   {
    #pragma unroll
    for (int _dummy_s0_vi = 0; _dummy_s0_vi < 0 + 64; _dummy_s0_vi++)
    {
     float _72 = _uZ_shreg[31][_dummy_s0_vi];
     _uZ_temp[_dummy_s0_vi] = _72;
     #pragma unroll
     for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 31; _dummy__1_s0_l0++)
     {
      int _73 = 31 - _dummy__1_s0_l0;
      int _74 = 30 - _dummy__1_s0_l0;
      float _76 = _uZ_shreg[_74][_dummy_s0_vi];
      _uZ_shreg[_73][_dummy_s0_vi] = _76;
      (void)_76;
     } // for _dummy__1_s0_l0
     float _77 = _uZ_temp[_dummy_s0_vi];
     _uZ_shreg[0][_dummy_s0_vi] = _77;
     (void)_77;
    } // for _dummy_s0_vi
    bool _Out_unloader_channel_cond_temp;
    _Out_unloader_channel_cond_temp = 0;
    _cga__1 __78 = read_channel_intel(_xFeeder_uX_channel);
    _xFeeder_uX_channel_array = __78;
    (void)__78;
    _cga __79 = read_channel_intel(_aFeeder_uA_channel);
    _aFeeder_uA_channel_array = __79;
    (void)__79;
    #pragma unroll
    for (int _uA_s0_vi = 0; _uA_s0_vi < 0 + 64; _uA_s0_vi++)
    {
     float __80 = _aFeeder_uA_channel_array.s[_uA_s0_vi];
     _uA_shreg[_uA_s0_vi] = __80;
     (void)__80;
     float _81;
     bool _82 = _uA_s0_vi == 0;
     if (_82)
     {
      _81 = _xFeeder_uX_channel_array.s;
     } // if _82
     else
     {
      float _84 = _uX_shreg;
      _81 = _84;
     } // if _82 else
     float _85 = _81;
     _uX_shreg = _85;
     (void)_85;
     float _87 = _uX_shreg;
     float _88 = __fpga_reg(__fpga_reg(_87));
     _uX_shreg = _88;
     (void)_88;
     float _89;
     int _90 = _uA_s0_kk_iii >> 5;
     bool _91 = _90 == 0;
     bool _92 = _uA_s0_k == 0;
     bool _93 = _91 && _92;
     if (_93)
     {
      float _94 = float_from_bits(0 /* 0 */);
      _89 = _94;
     } // if _93
     else
     {
      float _96 = _uZ_shreg[0][_uA_s0_vi];
      _89 = _96;
     } // if _93 else
     float _97 = _89;
     float _99 = _uA_shreg[_uA_s0_vi];
     float _101 = _uX_shreg;
     float _102 = _99 * _101;
     float _103 = _97 + _102;
     _uZ_shreg[0][_uA_s0_vi] = _103;
     (void)_103;
     int _104 = _uA_s0_kk_iii >> 5;
     bool _105 = _104 == 1023;
     int _106 = _A_extent_1 >> 10;
     int _107 = _106 + -1;
     bool _108 = _uA_s0_k == _107;
     bool _109 = _105 && _108;
     if (_109)
     {
      float _111 = _uZ_shreg[0][_uA_s0_vi];
      _Out_unloader_channel_array.s[_uA_s0_vi] = _111;
      (void)_uA_s0_vi;
      _Out_unloader_channel_cond_temp = 1;
     } // if _109
    } // for _uA_s0_vi
    bool _112 = _Out_unloader_channel_cond_temp;
    if (_112)
    {
     write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
     (void)_Out_unloader_channel_array;
    } // if _112
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
 int _113 = _A_extent_0 >> 11;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _113; _unloader_s0_i++)
 {
  for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 32; _unloader_s0_iii++)
  {
   _cga __114 = read_channel_intel(_Out_unloader_channel);
   _Out_unloader_channel_array = __114;
   (void)__114;
   for (int _unloader_s0_vi = 0; _unloader_s0_vi < 0 + 64; _unloader_s0_vi++)
   {
    float __115 = _Out_unloader_channel_array.s[_unloader_s0_vi];
    int _116 = _addr_temp;
    _unloader_mem_channel[_116] = __115;
    int _117 = _addr_temp;
    int _118 = _117 + 1;
    _addr_temp = _118;
   } // for _unloader_s0_vi
  } // for _unloader_s0_iii
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

