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
channel _cga _DA_SA_channel __attribute__((depth(256))) ;
channel _cga _SA_MV_channel __attribute__((depth(256))) ;
channel float _DX_SX_channel __attribute__((depth(256))) ;
channel _cga__1 _SX_fX_channel __attribute__((depth(256))) ;
channel _cga__1 _TopOut_DTopOut_channel __attribute__((depth(256))) ;
channel _cga _RightOut_DRightOut_channel __attribute__((depth(256))) ;
// Address spaces for kernel_DA
#define __address_space__A_fX_serializer_c0_mem_channel __global
#define __address_space__A_fX_serializer_c1_mem_channel __global
__kernel void kernel_DA(
 const int _A_extent_0,
 const int _A_extent_1,
 __address_space__A_fX_serializer_c0_mem_channel const float *restrict _A_fX_serializer_c0_mem_channel,
 __address_space__A_fX_serializer_c1_mem_channel const float *restrict _A_fX_serializer_c1_mem_channel)
{
 _cga _DA_SA_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_1 >> 13;
 for (int _DA_s0_k = 0; _DA_s0_k < 0 + _0; _DA_s0_k++)
 {
  int _1 = _A_extent_0 >> 11;
  for (int _DA_s0_i = 0; _DA_s0_i < 0 + _1; _DA_s0_i++)
  {
   for (int _DA_s0_kkk_iii = 0; _DA_s0_kkk_iii < 0 + 524288; _DA_s0_kkk_iii++)
   {
    float _DA_temp[32];
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
     int _8 = _7 + 1;
     _addr_temp = _8;
    } // for _DA_s0_vi_t
    #pragma unroll
    for (int _DA_s0_vi = 0; _DA_s0_vi < 0 + 32; _DA_s0_vi++)
    {
     float _9 = _DA_temp[_DA_s0_vi];
     _DA_SA_channel_array.s[_DA_s0_vi] = _9;
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
// Address spaces for kernel_SA
__kernel void kernel_SA(
 const int _A_extent_0,
 const int _A_extent_1)
{
 _cga _DA_SA_channel_array;
 _cga _SA_MV_channel_array;
 int _10 = _A_extent_1 >> 13;
 for (int _SA_s0_k = 0; _SA_s0_k < 0 + _10; _SA_s0_k++)
 {
  int _11 = _A_extent_0 >> 11;
  for (int _SA_s0_i = 0; _SA_s0_i < 0 + _11; _SA_s0_i++)
  {
   for (int _SA_s0_kkk_iii = 0; _SA_s0_kkk_iii < 0 + 524288; _SA_s0_kkk_iii++)
   {
    _cga __12 = read_channel_intel(_DA_SA_channel);
    _DA_SA_channel_array = __12;
    (void)__12;
    #pragma unroll
    for (int _SA_s0_vi = 0; _SA_s0_vi < 0 + 32; _SA_s0_vi++)
    {
     float __13 = _DA_SA_channel_array.s[_SA_s0_vi];
     _SA_MV_channel_array.s[_SA_s0_vi] = __13;
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
 int _14 = _A_extent_1 >> 13;
 for (int _DX_s0_k = 0; _DX_s0_k < 0 + _14; _DX_s0_k++)
 {
  int _15 = _A_extent_0 >> 11;
  for (int _DX_s0_i = 0; _DX_s0_i < 0 + _15; _DX_s0_i++)
  {
   for (int _DX_s0_kkk = 0; _DX_s0_kkk < 0 + 8192; _DX_s0_kkk++)
   {
    int _16 = _addr_temp;
    int _17 = _A_extent_0 >> 11;
    int _18 = _17 * 8192;
    int _19 = _16 / _18;
    int _20 = _19 * 8192;
    int _21 = _16 & 8191;
    int _22 = _20 + _21;
    float _23 = _X_fX_serializer_mem_channel[_22];
    write_channel_intel(_DX_SX_channel, _23);
    (void)_23;
    int _24 = _16 + 1;
    _addr_temp = _24;
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
 int _25 = _A_extent_1 >> 13;
 int _26 = _A_extent_0 >> 11;
 int _27 = _25 * _26;
 int _SX_cycle_temp;
 float __attribute__((memory, numbanks(1), singlepump)) _SX_DB_0_ibuffer[2][8192];
 _SX_cycle_temp = 516096;
 int _28 = _A_extent_1 >> 13;
 int _29 = _A_extent_0 >> 11;
 int _30 = _28 * _29;
 int _31 = _30 * 524288;
 int _32 = _31 + 524288;
 for (int _SX_s0_outermost_loop = 0; _SX_s0_outermost_loop < 0 + _32; _SX_s0_outermost_loop++)
 {
  int _33 = _SX_cycle_temp;
  int _34 = _33 & 524287;
  bool _35 = 516096 <= _34;
  int _36 = _33 >> 19;
  bool _37 = _36 < _27;
  bool _38 = _35 && _37;
  if (_38)
  {
   float __39 = read_channel_intel(_DX_SX_channel);
   int _40 = _SX_cycle_temp;
   int _41 = _40 >> 19;
   int _42 = _41 & 1;
   bool _43 = (bool)(_42);
   int _44 = _40 & 524287;
   int _45 = _44 & 8191;
   _SX_DB_0_ibuffer[_43][_45] = __39;
  } // if _38
  int _46 = _SX_cycle_temp;
  int _47 = _46 >> 19;
  bool _48 = _47 <= _27;
  bool _49 = 524287 < _46;
  bool _50 = _48 && _49;
  if (_50)
  {
   int _51 = _SX_cycle_temp;
   int _52 = _51 >> 19;
   int _53 = _52 & 1;
   bool _54 = (bool)(_53);
   bool _55 = !(_54);
   int _56 = _51 >> 6;
   int _57 = _56 & 8191;
   float _58 = _SX_DB_0_ibuffer[_55][_57];
   _SX_fX_channel_array.s = _58;
   (void)_58;
  } // if _50
  int _59 = _SX_cycle_temp;
  int _60 = _59 >> 19;
  bool _61 = _60 <= _27;
  bool _62 = 524287 < _59;
  bool _63 = _61 && _62;
  if (_63)
  {
   write_channel_intel(_SX_fX_channel, _SX_fX_channel_array);
   (void)_SX_fX_channel_array;
  } // if _63
  int _64 = _SX_cycle_temp;
  int _65 = _64 + 1;
  _SX_cycle_temp = _65;
 } // for _SX_s0_outermost_loop
} // kernel kernel_SX
// Address spaces for kernel_TopOut
__kernel void kernel_TopOut(
 const int _A_extent_0,
 const int _A_extent_1)
{
 // produce RightOut
 // produce MV
 float _MV_shreg[65][32];
 // produce fX
 float _fX_shreg;
 _cga__1 _TopOut_DTopOut_channel_array;
 _cga _RightOut_DRightOut_channel_array;
 _cga _SA_MV_channel_array;
 _cga__1 _SX_fX_channel_array;
 int _66 = _A_extent_1 >> 13;
 for (int _fX_s0_k = 0; _fX_s0_k < 0 + _66; _fX_s0_k++)
 {
  int _67 = _A_extent_0 >> 11;
  for (int _fX_s0_i = 0; _fX_s0_i < 0 + _67; _fX_s0_i++)
  {
   for (int _fX_s0_kkk = 0; _fX_s0_kkk < 0 + 8192; _fX_s0_kkk++)
   {
    for (int _fX_s0_iii = 0; _fX_s0_iii < 0 + 64; _fX_s0_iii++)
    {
     #pragma unroll
     for (int _dummy_s0_vi = 0; _dummy_s0_vi < 0 + 32; _dummy_s0_vi++)
     {
      #pragma unroll
      for (int _dummy__1_s0_l0 = 0; _dummy__1_s0_l0 < 0 + 64; _dummy__1_s0_l0++)
      {
       int _68 = 64 - _dummy__1_s0_l0;
       int _69 = 63 - _dummy__1_s0_l0;
       float _71 = _MV_shreg[_69][_dummy_s0_vi];
       _MV_shreg[_68][_dummy_s0_vi] = _71;
       (void)_71;
      } // for _dummy__1_s0_l0
     } // for _dummy_s0_vi
     _cga __72 = read_channel_intel(_SA_MV_channel);
     _SA_MV_channel_array = __72;
     (void)__72;
     _cga__1 __73 = read_channel_intel(_SX_fX_channel);
     _SX_fX_channel_array = __73;
     (void)__73;
     #pragma unroll
     for (int _fX_s0_vi = 0; _fX_s0_vi < 0 + 32; _fX_s0_vi++)
     {
      float _74;
      bool _75 = _fX_s0_vi == 0;
      if (_75)
      {
       _74 = _SX_fX_channel_array.s;
      } // if _75
      else
      {
       float _77 = _fX_shreg;
       _74 = _77;
      } // if _75 else
      float _78 = _74;
      _fX_shreg = _78;
      (void)_78;
      float _80 = _fX_shreg;
      float _81 = __fpga_reg(__fpga_reg(_80));
      _fX_shreg = _81;
      (void)_81;
      float _82;
      bool _83 = _fX_s0_iii == 63;
      bool _84 = _fX_s0_vi == 31;
      bool _85 = _83 && _84;
      bool _86 = _fX_s0_kkk == 0;
      bool _87 = _85 || _86;
      if (_87)
      {
       float _88 = float_from_bits(0 /* 0 */);
       _82 = _88;
      } // if _87
      else
      {
       float _89;
       bool _90 = _fX_s0_vi == 31;
       if (_90)
       {
        int _91 = _fX_s0_vi + -31;
        float _93 = _MV_shreg[63][_91];
        _89 = _93;
       } // if _90
       else
       {
        int _94 = _fX_s0_vi + 1;
        float _96 = _MV_shreg[64][_94];
        _89 = _96;
       } // if _90 else
       float _97 = _89;
       _82 = _97;
      } // if _87 else
      float _98 = _82;
      float __99 = _SA_MV_channel_array.s[_fX_s0_vi];
      float _101 = _fX_shreg;
      float _102 = __99 * _101;
      float _103 = _98 + _102;
      _MV_shreg[0][_fX_s0_vi] = _103;
      (void)_103;
      float _104;
      bool _105 = _fX_s0_vi == 0;
      bool _106 = _fX_s0_iii == 0;
      bool _107 = _105 && _106;
      if (_107)
      {
       float _108 = float_from_bits(0 /* 0 */);
       _104 = _108;
      } // if _107
      else
      {
       float _110 = _MV_shreg[0][_fX_s0_vi];
       _104 = _110;
      } // if _107 else
      float _111 = _104;
      _RightOut_DRightOut_channel_array.s[_fX_s0_vi] = _111;
      (void)_fX_s0_vi;
      bool _112 = _fX_s0_vi == 0;
      bool _113 = _fX_s0_iii == 0;
      bool _114 = _112 && _113;
      if (_114)
      {
       float _116 = _MV_shreg[0][0];
       _TopOut_DTopOut_channel_array.s = _116;
       (void)_116;
      } // if _114
     } // for _fX_s0_vi
     bool _117 = _fX_s0_kkk == 8191;
     if (_117)
     {
      write_channel_intel(_RightOut_DRightOut_channel, _RightOut_DRightOut_channel_array);
      (void)_RightOut_DRightOut_channel_array;
     } // if _117
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
 int _118 = _A_extent_1 >> 13;
 for (int _DRightOut_s0_k = 0; _DRightOut_s0_k < 0 + _118; _DRightOut_s0_k++)
 {
  int _119 = _A_extent_0 >> 11;
  for (int _DRightOut_s0_i = 0; _DRightOut_s0_i < 0 + _119; _DRightOut_s0_i++)
  {
   for (int _DRightOut_s0_iii = 0; _DRightOut_s0_iii < 0 + 64; _DRightOut_s0_iii++)
   {
    _cga __120 = read_channel_intel(_RightOut_DRightOut_channel);
    _RightOut_DRightOut_channel_array = __120;
    (void)__120;
    for (int _DRightOut_s0_vi = 0; _DRightOut_s0_vi < 0 + 32; _DRightOut_s0_vi++)
    {
     float __121 = _RightOut_DRightOut_channel_array.s[_DRightOut_s0_vi];
     int _122 = _A_extent_0 >> 11;
     int _123 = _122 * _DRightOut_s0_k;
     int _124 = _123 * 2048;
     int _125 = _DRightOut_s0_i * 2048;
     int _126 = _DRightOut_s0_iii * 32;
     int _127 = _126 + _DRightOut_s0_vi;
     int _128 = _125 + _127;
     int _129 = _124 + _128;
     _DRightOut[_129] = __121;
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
 int _130 = _A_extent_1 >> 13;
 for (int _DTopOut_s0_k = 0; _DTopOut_s0_k < 0 + _130; _DTopOut_s0_k++)
 {
  int _131 = _A_extent_0 >> 11;
  for (int _DTopOut_s0_i = 0; _DTopOut_s0_i < 0 + _131; _DTopOut_s0_i++)
  {
   for (int _DTopOut_s0_kkk = 0; _DTopOut_s0_kkk < 0 + 8192; _DTopOut_s0_kkk++)
   {
    _cga__1 __132 = read_channel_intel(_TopOut_DTopOut_channel);
    _TopOut_DTopOut_channel_array = __132;
    (void)__132;
    int _133 = _A_extent_0 >> 11;
    int _134 = _133 * _DTopOut_s0_k;
    int _135 = _134 * 8192;
    int _136 = _DTopOut_s0_i * 8192;
    int _137 = _136 + _DTopOut_s0_kkk;
    int _138 = _135 + _137;
    _DTopOut[_138] = _TopOut_DTopOut_channel_array.s;
   } // for _DTopOut_s0_kkk
  } // for _DTopOut_s0_i
 } // for _DTopOut_s0_k
} // kernel kernel_DTopOut
#undef __address_space__DTopOut

