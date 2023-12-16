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
channel _cga _DA_SA_channel __attribute__((depth(256))) ;
channel _cga _SA_MV_channel __attribute__((depth(256))) ;
channel float _DX_SX_channel __attribute__((depth(256))) ;
channel _cga__1 _SX_fX_channel __attribute__((depth(256))) ;
channel _cga__1 _TopOut_DTopOut_channel __attribute__((depth(256))) ;
channel _cga _RightOut_DRightOut_channel __attribute__((depth(256))) ;
// Address spaces for kernel_DA
#define __address_space__A_fX_serializer_c0_mem_channel __global
#define __address_space__A_fX_serializer_c1_mem_channel __global
#define __address_space__A_fX_serializer_c2_mem_channel __global
#define __address_space__A_fX_serializer_c3_mem_channel __global
__kernel void kernel_DA(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_fX_serializer_c0_mem_channel const float *restrict _A_fX_serializer_c0_mem_channel,
 __address_space__A_fX_serializer_c1_mem_channel const float *restrict _A_fX_serializer_c1_mem_channel,
 __address_space__A_fX_serializer_c2_mem_channel const float *restrict _A_fX_serializer_c2_mem_channel,
 __address_space__A_fX_serializer_c3_mem_channel const float *restrict _A_fX_serializer_c3_mem_channel)
{
 _cga _DA_SA_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_1 >> 13;
 for (int _DA_s0_k = 0; _DA_s0_k < 0 + _0; _DA_s0_k++)
 {
  int _1 = _A_extent_0 >> 12;
  for (int _DA_s0_i = 0; _DA_s0_i < 0 + _1; _DA_s0_i++)
  {
   for (int _DA_s0_kkk_iii = 0; _DA_s0_kkk_iii < 0 + 524288; _DA_s0_kkk_iii++)
   {
    float _DA_temp[64];
    #pragma unroll
    for (int _DA_s0_vi_t = 0; _DA_s0_vi_t < 0 + 16; _DA_s0_vi_t++)
    {
     int _2 = _addr_temp;
     float _3 = _A_fX_serializer_c0_mem_channel[_2];
     _DA_temp[_DA_s0_vi_t] = _3;
     int _4 = _addr_temp;
     float _5 = _A_fX_serializer_c1_mem_channel[_4];
     int _6 = _DA_s0_vi_t + 16;
     _DA_temp[_6] = _5;
     int _7 = _addr_temp;
     float _8 = _A_fX_serializer_c2_mem_channel[_7];
     int _9 = _DA_s0_vi_t + 32;
     _DA_temp[_9] = _8;
     int _10 = _addr_temp;
     float _11 = _A_fX_serializer_c3_mem_channel[_10];
     int _12 = _DA_s0_vi_t + 48;
     _DA_temp[_12] = _11;
     int _13 = _addr_temp;
     int _14 = _13 + 1;
     _addr_temp = _14;
    } // for _DA_s0_vi_t
    #pragma unroll
    for (int _DA_s0_vi = 0; _DA_s0_vi < 0 + 64; _DA_s0_vi++)
    {
     float _15 = _DA_temp[_DA_s0_vi];
     _DA_SA_channel_array.s[_DA_s0_vi] = _15;
     (void)_DA_s0_vi;
    } // for _DA_s0_vi
    write_channel_intel(_DA_SA_channel, _DA_SA_channel_array);
    (void)_DA_SA_channel_array;
   } // for _DA_s0_kkk_iii
  } // for _DA_s0_i
 } // for _DA_s0_k
} // kernel kernel_DA
#undef __address_space__A_fX_serializer_c0_mem_channel
#undef __address_space__A_fX_serializer_c1_mem_channel
#undef __address_space__A_fX_serializer_c2_mem_channel
#undef __address_space__A_fX_serializer_c3_mem_channel
// Address spaces for kernel_SA
__kernel void kernel_SA(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga _DA_SA_channel_array;
 _cga _SA_MV_channel_array;
 int _16 = _A_extent_1 >> 13;
 for (int _SA_s0_k = 0; _SA_s0_k < 0 + _16; _SA_s0_k++)
 {
  int _17 = _A_extent_0 >> 12;
  for (int _SA_s0_i = 0; _SA_s0_i < 0 + _17; _SA_s0_i++)
  {
   for (int _SA_s0_kkk_iii = 0; _SA_s0_kkk_iii < 0 + 524288; _SA_s0_kkk_iii++)
   {
    _cga __18 = read_channel_intel(_DA_SA_channel);
    _DA_SA_channel_array = __18;
    (void)__18;
    #pragma unroll
    for (int _SA_s0_vi = 0; _SA_s0_vi < 0 + 64; _SA_s0_vi++)
    {
     float __19 = _DA_SA_channel_array.s[_SA_s0_vi];
     _SA_MV_channel_array.s[_SA_s0_vi] = __19;
     (void)_SA_s0_vi;
    } // for _SA_s0_vi
    write_channel_intel(_SA_MV_channel, _SA_MV_channel_array);
    (void)_SA_MV_channel_array;
   } // for _SA_s0_kkk_iii
  } // for _SA_s0_i
 } // for _SA_s0_k
} // kernel kernel_SA
// Address spaces for kernel_DX
#define __address_space__X_fX_serializer_mem_channel __global
__kernel void kernel_DX(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__X_fX_serializer_mem_channel const float *restrict _X_fX_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _20 = _A_extent_1 >> 13;
 for (int _DX_s0_k = 0; _DX_s0_k < 0 + _20; _DX_s0_k++)
 {
  int _21 = _A_extent_0 >> 12;
  for (int _DX_s0_i = 0; _DX_s0_i < 0 + _21; _DX_s0_i++)
  {
   for (int _DX_s0_kkk = 0; _DX_s0_kkk < 0 + 8192; _DX_s0_kkk++)
   {
    int _22 = _addr_temp;
    int _23 = _A_extent_0 >> 12;
    int _24 = _23 * 8192;
    int _25 = _22 / _24;
    int _26 = _25 * 8192;
    int _27 = _22 & 8191;
    int _28 = _26 + _27;
    float _29 = _X_fX_serializer_mem_channel[_28];
    write_channel_intel(_DX_SX_channel, _29);
    (void)_29;
    int _30 = _22 + 1;
    _addr_temp = _30;
   } // for _DX_s0_kkk
  } // for _DX_s0_i
 } // for _DX_s0_k
} // kernel kernel_DX
#undef __address_space__X_fX_serializer_mem_channel
// Address spaces for kernel_SX
__kernel void kernel_SX(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga__1 _SX_fX_channel_array;
 int _31 = _A_extent_1 >> 13;
 int _32 = _A_extent_0 >> 12;
 int _33 = _31 * _32;
 int _SX_cycle_temp;
 float __attribute__((memory, numbanks(1), singlepump)) _SX_DB_0_ibuffer[2][8192];
 _SX_cycle_temp = 516096;
 int _34 = _A_extent_1 >> 13;
 int _35 = _A_extent_0 >> 12;
 int _36 = _34 * _35;
 int _37 = _36 * 524288;
 int _38 = _37 + 524288;
 for (int _SX_s0_outermost_loop = 0; _SX_s0_outermost_loop < 0 + _38; _SX_s0_outermost_loop++)
 {
  int _39 = _SX_cycle_temp;
  int _40 = _39 & 524287;
  bool _41 = 516096 <= _40;
  int _42 = _39 >> 19;
  bool _43 = _42 < _33;
  bool _44 = _41 && _43;
  if (_44)
  {
   float __45 = read_channel_intel(_DX_SX_channel);
   int _46 = _SX_cycle_temp;
   int _47 = _46 >> 19;
   int _48 = _47 & 1;
   bool _49 = (bool)(_48);
   int _50 = _46 & 524287;
   int _51 = _50 & 8191;
   _SX_DB_0_ibuffer[_49][_51] = __45;
  } // if _44
  int _52 = _SX_cycle_temp;
  int _53 = _52 >> 19;
  bool _54 = _53 <= _33;
  bool _55 = 524287 < _52;
  bool _56 = _54 && _55;
  if (_56)
  {
   int _57 = _SX_cycle_temp;
   int _58 = _57 >> 19;
   int _59 = _58 & 1;
   bool _60 = (bool)(_59);
   bool _61 = !(_60);
   int _62 = _57 >> 6;
   int _63 = _62 & 8191;
   float _64 = _SX_DB_0_ibuffer[_61][_63];
   _SX_fX_channel_array.s = _64;
   (void)_64;
  } // if _56
  int _65 = _SX_cycle_temp;
  int _66 = _65 >> 19;
  bool _67 = _66 <= _33;
  bool _68 = 524287 < _65;
  bool _69 = _67 && _68;
  if (_69)
  {
   write_channel_intel(_SX_fX_channel, _SX_fX_channel_array);
   (void)_SX_fX_channel_array;
  } // if _69
  int _70 = _SX_cycle_temp;
  int _71 = _70 + 1;
  _SX_cycle_temp = _71;
 } // for _SX_s0_outermost_loop
} // kernel kernel_SX
// Address spaces for kernel_TopOut
__kernel void kernel_TopOut(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce RightOut
 // produce MV
 float _MV_shreg[65][64];
 // produce fX
 float _fX_shreg;
 _cga__1 _TopOut_DTopOut_channel_array;
 _cga _RightOut_DRightOut_channel_array;
 _cga _SA_MV_channel_array;
 _cga__1 _SX_fX_channel_array;
 int _72 = _A_extent_1 >> 13;
 for (int _fX_s0_k = 0; _fX_s0_k < 0 + _72; _fX_s0_k++)
 {
  int _73 = _A_extent_0 >> 12;
  for (int _fX_s0_i = 0; _fX_s0_i < 0 + _73; _fX_s0_i++)
  {
   for (int _fX_s0_kkk = 0; _fX_s0_kkk < 0 + 8192; _fX_s0_kkk++)
   {
    for (int _fX_s0_iii = 0; _fX_s0_iii < 0 + 64; _fX_s0_iii++)
    {
     #pragma unroll
     for (int _dummy_s0_vi = 0; _dummy_s0_vi < 0 + 64; _dummy_s0_vi++)
     {
      #pragma unroll
      for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 64; _dummy__1_s0_l0++)
      {
       int _74 = 64 - _dummy__1_s0_l0;
       int _75 = 63 - _dummy__1_s0_l0;
       float _77 = _MV_shreg[_75][_dummy_s0_vi];
       _MV_shreg[_74][_dummy_s0_vi] = _77;
       (void)_77;
      } // for _dummy__1_s0_l0
     } // for _dummy_s0_vi
     _cga __78 = read_channel_intel(_SA_MV_channel);
     _SA_MV_channel_array = __78;
     (void)__78;
     _cga__1 __79 = read_channel_intel(_SX_fX_channel);
     _SX_fX_channel_array = __79;
     (void)__79;
     #pragma unroll
     for (int _fX_s0_vi = 0; _fX_s0_vi < 0 + 64; _fX_s0_vi++)
     {
      float _80;
      bool _81 = _fX_s0_vi == 0;
      if (_81)
      {
       _80 = _SX_fX_channel_array.s;
      } // if _81
      else
      {
       float _83 = _fX_shreg;
       _80 = _83;
      } // if _81 else
      float _84 = _80;
      _fX_shreg = _84;
      (void)_84;
      float _86 = _fX_shreg;
      float _87 = __fpga_reg(__fpga_reg(_86));
      _fX_shreg = _87;
      (void)_87;
      float _88;
      bool _89 = _fX_s0_iii == 63;
      bool _90 = _fX_s0_vi == 63;
      bool _91 = _89 && _90;
      bool _92 = _fX_s0_kkk == 0;
      bool _93 = _91 || _92;
      if (_93)
      {
       float _94 = float_from_bits(0 /* 0 */);
       _88 = _94;
      } // if _93
      else
      {
       float _95;
       bool _96 = _fX_s0_vi == 63;
       if (_96)
       {
        int _97 = _fX_s0_vi + -63;
        float _99 = _MV_shreg[63][_97];
        _95 = _99;
       } // if _96
       else
       {
        int _100 = _fX_s0_vi + 1;
        float _102 = _MV_shreg[64][_100];
        _95 = _102;
       } // if _96 else
       float _103 = _95;
       _88 = _103;
      } // if _93 else
      float _104 = _88;
      float __105 = _SA_MV_channel_array.s[_fX_s0_vi];
      float _107 = _fX_shreg;
      float _108 = __105 * _107;
      float _109 = _104 + _108;
      _MV_shreg[0][_fX_s0_vi] = _109;
      (void)_109;
      float _110;
      bool _111 = _fX_s0_vi == 0;
      bool _112 = _fX_s0_iii == 0;
      bool _113 = _111 && _112;
      if (_113)
      {
       float _114 = float_from_bits(0 /* 0 */);
       _110 = _114;
      } // if _113
      else
      {
       float _116 = _MV_shreg[0][_fX_s0_vi];
       _110 = _116;
      } // if _113 else
      float _117 = _110;
      _RightOut_DRightOut_channel_array.s[_fX_s0_vi] = _117;
      (void)_fX_s0_vi;
      bool _118 = _fX_s0_vi == 0;
      bool _119 = _fX_s0_iii == 0;
      bool _120 = _118 && _119;
      if (_120)
      {
       float _122 = _MV_shreg[0][0];
       _TopOut_DTopOut_channel_array.s = _122;
       (void)_122;
      } // if _120
     } // for _fX_s0_vi
     bool _123 = _fX_s0_kkk == 8191;
     if (_123)
     {
      write_channel_intel(_RightOut_DRightOut_channel, _RightOut_DRightOut_channel_array);
      (void)_RightOut_DRightOut_channel_array;
     } // if _123
    } // for _fX_s0_iii
    write_channel_intel(_TopOut_DTopOut_channel, _TopOut_DTopOut_channel_array);
    (void)_TopOut_DTopOut_channel_array;
   } // for _fX_s0_kkk
  } // for _fX_s0_i
 } // for _fX_s0_k
} // kernel kernel_TopOut
// Address spaces for kernel_DRightOut
#define __address_space__DRightOut __global
__kernel void kernel_DRightOut(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__DRightOut float *restrict _DRightOut)
{
 _cga _RightOut_DRightOut_channel_array;
 int _124 = _A_extent_1 >> 13;
 for (int _DRightOut_s0_k = 0; _DRightOut_s0_k < 0 + _124; _DRightOut_s0_k++)
 {
  int _125 = _A_extent_0 >> 12;
  for (int _DRightOut_s0_i = 0; _DRightOut_s0_i < 0 + _125; _DRightOut_s0_i++)
  {
   for (int _DRightOut_s0_iii = 0; _DRightOut_s0_iii < 0 + 64; _DRightOut_s0_iii++)
   {
    _cga __126 = read_channel_intel(_RightOut_DRightOut_channel);
    _RightOut_DRightOut_channel_array = __126;
    (void)__126;
    for (int _DRightOut_s0_vi = 0; _DRightOut_s0_vi < 0 + 64; _DRightOut_s0_vi++)
    {
     float __127 = _RightOut_DRightOut_channel_array.s[_DRightOut_s0_vi];
     int _128 = _A_extent_0 >> 12;
     int _129 = _128 * _DRightOut_s0_k;
     int _130 = _129 * 4096;
     int _131 = _DRightOut_s0_i * 4096;
     int _132 = _DRightOut_s0_iii * 64;
     int _133 = _132 + _DRightOut_s0_vi;
     int _134 = _131 + _133;
     int _135 = _130 + _134;
     _DRightOut[_135] = __127;
    } // for _DRightOut_s0_vi
   } // for _DRightOut_s0_iii
  } // for _DRightOut_s0_i
 } // for _DRightOut_s0_k
} // kernel kernel_DRightOut
#undef __address_space__DRightOut
// Address spaces for kernel_DTopOut
#define __address_space__DTopOut __global
__kernel void kernel_DTopOut(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__DTopOut float *restrict _DTopOut)
{
 _cga__1 _TopOut_DTopOut_channel_array;
 int _136 = _A_extent_1 >> 13;
 for (int _DTopOut_s0_k = 0; _DTopOut_s0_k < 0 + _136; _DTopOut_s0_k++)
 {
  int _137 = _A_extent_0 >> 12;
  for (int _DTopOut_s0_i = 0; _DTopOut_s0_i < 0 + _137; _DTopOut_s0_i++)
  {
   for (int _DTopOut_s0_kkk = 0; _DTopOut_s0_kkk < 0 + 8192; _DTopOut_s0_kkk++)
   {
    _cga__1 __138 = read_channel_intel(_TopOut_DTopOut_channel);
    _TopOut_DTopOut_channel_array = __138;
    (void)__138;
    int _139 = _A_extent_0 >> 12;
    int _140 = _139 * _DTopOut_s0_k;
    int _141 = _140 * 8192;
    int _142 = _DTopOut_s0_i * 8192;
    int _143 = _142 + _DTopOut_s0_kkk;
    int _144 = _141 + _143;
    _DTopOut[_144] = _TopOut_DTopOut_channel_array.s;
   } // for _DTopOut_s0_kkk
  } // for _DTopOut_s0_i
 } // for _DTopOut_s0_k
} // kernel kernel_DTopOut
#undef __address_space__DTopOut

