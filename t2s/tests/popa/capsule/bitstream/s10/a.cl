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
typedef struct { float16 s[13]; } _cga;
typedef struct { float16 s[8]; } _cga__1;
channel float16 _PLoader_PFeeder_channel __attribute__((depth(256))) ;
channel _cga _PFeeder_A_channel __attribute__((depth(256))) ;
channel float16 _WLoader_WFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _WFeeder_B_channel __attribute__((depth(256))) ;
channel float8 _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_PLoader
#define __address_space__P_serializer_mem_channel __global
__kernel void kernel_PLoader(
 const int _P_extent_1,
 __address_space__P_serializer_mem_channel const float *restrict _P_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _0 = _P_extent_1 / 225;
 for (int _PLoader_s0_n = 0; _PLoader_s0_n < 0 + _0; _PLoader_s0_n++)
 {
  for (int _PLoader_s0_mk_ci_kx_ky_mx_y_x_yyy_xxx = 0; _PLoader_s0_mk_ci_kx_ky_mx_y_x_yyy_xxx < 0 + 14976; _PLoader_s0_mk_ci_kx_ky_mx_y_x_yyy_xxx++)
  {
   int _1 = _addr_temp;
   int _2 = _1 * 16;
   float16 _3 = vload16(0, (__address_space__P_serializer_mem_channel float*)_P_serializer_mem_channel + _2);
   write_channel_intel(_PLoader_PFeeder_channel, _3);
   (void)_3;
   int _4 = _1 + 1;
   _addr_temp = _4;
  } // for _PLoader_s0_mk_ci_kx_ky_mx_y_x_yyy_xxx
 } // for _PLoader_s0_n
} // kernel kernel_PLoader
#undef __address_space__P_serializer_mem_channel
// Address spaces for kernel_PFeeder
__kernel void kernel_PFeeder(
 const int _P_extent_1)
{
 _cga _PFeeder_A_channel_array;
 float16 _PFeeder_value_shreg;
 uint _PFeeder_time_stamp_shreg;
 float16 _PFeeder_in_v_temp;
 uint _PFeeder_cycle_temp;
 float16 __attribute__((memory, numbanks(16), singlepump)) _PFeeder_DB_0_ibuffer[2][3][3][4][4][16];
 #pragma unroll
 for (int _PFeeder_s0_cooo_init = 0; _PFeeder_s0_cooo_init < 0 + 8; _PFeeder_s0_cooo_init++)
 {
  bool _5 = _PFeeder_s0_cooo_init == 0;
  if (_5)
  {
   uint _6 = (uint)(ADD_UINT64_T_SUFFIX(432));
   _PFeeder_cycle_temp = _6;
  } // if _5
 } // for _PFeeder_s0_cooo_init
 int _7 = _P_extent_1 / 225;
 int _8 = _7 * 18432;
 int _9 = _8 + 2304;
 for (int _PFeeder_s0_outermost_loop = 0; _PFeeder_s0_outermost_loop < 0 + _9; _PFeeder_s0_outermost_loop++)
 {
  uint _10 = (uint)(ADD_UINT64_T_SUFFIX(432));
  uint _11 = _PFeeder_cycle_temp;
  uint _12 = (uint)(ADD_UINT64_T_SUFFIX(2304));
  uint _13 = _11 % _12;
  bool _14 = _10 <= _13;
  uint _15 = _11 / _12;
  int _16 = (int)(_15);
  int _17 = _P_extent_1 / 225;
  int _18 = _17 * 8;
  bool _19 = _16 < _18;
  bool _20 = _14 && _19;
  if (_20)
  {
   float16 __21 = read_channel_intel(_PLoader_PFeeder_channel);
   _PFeeder_in_v_temp = __21;
  } // if _20
  #pragma unroll
  for (int _PFeeder_s0_buf = 0; _PFeeder_s0_buf < 0 + 13; _PFeeder_s0_buf++)
  {
   bool _22 = _PFeeder_s0_buf == 0;
   if (_22)
   {
    float16 _23 = _PFeeder_in_v_temp;
    _PFeeder_value_shreg = _23;
    (void)_23;
    uint _24 = _PFeeder_cycle_temp;
    _PFeeder_time_stamp_shreg = _24;
    (void)_24;
   } // if _22
   else
   {
    float16 _26 = _PFeeder_value_shreg;
    _PFeeder_value_shreg = _26;
    (void)_26;
    uint _28 = _PFeeder_time_stamp_shreg;
    _PFeeder_time_stamp_shreg = _28;
    (void)_28;
   } // if _22 else
   float16 _30 = _PFeeder_value_shreg;
   float16 _31 = __fpga_reg(__fpga_reg(_30));
   _PFeeder_value_shreg = _31;
   (void)_31;
   uint _33 = _PFeeder_time_stamp_shreg;
   uint _34 = __fpga_reg(__fpga_reg(_33));
   _PFeeder_time_stamp_shreg = _34;
   (void)_34;
   uint _35 = (uint)(ADD_UINT64_T_SUFFIX(432));
   uint _37 = _PFeeder_time_stamp_shreg;
   uint _38 = (uint)(ADD_UINT64_T_SUFFIX(2304));
   uint _39 = _37 % _38;
   bool _40 = _35 <= _39;
   if (_40)
   {
    uint _42 = _PFeeder_time_stamp_shreg;
    uint _43 = (uint)(ADD_UINT64_T_SUFFIX(2304));
    uint _44 = _42 % _43;
    uint _45 = (uint)(ADD_UINT64_T_SUFFIX(432));
    uint _46 = _44 - _45;
    uint _47 = (uint)(ADD_UINT64_T_SUFFIX(13));
    uint _48 = _46 % _47;
    int _49 = (int)(_48);
    bool _50 = _PFeeder_s0_buf == _49;
    if (_50)
    {
     float16 _52 = _PFeeder_value_shreg;
     uint _54 = _PFeeder_time_stamp_shreg;
     uint _55 = (uint)(ADD_UINT64_T_SUFFIX(2304));
     uint _56 = _54 / _55;
     uint _57 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _58 = _56 & _57;
     bool _59 = (bool)(_58);
     uint _61 = _54 % _55;
     uint _62 = (uint)(ADD_UINT64_T_SUFFIX(432));
     uint _63 = _61 - _62;
     int _64 = (int)(_63);
     int _65 = _64 / 624;
     int _67 = _64 / 208;
     int _68 = _67 % 3;
     int _70 = _64 / 52;
     int _71 = _70 & 3;
     int _73 = _64 / 13;
     int _74 = _73 & 3;
     _PFeeder_DB_0_ibuffer[_59][_65][_68][_71][_74][_PFeeder_s0_buf] = _52;
    } // if _50
   } // if _40
   uint _76 = _PFeeder_time_stamp_shreg;
   uint _77 = (uint)(ADD_UINT64_T_SUFFIX(2304));
   uint _78 = _76 / _77;
   int _79 = (int)(_78);
   int _80 = _P_extent_1 / 225;
   int _81 = _80 * 8;
   bool _82 = _79 <= _81;
   uint _83 = (uint)(ADD_UINT64_T_SUFFIX(0));
   bool _85 = _83 < _78;
   bool _86 = _82 && _85;
   if (_86)
   {
    uint _88 = _PFeeder_time_stamp_shreg;
    uint _89 = (uint)(ADD_UINT64_T_SUFFIX(2304));
    uint _90 = _88 / _89;
    uint _91 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _92 = _90 & _91;
    bool _93 = (bool)(_92);
    bool _94 = !(_93);
    uint _96 = _88 % _89;
    int _97 = (int)(_96);
    int _98 = _97 / 768;
    int _100 = _97 >> 8;
    int _101 = _100 % 3;
    int _103 = _97 >> 4;
    int _104 = _103 & 3;
    int _106 = _97 & 3;
    float16 _107 = _PFeeder_DB_0_ibuffer[_94][_98][_101][_104][_106][_PFeeder_s0_buf];
    _PFeeder_A_channel_array.s[_PFeeder_s0_buf] = _107;
    (void)_PFeeder_s0_buf;
   } // if _86
  } // for _PFeeder_s0_buf
  uint _109 = _PFeeder_time_stamp_shreg;
  uint _110 = (uint)(ADD_UINT64_T_SUFFIX(2304));
  uint _111 = _109 / _110;
  int _112 = (int)(_111);
  int _113 = _P_extent_1 / 225;
  int _114 = _113 * 8;
  bool _115 = _112 <= _114;
  uint _116 = (uint)(ADD_UINT64_T_SUFFIX(0));
  bool _118 = _116 < _111;
  bool _119 = _115 && _118;
  if (_119)
  {
   write_channel_intel(_PFeeder_A_channel, _PFeeder_A_channel_array);
   (void)_PFeeder_A_channel_array;
  } // if _119
  uint _120 = _PFeeder_cycle_temp;
  uint _121 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _122 = _120 + _121;
  _PFeeder_cycle_temp = _122;
 } // for _PFeeder_s0_outermost_loop
} // kernel kernel_PFeeder
// Address spaces for kernel_WLoader
#if 589824 <= MAX_CONSTANT_BUFFER_SIZE && 0 < MAX_CONSTANT_ARGS
#define __address_space__W_serializer_mem_channel __constant
#else
#define __address_space__W_serializer_mem_channel __global
#endif
__kernel void kernel_WLoader(
 const int _P_extent_1,
 __address_space__W_serializer_mem_channel const float *restrict _W_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _123 = _P_extent_1 / 225;
 for (int _WLoader_s0_n = 0; _WLoader_s0_n < 0 + _123; _WLoader_s0_n++)
 {
  for (int _WLoader_s0_mk_ci_kx_ky_coo_my_cooo = 0; _WLoader_s0_mk_ci_kx_ky_coo_my_cooo < 0 + 9216; _WLoader_s0_mk_ci_kx_ky_coo_my_cooo++)
  {
   int _124 = _addr_temp;
   int _125 = _124 % 9216;
   int _126 = _125 * 16;
   float16 _127 = vload16(0, (__address_space__W_serializer_mem_channel float*)_W_serializer_mem_channel + _126);
   write_channel_intel(_WLoader_WFeeder_channel, _127);
   (void)_127;
   int _128 = _124 + 1;
   _addr_temp = _128;
  } // for _WLoader_s0_mk_ci_kx_ky_coo_my_cooo
 } // for _WLoader_s0_n
} // kernel kernel_WLoader
#undef __address_space__W_serializer_mem_channel
// Address spaces for kernel_WFeeder
__kernel void kernel_WFeeder(
 const int _P_extent_1)
{
 _cga__1 _WFeeder_B_channel_array;
 float16 _WFeeder_value_shreg;
 uint _WFeeder_time_stamp_shreg;
 float16 _WFeeder_in_v_temp;
 uint _WFeeder_cycle_temp;
 float16 __attribute__((memory, numbanks(8), singlepump)) _WFeeder_DB_0_ibuffer[2][3][3][4][4][8];
 #pragma unroll
 for (int _WFeeder_s0_yyy_xxx_init = 0; _WFeeder_s0_yyy_xxx_init < 0 + 13; _WFeeder_s0_yyy_xxx_init++)
 {
  bool _129 = _WFeeder_s0_yyy_xxx_init == 0;
  if (_129)
  {
   uint _130 = (uint)(ADD_UINT64_T_SUFFIX(1152));
   _WFeeder_cycle_temp = _130;
  } // if _129
 } // for _WFeeder_s0_yyy_xxx_init
 int _131 = _P_extent_1 / 225;
 int _132 = _131 * 18432;
 int _133 = _132 + 2304;
 for (int _WFeeder_s0_outermost_loop = 0; _WFeeder_s0_outermost_loop < 0 + _133; _WFeeder_s0_outermost_loop++)
 {
  uint _134 = (uint)(ADD_UINT64_T_SUFFIX(1152));
  uint _135 = _WFeeder_cycle_temp;
  uint _136 = (uint)(ADD_UINT64_T_SUFFIX(2304));
  uint _137 = _135 % _136;
  bool _138 = _134 <= _137;
  uint _139 = _135 / _136;
  int _140 = (int)(_139);
  int _141 = _P_extent_1 / 225;
  int _142 = _141 * 8;
  bool _143 = _140 < _142;
  bool _144 = _138 && _143;
  if (_144)
  {
   float16 __145 = read_channel_intel(_WLoader_WFeeder_channel);
   _WFeeder_in_v_temp = __145;
  } // if _144
  #pragma unroll
  for (int _WFeeder_s0_buf = 0; _WFeeder_s0_buf < 0 + 8; _WFeeder_s0_buf++)
  {
   bool _146 = _WFeeder_s0_buf == 0;
   if (_146)
   {
    float16 _147 = _WFeeder_in_v_temp;
    _WFeeder_value_shreg = _147;
    (void)_147;
    uint _148 = _WFeeder_cycle_temp;
    _WFeeder_time_stamp_shreg = _148;
    (void)_148;
   } // if _146
   else
   {
    float16 _150 = _WFeeder_value_shreg;
    _WFeeder_value_shreg = _150;
    (void)_150;
    uint _152 = _WFeeder_time_stamp_shreg;
    _WFeeder_time_stamp_shreg = _152;
    (void)_152;
   } // if _146 else
   float16 _154 = _WFeeder_value_shreg;
   float16 _155 = __fpga_reg(__fpga_reg(_154));
   _WFeeder_value_shreg = _155;
   (void)_155;
   uint _157 = _WFeeder_time_stamp_shreg;
   uint _158 = __fpga_reg(__fpga_reg(_157));
   _WFeeder_time_stamp_shreg = _158;
   (void)_158;
   uint _159 = (uint)(ADD_UINT64_T_SUFFIX(1152));
   uint _161 = _WFeeder_time_stamp_shreg;
   uint _162 = (uint)(ADD_UINT64_T_SUFFIX(2304));
   uint _163 = _161 % _162;
   bool _164 = _159 <= _163;
   if (_164)
   {
    uint _166 = _WFeeder_time_stamp_shreg;
    uint _167 = (uint)(ADD_UINT64_T_SUFFIX(2304));
    uint _168 = _166 % _167;
    uint _169 = (uint)(ADD_UINT64_T_SUFFIX(1152));
    uint _170 = _168 - _169;
    uint _171 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _172 = _170 & _171;
    int _173 = (int)(_172);
    bool _174 = _WFeeder_s0_buf == _173;
    if (_174)
    {
     float16 _176 = _WFeeder_value_shreg;
     uint _178 = _WFeeder_time_stamp_shreg;
     uint _179 = (uint)(ADD_UINT64_T_SUFFIX(2304));
     uint _180 = _178 / _179;
     uint _181 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _182 = _180 & _181;
     bool _183 = (bool)(_182);
     uint _185 = _178 % _179;
     uint _186 = (uint)(ADD_UINT64_T_SUFFIX(1152));
     uint _187 = _185 - _186;
     int _188 = (int)(_187);
     int _189 = _188 / 384;
     int _191 = _188 >> 7;
     int _192 = _191 % 3;
     int _194 = _188 >> 5;
     int _195 = _194 & 3;
     int _197 = _188 >> 3;
     int _198 = _197 & 3;
     _WFeeder_DB_0_ibuffer[_183][_189][_192][_195][_198][_WFeeder_s0_buf] = _176;
    } // if _174
   } // if _164
   uint _200 = _WFeeder_time_stamp_shreg;
   uint _201 = (uint)(ADD_UINT64_T_SUFFIX(2304));
   uint _202 = _200 / _201;
   int _203 = (int)(_202);
   int _204 = _P_extent_1 / 225;
   int _205 = _204 * 8;
   bool _206 = _203 <= _205;
   uint _207 = (uint)(ADD_UINT64_T_SUFFIX(0));
   bool _209 = _207 < _202;
   bool _210 = _206 && _209;
   if (_210)
   {
    uint _212 = _WFeeder_time_stamp_shreg;
    uint _213 = (uint)(ADD_UINT64_T_SUFFIX(2304));
    uint _214 = _212 / _213;
    uint _215 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _216 = _214 & _215;
    bool _217 = (bool)(_216);
    bool _218 = !(_217);
    uint _220 = _212 % _213;
    int _221 = (int)(_220);
    int _222 = _221 / 768;
    int _224 = _221 >> 8;
    int _225 = _224 % 3;
    int _227 = _221 >> 6;
    int _228 = _227 & 3;
    int _230 = _221 >> 2;
    int _231 = _230 & 3;
    float16 _232 = _WFeeder_DB_0_ibuffer[_218][_222][_225][_228][_231][_WFeeder_s0_buf];
    _WFeeder_B_channel_array.s[_WFeeder_s0_buf] = _232;
    (void)_WFeeder_s0_buf;
   } // if _210
  } // for _WFeeder_s0_buf
  uint _234 = _WFeeder_time_stamp_shreg;
  uint _235 = (uint)(ADD_UINT64_T_SUFFIX(2304));
  uint _236 = _234 / _235;
  int _237 = (int)(_236);
  int _238 = _P_extent_1 / 225;
  int _239 = _238 * 8;
  bool _240 = _237 <= _239;
  uint _241 = (uint)(ADD_UINT64_T_SUFFIX(0));
  bool _243 = _241 < _236;
  bool _244 = _240 && _243;
  if (_244)
  {
   write_channel_intel(_WFeeder_B_channel, _WFeeder_B_channel_array);
   (void)_WFeeder_B_channel_array;
  } // if _244
  uint _245 = _WFeeder_cycle_temp;
  uint _246 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _247 = _245 + _246;
  _WFeeder_cycle_temp = _247;
 } // for _WFeeder_s0_outermost_loop
} // kernel kernel_WFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _P_extent_1)
{
 // produce C
 float _C_shreg[256][8][13];
 float _C_pipe_shreg[8][3073];
 // produce B
 float16 _B_shreg[8];
 float _C_temp[8][13];
 // produce A
 float16 _A_shreg[13];
 _cga__1 _WFeeder_B_channel_array;
 _cga _PFeeder_A_channel_array;
 float _C_shreg_temp;
 int _C_pipe_iter_temp;
 int _C_pipe_base_temp;
 _C_pipe_iter_temp = 3328;
 _C_pipe_base_temp = 0;
 int _248 = _P_extent_1 / 225;
 int _249 = _248 * 4;
 int _250 = _249 + 1;
 for (int _A_s0_n_mk = 0; _A_s0_n_mk < 0 + _250; _A_s0_n_mk++)
 {
  for (int _A_s0_ci_kx_ky_coo_mx_my_y_x = 0; _A_s0_ci_kx_ky_coo_mx_my_y_x < 0 + 4608; _A_s0_ci_kx_ky_coo_mx_my_y_x++)
  {
   #pragma unroll
   for (int _dummy__1_s0_yyy_xxx = 0; _dummy__1_s0_yyy_xxx < 0 + 13; _dummy__1_s0_yyy_xxx++)
   {
    #pragma unroll
    for (int _dummy_s0_cooo = 0; _dummy_s0_cooo < 0 + 8; _dummy_s0_cooo++)
    {
     float _252 = _C_shreg[255][_dummy_s0_cooo][_dummy__1_s0_yyy_xxx];
     _C_temp[_dummy_s0_cooo][_dummy__1_s0_yyy_xxx] = _252;
     #pragma unroll
     for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
     {
      int _253 = 255 - _dummy__2_s0_l1;
      int _254 = 254 - _dummy__2_s0_l1;
      float _256 = _C_shreg[_254][_dummy_s0_cooo][_dummy__1_s0_yyy_xxx];
      _C_shreg[_253][_dummy_s0_cooo][_dummy__1_s0_yyy_xxx] = _256;
      (void)_256;
     } // for _dummy__2_s0_l1
     float _257 = _C_temp[_dummy_s0_cooo][_dummy__1_s0_yyy_xxx];
     _C_shreg[0][_dummy_s0_cooo][_dummy__1_s0_yyy_xxx] = _257;
     (void)_257;
    } // for _dummy_s0_cooo
   } // for _dummy__1_s0_yyy_xxx
   int _258 = _P_extent_1 / 225;
   int _259 = _258 * 4;
   bool _260 = _A_s0_n_mk < _259;
   if (_260)
   {
    _cga__1 __261 = read_channel_intel(_WFeeder_B_channel);
    _WFeeder_B_channel_array = __261;
    (void)__261;
    _cga __262 = read_channel_intel(_PFeeder_A_channel);
    _PFeeder_A_channel_array = __262;
    (void)__262;
   } // if _260
   #pragma unroll
   for (int _A_s0_yyy_xxx = 0; _A_s0_yyy_xxx < 0 + 13; _A_s0_yyy_xxx++)
   {
    #pragma unroll
    for (int _A_s0_cooo = 0; _A_s0_cooo < 0 + 8; _A_s0_cooo++)
    {
     float16 _263;
     bool _264 = _A_s0_cooo == 0;
     if (_264)
     {
      float16 __265 = _PFeeder_A_channel_array.s[_A_s0_yyy_xxx];
      _263 = __265;
     } // if _264
     else
     {
      float16 _267 = _A_shreg[_A_s0_yyy_xxx];
      _263 = _267;
     } // if _264 else
     float16 _268 = _263;
     _A_shreg[_A_s0_yyy_xxx] = _268;
     (void)_268;
     float16 _270 = _A_shreg[_A_s0_yyy_xxx];
     float16 _271 = __fpga_reg(__fpga_reg(_270));
     _A_shreg[_A_s0_yyy_xxx] = _271;
     (void)_271;
     float16 _272;
     bool _273 = _A_s0_yyy_xxx == 0;
     if (_273)
     {
      float16 __274 = _WFeeder_B_channel_array.s[_A_s0_cooo];
      _272 = __274;
     } // if _273
     else
     {
      float16 _276 = _B_shreg[_A_s0_cooo];
      _272 = _276;
     } // if _273 else
     float16 _277 = _272;
     _B_shreg[_A_s0_cooo] = _277;
     (void)_277;
     float16 _279 = _B_shreg[_A_s0_cooo];
     float16 _280 = __fpga_reg(__fpga_reg(_279));
     _B_shreg[_A_s0_cooo] = _280;
     (void)_280;
     float _281;
     int _282 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 2304;
     int _283 = _282 / 768;
     bool _284 = _283 == 0;
     int _285 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 768;
     int _286 = _285 >> 8;
     bool _287 = _286 == 0;
     bool _288 = _284 && _287;
     int _289 = _A_s0_n_mk & 3;
     bool _290 = _289 == 0;
     bool _291 = _288 && _290;
     int _292 = _A_s0_ci_kx_ky_coo_mx_my_y_x / 2304;
     bool _293 = _292 == 0;
     bool _294 = _291 && _293;
     if (_294)
     {
      float _295 = float_from_bits(0 /* 0 */);
      _281 = _295;
     } // if _294
     else
     {
      float _297 = _C_shreg[0][_A_s0_cooo][_A_s0_yyy_xxx];
      float _298 = __fpga_reg(_297);
      _281 = _298;
     } // if _294 else
     float _299 = _281;
     _C_shreg_temp = _299;
     #pragma unroll
     for (int _A_s0_cii = 0; _A_s0_cii < 0 + 16; _A_s0_cii++)
     {
      float _300 = _C_shreg_temp;
      float _302 = _A_shreg[_A_s0_yyy_xxx][_A_s0_cii];
      float _304 = _B_shreg[_A_s0_cooo][_A_s0_cii];
      float _305 = _302 * _304;
      float _306 = _300 + _305;
      _C_shreg_temp = _306;
      int _307 = _A_s0_cii & 3;
      bool _308 = _307 == 3;
      if (_308)
      {
       float _309 = _C_shreg_temp;
       float _310 = __fpga_reg(_309);
       _C_shreg_temp = _310;
      } // if _308
     } // for _A_s0_cii
     float _311 = _C_shreg_temp;
     _C_shreg[0][_A_s0_cooo][_A_s0_yyy_xxx] = _311;
     (void)_311;
     #pragma unroll
     for (int _A_s0_cii = 0; _A_s0_cii < 0 + 16; _A_s0_cii++)
     {
      bool _312 = _A_s0_cii == 15;
      int _313 = _A_s0_ci_kx_ky_coo_mx_my_y_x / 2304;
      bool _314 = _313 == 1;
      bool _315 = _312 && _314;
      int _316 = _A_s0_n_mk & 3;
      bool _317 = _316 == 3;
      bool _318 = _315 && _317;
      int _319 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 768;
      int _320 = _319 >> 8;
      bool _321 = _320 == 2;
      bool _322 = _318 && _321;
      int _323 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 2304;
      int _324 = _323 / 768;
      bool _325 = _324 == 2;
      bool _326 = _322 && _325;
      if (_326)
      {
       int _327 = _A_s0_yyy_xxx * 256;
       float _329 = _C_shreg[0][_A_s0_cooo][_A_s0_yyy_xxx];
       _C_pipe_shreg[_A_s0_cooo][_327] = _329;
       (void)_329;
      } // if _326
     } // for _A_s0_cii
    } // for _A_s0_cooo
   } // for _A_s0_yyy_xxx
   int _330 = _A_s0_ci_kx_ky_coo_mx_my_y_x & 3;
   bool _331 = _330 == 0;
   int _332 = _A_s0_ci_kx_ky_coo_mx_my_y_x & 15;
   int _333 = _332 >> 2;
   bool _334 = _333 == 0;
   bool _335 = _331 && _334;
   int _336 = _A_s0_ci_kx_ky_coo_mx_my_y_x & 63;
   int _337 = _336 >> 4;
   bool _338 = _337 == 0;
   bool _339 = _335 && _338;
   int _340 = _A_s0_ci_kx_ky_coo_mx_my_y_x & 255;
   int _341 = _340 >> 6;
   bool _342 = _341 == 0;
   bool _343 = _339 && _342;
   int _344 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 2304;
   int _345 = _344 / 768;
   bool _346 = _345 == 2;
   bool _347 = _343 && _346;
   int _348 = _A_s0_ci_kx_ky_coo_mx_my_y_x % 768;
   int _349 = _348 >> 8;
   bool _350 = _349 == 2;
   bool _351 = _347 && _350;
   int _352 = _A_s0_n_mk & 3;
   bool _353 = _352 == 3;
   bool _354 = _351 && _353;
   int _355 = _A_s0_ci_kx_ky_coo_mx_my_y_x / 2304;
   bool _356 = _355 == 1;
   bool _357 = _354 && _356;
   if (_357)
   {
    int _358 = _C_pipe_iter_temp;
    _C_pipe_base_temp = _358;
   } // if _357
   float8 _Out_unloader_channel_temp;
   #pragma unroll
   for (int _C_pipe_b__126 = 0; _C_pipe_b__126 < 0 + 8; _C_pipe_b__126++)
   {
    float _360 = _C_pipe_shreg[_C_pipe_b__126][0];
    _Out_unloader_channel_temp[_C_pipe_b__126] = _360;
    #pragma unroll
    for (int _C_pipe_b__126_dummy = 0; _C_pipe_b__126_dummy < 0 + 8; _C_pipe_b__126_dummy++)
    {
     float _361 = _Out_unloader_channel_temp[_C_pipe_b__126_dummy];
     float _362 = __fpga_reg(__fpga_reg(_361));
     _Out_unloader_channel_temp[_C_pipe_b__126_dummy] = _362;
    } // for _C_pipe_b__126_dummy
   } // for _C_pipe_b__126
   int _363 = _C_pipe_iter_temp;
   int _364 = _C_pipe_base_temp;
   int _365 = _364 + 3328;
   bool _366 = _363 < _365;
   if (_366)
   {
    float8 _367 = _Out_unloader_channel_temp;
    write_channel_intel(_Out_unloader_channel, _367);
    (void)_367;
   } // if _366
   #pragma unroll
   for (int _C_pipe_b__127 = 0; _C_pipe_b__127 < 0 + 8; _C_pipe_b__127++)
   {
    #pragma unroll
    for (int _C_pipe_p__63 = 0; _C_pipe_p__63 < 0 + 12; _C_pipe_p__63++)
    {
     #pragma unroll
     for (int _C_pipe_l__63 = 0; _C_pipe_l__63 < 0 + 255; _C_pipe_l__63++)
     {
      int _368 = _C_pipe_p__63 * 256;
      int _369 = _368 + _C_pipe_l__63;
      int _370 = _369 + 1;
      float _372 = _C_pipe_shreg[_C_pipe_b__127][_370];
      _C_pipe_shreg[_C_pipe_b__127][_369] = _372;
      (void)_372;
     } // for _C_pipe_l__63
     int _373 = _C_pipe_p__63 * 256;
     int _374 = _373 + 255;
     int _375 = _373 + 256;
     float _377 = _C_pipe_shreg[_C_pipe_b__127][_375];
     float _378 = __fpga_reg(__fpga_reg(_377));
     _C_pipe_shreg[_C_pipe_b__127][_374] = _378;
     (void)_378;
    } // for _C_pipe_p__63
   } // for _C_pipe_b__127
   int _379 = _C_pipe_iter_temp;
   int _380 = _379 + 1;
   _C_pipe_iter_temp = _380;
  } // for _A_s0_ci_kx_ky_coo_mx_my_y_x
 } // for _A_s0_n_mk
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _P_extent_1,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _381 = _P_extent_1 / 225;
 for (int _unloader_s0_n = 0; _unloader_s0_n < 0 + _381; _unloader_s0_n++)
 {
  for (int _unloader_s0_yyy_xxx_coo_mx_my_y_x = 0; _unloader_s0_yyy_xxx_coo_mx_my_y_x < 0 + 3328; _unloader_s0_yyy_xxx_coo_mx_my_y_x++)
  {
   float8 __382 = read_channel_intel(_Out_unloader_channel);
   int _383 = _addr_temp;
   int _384 = _383 * 8;
   vstore8(__382, 0, (__address_space__unloader_mem_channel float*)_unloader_mem_channel + _384);
   int _385 = _addr_temp;
   int _386 = _385 + 1;
   _addr_temp = _386;
  } // for _unloader_s0_yyy_xxx_coo_mx_my_y_x
 } // for _unloader_s0_n
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

