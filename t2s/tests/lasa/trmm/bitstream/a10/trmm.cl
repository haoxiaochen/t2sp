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
bool __attribute__ ((aligned(16))) s[16];
struct {bool s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7,  s8,  s9,  sa,  sb,  sc,  sd,  se,  sf;};
} bool16;
typedef union {
bool __attribute__ ((aligned(8))) s[8];
struct {bool s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7;};
} bool8;
typedef struct { float16 s[8]; } _cga;
channel float16 _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga _aFeeder_X_channel __attribute__((depth(256))) ;
channel float16 _bLoader_bFeeder_channel __attribute__((depth(256))) ;
channel _cga _bFeeder_Y_channel __attribute__((depth(256))) ;
channel float8 _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_serializer_mem_channel const float *restrict _A_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _A_extent_1 >> 7;
 int _1 = _0 + 1;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _1; _aLoader_s0_i++)
 {
  int _2 = _B_extent_0 >> 7;
  for (int _aLoader_s0_j = 0; _aLoader_s0_j < 0 + _2; _aLoader_s0_j++)
  {
   int _3 = _A_extent_1 >> 7;
   int _4 = _aLoader_s0_i / _3;
   int _5 = _A_extent_0 >> 7;
   int _6 = _5 - _aLoader_s0_i;
   int _7 = _4 + _6;
   for (int _aLoader_s0_k = _aLoader_s0_i; _aLoader_s0_k < _aLoader_s0_i + _7; _aLoader_s0_k++)
   {
    for (int _aLoader_s0_kk_ii_iii = 0; _aLoader_s0_kk_ii_iii < 0 + 1024; _aLoader_s0_kk_ii_iii++)
    {
     bool _8 = _aLoader_s0_j == 0;
     bool _9 = _aLoader_s0_k == _aLoader_s0_i;
     bool _10 = _8 && _9;
     int _11 = _A_extent_1 >> 7;
     bool _12 = _aLoader_s0_i < _11;
     bool _13 = _10 || _12;
     if (_13)
     {
      float16 _14;
      int _15 = _A_extent_1 >> 7;
      bool _16 = _aLoader_s0_i < _15;
      if (_16)
      {
       int _17 = _A_extent_1 >> 7;
       int _18 = _aLoader_s0_i / _17;
       int _19 = _A_extent_0 >> 7;
       int _20 = _18 + _19;
       int _21 = _20 * 2;
       int _22 = _21 - _aLoader_s0_i;
       int _23 = _22 + 1;
       int _24 = _23 * _aLoader_s0_i;
       int _25 = _24 >> 1;
       int _26 = _aLoader_s0_k - _aLoader_s0_i;
       int _27 = _25 + _26;
       int _28 = _27 * 1024;
       int _29 = _addr_temp;
       int _30 = _29 & 1023;
       int _31 = _28 + _30;
       int _32 = _31 * 16;
       float16 _33 = vload16(0, (__address_space__A_serializer_mem_channel float*)_A_serializer_mem_channel + _32);
       _14 = _33;
      } // if _16
      else
      {
       float _34 = float_from_bits(0 /* 0 */);
       float16 _35 = _34;
       _14 = _35;
      } // if _16 else
      float16 _36 = _14;
      write_channel_intel(_aLoader_aFeeder_channel, _36);
      (void)_36;
     } // if _13
     int _37 = _addr_temp;
     int _38 = _37 + 1;
     _addr_temp = _38;
    } // for _aLoader_s0_kk_ii_iii
   } // for _aLoader_s0_k
  } // for _aLoader_s0_j
 } // for _aLoader_s0_i
} // kernel kernel_aLoader
#undef __address_space__A_serializer_mem_channel
// Address spaces for kernel_aFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_aFeeder(
)
{
 _cga _aFeeder_X_channel_array;
 float16 _aFeeder_value_shreg;
 uint _aFeeder_time_stamp_shreg;
 float16 _aFeeder_in_v_temp;
 uint _aFeeder_cycle_temp;
 float16 __attribute__((memory, numbanks(8), singlepump)) _aFeeder_DB_0_ibuffer[2][8][16][8];
 #pragma unroll
 for (int _aFeeder_s0_jjj_init = 0; _aFeeder_s0_jjj_init < 0 + 8; _aFeeder_s0_jjj_init++)
 {
  bool _39 = _aFeeder_s0_jjj_init == 0;
  if (_39)
  {
   uint _40 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   _aFeeder_cycle_temp = _40;
  } // if _39
 } // for _aFeeder_s0_jjj_init
 while(1)
 {
  uint _41 = (uint)(ADD_UINT64_T_SUFFIX(1024));
  uint _42 = _aFeeder_cycle_temp;
  uint _43 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _44 = _42 & _43;
  bool _45 = _41 <= _44;
  if (_45)
  {
   float16 __46 = read_channel_intel(_aLoader_aFeeder_channel);
   _aFeeder_in_v_temp = __46;
  } // if _45
  #pragma unroll
  for (int _aFeeder_s0_buf = 0; _aFeeder_s0_buf < 0 + 8; _aFeeder_s0_buf++)
  {
   bool _47 = _aFeeder_s0_buf == 0;
   if (_47)
   {
    float16 _48 = _aFeeder_in_v_temp;
    _aFeeder_value_shreg = _48;
    (void)_48;
    uint _49 = _aFeeder_cycle_temp;
    _aFeeder_time_stamp_shreg = _49;
    (void)_49;
   } // if _47
   else
   {
    float16 _51 = _aFeeder_value_shreg;
    _aFeeder_value_shreg = _51;
    (void)_51;
    uint _53 = _aFeeder_time_stamp_shreg;
    _aFeeder_time_stamp_shreg = _53;
    (void)_53;
   } // if _47 else
   float16 _55 = _aFeeder_value_shreg;
   float16 _56 = __fpga_reg(__fpga_reg(_55));
   _aFeeder_value_shreg = _56;
   (void)_56;
   uint _58 = _aFeeder_time_stamp_shreg;
   uint _59 = __fpga_reg(__fpga_reg(_58));
   _aFeeder_time_stamp_shreg = _59;
   (void)_59;
   uint _60 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   uint _62 = _aFeeder_time_stamp_shreg;
   uint _63 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _64 = _62 & _63;
   bool _65 = _60 <= _64;
   if (_65)
   {
    uint _67 = _aFeeder_time_stamp_shreg;
    uint _68 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _69 = _67 & _68;
    uint _70 = (uint)(ADD_UINT64_T_SUFFIX(1024));
    uint _71 = _69 - _70;
    uint _72 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _73 = _71 & _72;
    int _74 = (int)(_73);
    bool _75 = _aFeeder_s0_buf == _74;
    if (_75)
    {
     float16 _77 = _aFeeder_value_shreg;
     uint _79 = _aFeeder_time_stamp_shreg;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _81 = _79 >> _80;
     uint _82 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _83 = _81 & _82;
     bool _84 = (bool)(_83);
     uint _86 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _87 = _79 & _86;
     uint _88 = (uint)(ADD_UINT64_T_SUFFIX(1024));
     uint _89 = _87 - _88;
     int _90 = (int)(_89);
     int _91 = _90 >> 7;
     int _93 = _90 >> 3;
     int _94 = _93 & 15;
     _aFeeder_DB_0_ibuffer[_84][_91][_94][_aFeeder_s0_buf] = _77;
    } // if _75
   } // if _65
   uint _95 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _97 = _aFeeder_time_stamp_shreg;
   uint _98 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _99 = _97 >> _98;
   bool _100 = _95 < _99;
   if (_100)
   {
    uint _102 = _aFeeder_time_stamp_shreg;
    uint _103 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _104 = _102 >> _103;
    uint _105 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _106 = _104 & _105;
    bool _107 = (bool)(_106);
    bool _108 = !(_107);
    uint _110 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _111 = _102 & _110;
    int _112 = (int)(_111);
    int _113 = _112 >> 8;
    int _115 = _112 >> 4;
    int _116 = _115 & 15;
    float16 _117 = _aFeeder_DB_0_ibuffer[_108][_113][_116][_aFeeder_s0_buf];
    _aFeeder_X_channel_array.s[_aFeeder_s0_buf] = _117;
    (void)_aFeeder_s0_buf;
   } // if _100
  } // for _aFeeder_s0_buf
  uint _118 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _120 = _aFeeder_time_stamp_shreg;
  uint _121 = (uint)(ADD_UINT64_T_SUFFIX(11));
  uint _122 = _120 >> _121;
  bool _123 = _118 < _122;
  if (_123)
  {
   write_channel_intel(_aFeeder_X_channel, _aFeeder_X_channel_array);
   (void)_aFeeder_X_channel_array;
  } // if _123
  uint _124 = _aFeeder_cycle_temp;
  uint _125 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _126 = _124 + _125;
  _aFeeder_cycle_temp = _126;
 } // while _aFeeder_s0_outermost_loop_infinite
} // kernel kernel_aFeeder
// Address spaces for kernel_bLoader
#define __address_space__B_serializer_mem_channel __global
__kernel void kernel_bLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__B_serializer_mem_channel const float *restrict _B_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _127 = _A_extent_1 >> 7;
 int _128 = _127 + 1;
 for (int _bLoader_s0_i = 0; _bLoader_s0_i < 0 + _128; _bLoader_s0_i++)
 {
  int _129 = _B_extent_0 >> 7;
  for (int _bLoader_s0_j = 0; _bLoader_s0_j < 0 + _129; _bLoader_s0_j++)
  {
   int _130 = _A_extent_1 >> 7;
   int _131 = _bLoader_s0_i / _130;
   int _132 = _A_extent_0 >> 7;
   int _133 = _132 - _bLoader_s0_i;
   int _134 = _131 + _133;
   for (int _bLoader_s0_k = _bLoader_s0_i; _bLoader_s0_k < _bLoader_s0_i + _134; _bLoader_s0_k++)
   {
    for (int _bLoader_s0_kk_jj_jjj = 0; _bLoader_s0_kk_jj_jjj < 0 + 1024; _bLoader_s0_kk_jj_jjj++)
    {
     bool _135 = _bLoader_s0_j == 0;
     bool _136 = _bLoader_s0_k == _bLoader_s0_i;
     bool _137 = _135 && _136;
     int _138 = _A_extent_1 >> 7;
     bool _139 = _bLoader_s0_i < _138;
     bool _140 = _137 || _139;
     if (_140)
     {
      float16 _141;
      int _142 = _A_extent_1 >> 7;
      bool _143 = _bLoader_s0_i < _142;
      if (_143)
      {
       int _144 = _A_extent_1 >> 7;
       int _145 = _bLoader_s0_i / _144;
       int _146 = _A_extent_0 >> 7;
       int _147 = _145 + _146;
       int _148 = _147 * _bLoader_s0_j;
       int _149 = _148 * 1024;
       int _150 = _bLoader_s0_k * 1024;
       int _151 = _addr_temp;
       int _152 = _151 & 1023;
       int _153 = _150 + _152;
       int _154 = _149 + _153;
       int _155 = _154 * 16;
       float16 _156 = vload16(0, (__address_space__B_serializer_mem_channel float*)_B_serializer_mem_channel + _155);
       _141 = _156;
      } // if _143
      else
      {
       float _157 = float_from_bits(0 /* 0 */);
       float16 _158 = _157;
       _141 = _158;
      } // if _143 else
      float16 _159 = _141;
      write_channel_intel(_bLoader_bFeeder_channel, _159);
      (void)_159;
     } // if _140
     int _160 = _addr_temp;
     int _161 = _160 + 1;
     _addr_temp = _161;
    } // for _bLoader_s0_kk_jj_jjj
   } // for _bLoader_s0_k
  } // for _bLoader_s0_j
 } // for _bLoader_s0_i
} // kernel kernel_bLoader
#undef __address_space__B_serializer_mem_channel
// Address spaces for kernel_bFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_bFeeder(
)
{
 _cga _bFeeder_Y_channel_array;
 float16 _bFeeder_value_shreg;
 uint _bFeeder_time_stamp_shreg;
 float16 _bFeeder_in_v_temp;
 uint _bFeeder_cycle_temp;
 float16 __attribute__((memory, numbanks(8), singlepump)) _bFeeder_DB_0_ibuffer[2][8][16][8];
 #pragma unroll
 for (int _bFeeder_s0_iii_init = 0; _bFeeder_s0_iii_init < 0 + 8; _bFeeder_s0_iii_init++)
 {
  bool _162 = _bFeeder_s0_iii_init == 0;
  if (_162)
  {
   uint _163 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   _bFeeder_cycle_temp = _163;
  } // if _162
 } // for _bFeeder_s0_iii_init
 while(1)
 {
  uint _164 = (uint)(ADD_UINT64_T_SUFFIX(1024));
  uint _165 = _bFeeder_cycle_temp;
  uint _166 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _167 = _165 & _166;
  bool _168 = _164 <= _167;
  if (_168)
  {
   float16 __169 = read_channel_intel(_bLoader_bFeeder_channel);
   _bFeeder_in_v_temp = __169;
  } // if _168
  #pragma unroll
  for (int _bFeeder_s0_buf = 0; _bFeeder_s0_buf < 0 + 8; _bFeeder_s0_buf++)
  {
   bool _170 = _bFeeder_s0_buf == 0;
   if (_170)
   {
    float16 _171 = _bFeeder_in_v_temp;
    _bFeeder_value_shreg = _171;
    (void)_171;
    uint _172 = _bFeeder_cycle_temp;
    _bFeeder_time_stamp_shreg = _172;
    (void)_172;
   } // if _170
   else
   {
    float16 _174 = _bFeeder_value_shreg;
    _bFeeder_value_shreg = _174;
    (void)_174;
    uint _176 = _bFeeder_time_stamp_shreg;
    _bFeeder_time_stamp_shreg = _176;
    (void)_176;
   } // if _170 else
   float16 _178 = _bFeeder_value_shreg;
   float16 _179 = __fpga_reg(__fpga_reg(_178));
   _bFeeder_value_shreg = _179;
   (void)_179;
   uint _181 = _bFeeder_time_stamp_shreg;
   uint _182 = __fpga_reg(__fpga_reg(_181));
   _bFeeder_time_stamp_shreg = _182;
   (void)_182;
   uint _183 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   uint _185 = _bFeeder_time_stamp_shreg;
   uint _186 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _187 = _185 & _186;
   bool _188 = _183 <= _187;
   if (_188)
   {
    uint _190 = _bFeeder_time_stamp_shreg;
    uint _191 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _192 = _190 & _191;
    uint _193 = (uint)(ADD_UINT64_T_SUFFIX(1024));
    uint _194 = _192 - _193;
    uint _195 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _196 = _194 & _195;
    int _197 = (int)(_196);
    bool _198 = _bFeeder_s0_buf == _197;
    if (_198)
    {
     float16 _200 = _bFeeder_value_shreg;
     uint _202 = _bFeeder_time_stamp_shreg;
     uint _203 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _204 = _202 >> _203;
     uint _205 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _206 = _204 & _205;
     bool _207 = (bool)(_206);
     uint _209 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _210 = _202 & _209;
     uint _211 = (uint)(ADD_UINT64_T_SUFFIX(1024));
     uint _212 = _210 - _211;
     int _213 = (int)(_212);
     int _214 = _213 >> 7;
     int _216 = _213 >> 3;
     int _217 = _216 & 15;
     _bFeeder_DB_0_ibuffer[_207][_214][_217][_bFeeder_s0_buf] = _200;
    } // if _198
   } // if _188
   uint _218 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _220 = _bFeeder_time_stamp_shreg;
   uint _221 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _222 = _220 >> _221;
   bool _223 = _218 < _222;
   if (_223)
   {
    uint _225 = _bFeeder_time_stamp_shreg;
    uint _226 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _227 = _225 >> _226;
    uint _228 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _229 = _227 & _228;
    bool _230 = (bool)(_229);
    bool _231 = !(_230);
    uint _233 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _234 = _225 & _233;
    int _235 = (int)(_234);
    int _236 = _235 >> 8;
    int _238 = _235 & 15;
    float16 _239 = _bFeeder_DB_0_ibuffer[_231][_236][_238][_bFeeder_s0_buf];
    _bFeeder_Y_channel_array.s[_bFeeder_s0_buf] = _239;
    (void)_bFeeder_s0_buf;
   } // if _223
  } // for _bFeeder_s0_buf
  uint _240 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _242 = _bFeeder_time_stamp_shreg;
  uint _243 = (uint)(ADD_UINT64_T_SUFFIX(11));
  uint _244 = _242 >> _243;
  bool _245 = _240 < _244;
  if (_245)
  {
   write_channel_intel(_bFeeder_Y_channel, _bFeeder_Y_channel_array);
   (void)_bFeeder_Y_channel_array;
  } // if _245
  uint _246 = _bFeeder_cycle_temp;
  uint _247 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _248 = _246 + _247;
  _bFeeder_cycle_temp = _248;
 } // while _bFeeder_s0_outermost_loop_infinite
} // kernel kernel_bFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 // produce Z
 float _Z_shreg[256][8][8];
 float _Z_pipe_shreg[8][1793];
 // produce Y
 float16 _Y_shreg[8];
 float _Z_temp[8][8];
 // produce X
 float16 _X_shreg[8];
 _cga _bFeeder_Y_channel_array;
 _cga _aFeeder_X_channel_array;
 float _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 2048;
 _Z_pipe_base_temp = 0;
 int _249 = _A_extent_1 >> 7;
 int _250 = _249 + 1;
 for (int _X_s0_i = 0; _X_s0_i < 0 + _250; _X_s0_i++)
 {
  int _251 = _B_extent_0 >> 7;
  for (int _X_s0_j = 0; _X_s0_j < 0 + _251; _X_s0_j++)
  {
   int _252 = _A_extent_1 >> 7;
   int _253 = _X_s0_i / _252;
   int _254 = _A_extent_0 >> 7;
   int _255 = _254 - _X_s0_i;
   int _256 = _253 + _255;
   for (int _X_s0_k = _X_s0_i; _X_s0_k < _X_s0_i + _256; _X_s0_k++)
   {
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 2048; _X_s0_kk_ii_jj++)
    {
     #pragma unroll
     for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 8; _dummy__1_s0_iii++)
     {
      #pragma unroll
      for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 8; _dummy_s0_jjj++)
      {
       float _258 = _Z_shreg[255][_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _258;
       #pragma unroll
       for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
       {
        int _259 = 255 - _dummy__2_s0_l1;
        int _260 = 254 - _dummy__2_s0_l1;
        float _262 = _Z_shreg[_260][_dummy_s0_jjj][_dummy__1_s0_iii];
        _Z_shreg[_259][_dummy_s0_jjj][_dummy__1_s0_iii] = _262;
        (void)_262;
       } // for _dummy__2_s0_l1
       float _263 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _263;
       (void)_263;
      } // for _dummy_s0_jjj
     } // for _dummy__1_s0_iii
     int _264 = _A_extent_1 >> 7;
     bool _265 = _X_s0_i < _264;
     if (_265)
     {
      _cga __266 = read_channel_intel(_bFeeder_Y_channel);
      _bFeeder_Y_channel_array = __266;
      (void)__266;
      _cga __267 = read_channel_intel(_aFeeder_X_channel);
      _aFeeder_X_channel_array = __267;
      (void)__267;
     } // if _265
     #pragma unroll
     for (int _X_s0_iii = 0; _X_s0_iii < 0 + 8; _X_s0_iii++)
     {
      #pragma unroll
      for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 8; _X_s0_jjj++)
      {
       float16 _268;
       bool _269 = _X_s0_jjj == 0;
       if (_269)
       {
        float16 __270 = _aFeeder_X_channel_array.s[_X_s0_iii];
        _268 = __270;
       } // if _269
       else
       {
        float16 _272 = _X_shreg[_X_s0_iii];
        _268 = _272;
       } // if _269 else
       float16 _273 = _268;
       _X_shreg[_X_s0_iii] = _273;
       (void)_273;
       float16 _275 = _X_shreg[_X_s0_iii];
       float16 _276 = __fpga_reg(__fpga_reg(_275));
       _X_shreg[_X_s0_iii] = _276;
       (void)_276;
       float16 _277;
       bool _278 = _X_s0_iii == 0;
       if (_278)
       {
        float16 __279 = _bFeeder_Y_channel_array.s[_X_s0_jjj];
        _277 = __279;
       } // if _278
       else
       {
        float16 _281 = _Y_shreg[_X_s0_jjj];
        _277 = _281;
       } // if _278 else
       float16 _282 = _277;
       _Y_shreg[_X_s0_jjj] = _282;
       (void)_282;
       float16 _284 = _Y_shreg[_X_s0_jjj];
       float16 _285 = __fpga_reg(__fpga_reg(_284));
       _Y_shreg[_X_s0_jjj] = _285;
       (void)_285;
       float _286;
       bool _287 = _X_s0_k == _X_s0_i;
       int _288 = _X_s0_kk_ii_jj >> 8;
       bool _289 = _288 == 0;
       bool _290 = _287 && _289;
       if (_290)
       {
        float _291 = float_from_bits(0 /* 0 */);
        _286 = _291;
       } // if _290
       else
       {
        float _293 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
        float _294 = __fpga_reg(_293);
        _286 = _294;
       } // if _290 else
       float _295 = _286;
       _Z_shreg_temp = _295;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
       {
        float _296 = _Z_shreg_temp;
        float _298 = _X_shreg[_X_s0_iii][_X_s0_kkk];
        float _300 = _Y_shreg[_X_s0_jjj][_X_s0_kkk];
        float _301 = _298 * _300;
        float _302 = _296 + _301;
        _Z_shreg_temp = _302;
        int _303 = _X_s0_kkk & 3;
        bool _304 = _303 == 3;
        if (_304)
        {
         float _305 = _Z_shreg_temp;
         float _306 = __fpga_reg(_305);
         _Z_shreg_temp = _306;
        } // if _304
       } // for _X_s0_kkk
       float _307 = _Z_shreg_temp;
       _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _307;
       (void)_307;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
       {
        bool _308 = _X_s0_kkk == 15;
        int _309 = _X_s0_kk_ii_jj >> 8;
        bool _310 = _309 == 7;
        bool _311 = _308 && _310;
        int _312 = _A_extent_0 >> 7;
        int _313 = _312 + -1;
        bool _314 = _X_s0_k == _313;
        bool _315 = _311 && _314;
        if (_315)
        {
         int _316 = _X_s0_iii * 256;
         float _318 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
         _Z_pipe_shreg[_X_s0_jjj][_316] = _318;
         (void)_318;
        } // if _315
       } // for _X_s0_kkk
      } // for _X_s0_jjj
     } // for _X_s0_iii
     int _319 = _X_s0_kk_ii_jj & 15;
     bool _320 = _319 == 0;
     int _321 = _X_s0_kk_ii_jj & 255;
     int _322 = _321 >> 4;
     bool _323 = _322 == 0;
     bool _324 = _320 && _323;
     int _325 = _A_extent_0 >> 7;
     int _326 = _325 + -1;
     bool _327 = _X_s0_k == _326;
     bool _328 = _324 && _327;
     int _329 = _X_s0_kk_ii_jj >> 8;
     bool _330 = _329 == 7;
     bool _331 = _328 && _330;
     int _332 = _A_extent_1 >> 7;
     bool _333 = _X_s0_i < _332;
     bool _334 = _331 && _333;
     if (_334)
     {
      int _335 = _Z_pipe_iter_temp;
      _Z_pipe_base_temp = _335;
     } // if _334
     float8 _Out_unloader_channel_temp;
     #pragma unroll
     for (int _Z_pipe_b__14 = 0; _Z_pipe_b__14 < 0 + 8; _Z_pipe_b__14++)
     {
      float _337 = _Z_pipe_shreg[_Z_pipe_b__14][0];
      _Out_unloader_channel_temp[_Z_pipe_b__14] = _337;
      #pragma unroll
      for (int _Z_pipe_b__14_dummy = 0; _Z_pipe_b__14_dummy < 0 + 8; _Z_pipe_b__14_dummy++)
      {
       float _338 = _Out_unloader_channel_temp[_Z_pipe_b__14_dummy];
       float _339 = __fpga_reg(__fpga_reg(_338));
       _Out_unloader_channel_temp[_Z_pipe_b__14_dummy] = _339;
      } // for _Z_pipe_b__14_dummy
     } // for _Z_pipe_b__14
     int _340 = _Z_pipe_iter_temp;
     int _341 = _Z_pipe_base_temp;
     int _342 = _341 + 2048;
     bool _343 = _340 < _342;
     if (_343)
     {
      float8 _344 = _Out_unloader_channel_temp;
      write_channel_intel(_Out_unloader_channel, _344);
      (void)_344;
     } // if _343
     #pragma unroll
     for (int _Z_pipe_b__15 = 0; _Z_pipe_b__15 < 0 + 8; _Z_pipe_b__15++)
     {
      #pragma unroll
      for (int _Z_pipe_p__7 = 0; _Z_pipe_p__7 < 0 + 7; _Z_pipe_p__7++)
      {
       #pragma unroll
       for (int _Z_pipe_l__7 = 0; _Z_pipe_l__7 < 0 + 255; _Z_pipe_l__7++)
       {
        int _345 = _Z_pipe_p__7 * 256;
        int _346 = _345 + _Z_pipe_l__7;
        int _347 = _346 + 1;
        float _349 = _Z_pipe_shreg[_Z_pipe_b__15][_347];
        _Z_pipe_shreg[_Z_pipe_b__15][_346] = _349;
        (void)_349;
       } // for _Z_pipe_l__7
       int _350 = _Z_pipe_p__7 * 256;
       int _351 = _350 + 255;
       int _352 = _350 + 256;
       float _354 = _Z_pipe_shreg[_Z_pipe_b__15][_352];
       float _355 = __fpga_reg(__fpga_reg(_354));
       _Z_pipe_shreg[_Z_pipe_b__15][_351] = _355;
       (void)_355;
      } // for _Z_pipe_p__7
     } // for _Z_pipe_b__15
     int _356 = _Z_pipe_iter_temp;
     int _357 = _356 + 1;
     _Z_pipe_iter_temp = _357;
    } // for _X_s0_kk_ii_jj
   } // for _X_s0_k
  } // for _X_s0_j
 } // for _X_s0_i
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _358 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _358; _unloader_s0_i++)
 {
  int _359 = _B_extent_0 >> 7;
  for (int _unloader_s0_j = 0; _unloader_s0_j < 0 + _359; _unloader_s0_j++)
  {
   for (int _unloader_s0_iii_ii_jj = 0; _unloader_s0_iii_ii_jj < 0 + 2048; _unloader_s0_iii_ii_jj++)
   {
    float8 __360 = read_channel_intel(_Out_unloader_channel);
    int _361 = _addr_temp;
    int _362 = _361 * 8;
    vstore8(__360, 0, (__address_space__unloader_mem_channel float*)_unloader_mem_channel + _362);
    int _363 = _addr_temp;
    int _364 = _363 + 1;
    _addr_temp = _364;
   } // for _unloader_s0_iii_ii_jj
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

