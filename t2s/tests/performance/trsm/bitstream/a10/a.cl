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
typedef struct { float s[16]; } _cga;
typedef struct { float s[56]; } _cga__1;
channel _cga _aLoader_uA_channel __attribute__((depth(256))) ;
channel _cga__1 _bLoader_uX_channel __attribute__((depth(256))) ;
channel _cga__1 _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#if 268435456 <= MAX_CONSTANT_BUFFER_SIZE && 0 < MAX_CONSTANT_ARGS
#define __address_space__A_serializer_mem_channel __constant
#else
#define __address_space__A_serializer_mem_channel __global
#endif
__kernel void kernel_aLoader(
 const int _B_extent_0,
 __address_space__A_serializer_mem_channel const float *restrict _A_serializer_mem_channel)
{
 _cga _aLoader_uA_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _B_extent_0 / 56;
 for (int _aLoader_s0_j = 0; _aLoader_s0_j < 0 + _0; _aLoader_s0_j++)
 {
  for (int _aLoader_s0_k_i = 0; _aLoader_s0_k_i < 0 + 4194304; _aLoader_s0_k_i++)
  {
   #pragma unroll
   for (int _aLoader_s0_jj = 0; _aLoader_s0_jj < 0 + 56; _aLoader_s0_jj++)
   {
    #pragma unroll
    for (int _aLoader_s0_ii = 0; _aLoader_s0_ii < 0 + 16; _aLoader_s0_ii++)
    {
     bool _1 = _aLoader_s0_jj == 0;
     if (_1)
     {
      int _2 = _addr_temp;
      int _3 = _2 & 67108863;
      float _4 = _A_serializer_mem_channel[_3];
      _aLoader_uA_channel_array.s[_aLoader_s0_ii] = _4;
      (void)_aLoader_s0_ii;
      int _5 = _2 + 1;
      _addr_temp = _5;
     } // if _1
    } // for _aLoader_s0_ii
   } // for _aLoader_s0_jj
   write_channel_intel(_aLoader_uA_channel, _aLoader_uA_channel_array);
   (void)_aLoader_uA_channel_array;
  } // for _aLoader_s0_k_i
 } // for _aLoader_s0_j
} // kernel kernel_aLoader
#undef __address_space__A_serializer_mem_channel
// Address spaces for kernel_bLoader
#define __address_space__B_serializer_mem_channel __global
__kernel void kernel_bLoader(
 const int _B_extent_0,
 __address_space__B_serializer_mem_channel const float *restrict _B_serializer_mem_channel)
{
 _cga__1 _bLoader_uX_channel_array;
 int _6 = _B_extent_0 / 56;
 for (int _bLoader_s0_j = 0; _bLoader_s0_j < 0 + _6; _bLoader_s0_j++)
 {
  for (int _bLoader_s0_k = 0; _bLoader_s0_k < 0 + 8192; _bLoader_s0_k++)
  {
   for (int _bLoader_s0_i = 0; _bLoader_s0_i < 0 + 512; _bLoader_s0_i++)
   {
    #pragma unroll
    for (int _bLoader_s0_jj = 0; _bLoader_s0_jj < 0 + 56; _bLoader_s0_jj++)
    {
     #pragma unroll
     for (int _bLoader_s0_ii = 0; _bLoader_s0_ii < 0 + 16; _bLoader_s0_ii++)
     {
      bool _7 = _bLoader_s0_i == 0;
      bool _8 = _bLoader_s0_ii == 0;
      bool _9 = _7 && _8;
      if (_9)
      {
       float _11 = _B_serializer_mem_channel[_bLoader_s0_jj + 56*_bLoader_s0_k + 56*8192*_bLoader_s0_j];
       _bLoader_uX_channel_array.s[_bLoader_s0_jj] = _11;
       (void)_bLoader_s0_jj;
      } // if _9
     } // for _bLoader_s0_ii
    } // for _bLoader_s0_jj
   } // for _bLoader_s0_i
   write_channel_intel(_bLoader_uX_channel, _bLoader_uX_channel_array);
   (void)_bLoader_uX_channel_array;
  } // for _bLoader_s0_k
 } // for _bLoader_s0_j
} // kernel kernel_bLoader
#undef __address_space__B_serializer_mem_channel
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _B_extent_0)
{
 // produce uY
 float _uY_shreg[513][16][56];
 // produce uX
 float _uX_shreg[16][56];
 // produce uA
 float _uA_shreg[16];
 _cga__1 _Out_unloader_channel_array;
 _cga__1 _bLoader_uX_channel_array;
 _cga _aLoader_uA_channel_array;
 int _13 = _B_extent_0 / 56;
 for (int _uA_s0_j = 0; _uA_s0_j < 0 + _13; _uA_s0_j++)
 {
  for (int _uA_s0_k = 0; _uA_s0_k < 0 + 8192; _uA_s0_k++)
  {
   _cga__1 __14 = read_channel_intel(_bLoader_uX_channel);
   _bLoader_uX_channel_array = __14;
   (void)__14;
   for (int _uA_s0_i = 0; _uA_s0_i < 0 + 512; _uA_s0_i++)
   {
    #pragma unroll
    for (int _dummy__1_s0_jj = 0; _dummy__1_s0_jj < 0 + 56; _dummy__1_s0_jj++)
    {
     #pragma unroll
     for (int _dummy_s0_ii = 0; _dummy_s0_ii < 0 + 16; _dummy_s0_ii++)
     {
      #pragma unroll
      for (int _dummy__2_s0_l0 = 0; _dummy__2_s0_l0 < 0 + 512; _dummy__2_s0_l0++)
      {
       int _15 = 512 - _dummy__2_s0_l0;
       int _16 = 511 - _dummy__2_s0_l0;
       float _18 = _uY_shreg[_16][_dummy_s0_ii][_dummy__1_s0_jj];
       _uY_shreg[_15][_dummy_s0_ii][_dummy__1_s0_jj] = _18;
       (void)_18;
      } // for _dummy__2_s0_l0
     } // for _dummy_s0_ii
    } // for _dummy__1_s0_jj
    _cga __19 = read_channel_intel(_aLoader_uA_channel);
    _aLoader_uA_channel_array = __19;
    (void)__19;
    #pragma unroll
    for (int _uA_s0_jj = 0; _uA_s0_jj < 0 + 56; _uA_s0_jj++)
    {
     #pragma unroll
     for (int _uA_s0_ii = 0; _uA_s0_ii < 0 + 16; _uA_s0_ii++)
     {
      float _20;
      bool _21 = _uA_s0_jj == 0;
      if (_21)
      {
       float __22 = _aLoader_uA_channel_array.s[_uA_s0_ii];
       _20 = __22;
      } // if _21
      else
      {
       float _24 = _uA_shreg[_uA_s0_ii];
       _20 = _24;
      } // if _21 else
      float _25 = _20;
      _uA_shreg[_uA_s0_ii] = _25;
      (void)_25;
      float _27 = _uA_shreg[_uA_s0_ii];
      float _28 = __fpga_reg(__fpga_reg(_27));
      _uA_shreg[_uA_s0_ii] = _28;
      (void)_28;
      float _29;
      bool _30 = _uA_s0_i == 0;
      if (_30)
      {
       float _31;
       bool _32 = _uA_s0_ii == 0;
       if (_32)
       {
        float __33 = _bLoader_uX_channel_array.s[_uA_s0_jj];
        float _34;
        bool _35 = _uA_s0_k == 0;
        if (_35)
        {
         float _36 = float_from_bits(0 /* 0 */);
         _34 = _36;
        } // if _35
        else
        {
         int _37 = _uA_s0_ii + 1;
         float _39 = _uY_shreg[512][_37][_uA_s0_jj];
         _34 = _39;
        } // if _35 else
        float _40 = _34;
        float _41 = __33 - _40;
        float _43 = _uA_shreg[_uA_s0_ii];
        float _44 = _41 / _43;
        _31 = _44;
       } // if _32
       else
       {
        int _45 = _uA_s0_ii + -1;
        float _47 = _uX_shreg[_45][_uA_s0_jj];
        _31 = _47;
       } // if _32 else
       float _48 = _31;
       _29 = _48;
      } // if _30
      else
      {
       float _50 = _uX_shreg[_uA_s0_ii][_uA_s0_jj];
       _29 = _50;
      } // if _30 else
      float _51 = _29;
      _uX_shreg[_uA_s0_ii][_uA_s0_jj] = _51;
      (void)_51;
      float _52;
      bool _53 = _uA_s0_k == 0;
      if (_53)
      {
       float _54 = float_from_bits(0 /* 0 */);
       _52 = _54;
      } // if _53
      else
      {
       float _55;
       bool _56 = _uA_s0_ii == 15;
       if (_56)
       {
        float _57;
        bool _58 = _uA_s0_i == 511;
        if (_58)
        {
         float _59 = float_from_bits(0 /* 0 */);
         _57 = _59;
        } // if _58
        else
        {
         int _60 = _uA_s0_ii + -15;
         float _62 = _uY_shreg[511][_60][_uA_s0_jj];
         _57 = _62;
        } // if _58 else
        float _63 = _57;
        _55 = _63;
       } // if _56
       else
       {
        int _64 = _uA_s0_ii + 1;
        float _66 = _uY_shreg[512][_64][_uA_s0_jj];
        _55 = _66;
       } // if _56 else
       float _67 = _55;
       _52 = _67;
      } // if _53 else
      float _68 = _52;
      float _70 = _uA_shreg[_uA_s0_ii];
      float _72 = _uX_shreg[_uA_s0_ii][_uA_s0_jj];
      float _73 = _70 * _72;
      float _74 = _68 + _73;
      _uY_shreg[0][_uA_s0_ii][_uA_s0_jj] = _74;
      (void)_74;
      bool _75 = _uA_s0_ii == 15;
      bool _76 = _uA_s0_i == 511;
      bool _77 = _75 && _76;
      if (_77)
      {
       float _79 = _uX_shreg[15][_uA_s0_jj];
       _Out_unloader_channel_array.s[_uA_s0_jj] = _79;
       (void)_uA_s0_jj;
      } // if _77
     } // for _uA_s0_ii
    } // for _uA_s0_jj
   } // for _uA_s0_i
   write_channel_intel(_Out_unloader_channel, _Out_unloader_channel_array);
   (void)_Out_unloader_channel_array;
  } // for _uA_s0_k
 } // for _uA_s0_j
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _B_extent_0,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 _cga__1 _Out_unloader_channel_array;
 int _addr_temp;
 _addr_temp = 0;
 int _80 = _B_extent_0 / 56;
 for (int _unloader_s0_j = 0; _unloader_s0_j < 0 + _80; _unloader_s0_j++)
 {
  for (int _unloader_s0_k = 0; _unloader_s0_k < 0 + 8192; _unloader_s0_k++)
  {
   _cga__1 __81 = read_channel_intel(_Out_unloader_channel);
   _Out_unloader_channel_array = __81;
   (void)__81;
   for (int _unloader_s0_jj = 0; _unloader_s0_jj < 0 + 56; _unloader_s0_jj++)
   {
    float __82 = _Out_unloader_channel_array.s[_unloader_s0_jj];
    int _83 = _addr_temp;
    _unloader_mem_channel[_83] = __82;
    int _84 = _addr_temp;
    int _85 = _84 + 1;
    _addr_temp = _85;
   } // for _unloader_s0_jj
  } // for _unloader_s0_k
 } // for _unloader_s0_j
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

