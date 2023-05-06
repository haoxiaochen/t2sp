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
typedef struct { float16 s[10]; } _cga;
typedef struct { float16 s[8]; } _cga__1;
channel float16 _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga _aFeeder_X_channel __attribute__((depth(256))) ;
channel float16 _bLoader_bFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _bFeeder_Y_channel __attribute__((depth(256))) ;
channel float8 _Out_unloader_channel __attribute__((depth(256))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_serializer_mem_channel const float *restrict _A_serializer_mem_channel)
{
 //int _addr_temp;
 //_addr_temp = 0;
 int _0 = _A_extent_1 / 320;
 int _1 = _0 + 1;
 for (int _aLoader_s0_i = 0; _aLoader_s0_i < 0 + _1; _aLoader_s0_i++)
 {
  int _2 = _B_extent_0 >> 8;
  for (int _aLoader_s0_j = 0; _aLoader_s0_j < 0 + _2; _aLoader_s0_j++)
  {
   int _3 = _A_extent_0 >> 9;
   for (int _aLoader_s0_k = 0; _aLoader_s0_k < 0 + _3; _aLoader_s0_k++)
   {
    for (int _aLoader_s0_kk_ii_iii = 0; _aLoader_s0_kk_ii_iii < 0 + 10240; _aLoader_s0_kk_ii_iii++)
    {
     bool _4 = _aLoader_s0_j == 0;
     bool _5 = _aLoader_s0_k == 0;
     bool _6 = _4 && _5;
     int _7 = _A_extent_1 / 320;
     bool _8 = _aLoader_s0_i < _7;
     bool _9 = _6 || _8;
     if (_9)
     {
      float16 _10;
      int _11 = _A_extent_1 / 320;
      bool _12 = _aLoader_s0_i < _11;
      if (_12)
      {
       //int _13 = _addr_temp;
       //int _14 = _B_extent_0 >> 8;
       //int _15 = _A_extent_0 >> 9;
       //int _16 = _14 * _15;
       //int _17 = _16 * 10240;
       //int _18 = _13 / _17;
       //int _19 = _18 * _15;
       //int _20 = _19 * 10240;
       //int _21 = _15 * 10240;
       //int _22 = _13 % _21;
       //int _23 = _20 + _22;
       //int _24 = _23 * 16;
       int addr = (_aLoader_s0_i * _3 + _aLoader_s0_k) * 10240 + _aLoader_s0_kk_ii_iii;
       float16 _25 = vload16(0, (__address_space__A_serializer_mem_channel float*)_A_serializer_mem_channel + addr * 16);
       _10 = _25;
      } // if _12
      else
      {
       float _26 = float_from_bits(0 /* 0 */);
       float16 _27 = _26;
       _10 = _27;
      } // if _12 else
      float16 _28 = _10;
      write_channel_intel(_aLoader_aFeeder_channel, _28);
      (void)_28;
     } // if _9
     //int _29 = _addr_temp;
     //int _30 = _29 + 1;
     //_addr_temp = _30;
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
 float16 __attribute__((memory, numbanks(16), singlepump)) _aFeeder_DB_0_ibuffer[2][32][32][16];
 #pragma unroll
 for (int _aFeeder_s0_jjj_init = 0; _aFeeder_s0_jjj_init < 0 + 8; _aFeeder_s0_jjj_init++)
 {
  bool _31 = _aFeeder_s0_jjj_init == 0;
  if (_31)
  {
   uint _32 = (uint)(ADD_UINT64_T_SUFFIX(22528));
   _aFeeder_cycle_temp = _32;
  } // if _31
 } // for _aFeeder_s0_jjj_init
 while(1)
 {
  uint _33 = (uint)(ADD_UINT64_T_SUFFIX(22528));
  uint _34 = _aFeeder_cycle_temp;
  uint _35 = (uint)(ADD_UINT64_T_SUFFIX(32767));
  uint _36 = _34 & _35;
  bool _37 = _33 <= _36;
  if (_37)
  {
   float16 __38 = read_channel_intel(_aLoader_aFeeder_channel);
   _aFeeder_in_v_temp = __38;
  } // if _37
  #pragma unroll
  for (int _aFeeder_s0_buf = 0; _aFeeder_s0_buf < 0 + 10; _aFeeder_s0_buf++)
  {
   bool _39 = _aFeeder_s0_buf == 0;
   if (_39)
   {
    float16 _40 = _aFeeder_in_v_temp;
    _aFeeder_value_shreg = _40;
    (void)_40;
    uint _41 = _aFeeder_cycle_temp;
    _aFeeder_time_stamp_shreg = _41;
    (void)_41;
   } // if _39
   else
   {
    float16 _43 = _aFeeder_value_shreg;
    _aFeeder_value_shreg = _43;
    (void)_43;
    uint _45 = _aFeeder_time_stamp_shreg;
    _aFeeder_time_stamp_shreg = _45;
    (void)_45;
   } // if _39 else
   float16 _47 = _aFeeder_value_shreg;
   float16 _48 = __fpga_reg(__fpga_reg(_47));
   _aFeeder_value_shreg = _48;
   (void)_48;
   uint _50 = _aFeeder_time_stamp_shreg;
   uint _51 = __fpga_reg(__fpga_reg(_50));
   _aFeeder_time_stamp_shreg = _51;
   (void)_51;
   uint _52 = (uint)(ADD_UINT64_T_SUFFIX(22528));
   uint _54 = _aFeeder_time_stamp_shreg;
   uint _55 = (uint)(ADD_UINT64_T_SUFFIX(32767));
   uint _56 = _54 & _55;
   bool _57 = _52 <= _56;
   if (_57)
   {
    uint _59 = _aFeeder_time_stamp_shreg;
    uint _60 = (uint)(ADD_UINT64_T_SUFFIX(32767));
    uint _61 = _59 & _60;
    uint _62 = (uint)(ADD_UINT64_T_SUFFIX(22528));
    uint _63 = _61 - _62;
    uint _64 = (uint)(ADD_UINT64_T_SUFFIX(10));
    uint _65 = _63 % _64;
    int _66 = (int)(_65);
    bool _67 = _aFeeder_s0_buf == _66;
    if (_67)
    {
     float16 _69 = _aFeeder_value_shreg;
     uint _71 = _aFeeder_time_stamp_shreg;
     uint _72 = (uint)(ADD_UINT64_T_SUFFIX(15));
     uint _73 = _71 >> _72;
     uint _74 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _75 = _73 & _74;
     bool _76 = (bool)(_75);
     uint _78 = (uint)(ADD_UINT64_T_SUFFIX(32767));
     uint _79 = _71 & _78;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(22528));
     uint _81 = _79 - _80;
     int _82 = (int)(_81);
     int _83 = _82 / 320;
     int _85 = _82 / 10;
     int _86 = _85 & 31;
     _aFeeder_DB_0_ibuffer[_76][_83][_86][_aFeeder_s0_buf] = _69;
    } // if _67
   } // if _57
   uint _87 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _89 = _aFeeder_time_stamp_shreg;
   uint _90 = (uint)(ADD_UINT64_T_SUFFIX(15));
   uint _91 = _89 >> _90;
   bool _92 = _87 < _91;
   if (_92)
   {
    uint _94 = _aFeeder_time_stamp_shreg;
    uint _95 = (uint)(ADD_UINT64_T_SUFFIX(15));
    uint _96 = _94 >> _95;
    uint _97 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _98 = _96 & _97;
    bool _99 = (bool)(_98);
    bool _100 = !(_99);
    uint _102 = (uint)(ADD_UINT64_T_SUFFIX(32767));
    uint _103 = _94 & _102;
    int _104 = (int)(_103);
    int _105 = _104 >> 10;
    int _107 = _104 >> 5;
    int _108 = _107 & 31;
    float16 _109 = _aFeeder_DB_0_ibuffer[_100][_105][_108][_aFeeder_s0_buf];
    _aFeeder_X_channel_array.s[_aFeeder_s0_buf] = _109;
    (void)_aFeeder_s0_buf;
   } // if _92
  } // for _aFeeder_s0_buf
  uint _110 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _112 = _aFeeder_time_stamp_shreg;
  uint _113 = (uint)(ADD_UINT64_T_SUFFIX(15));
  uint _114 = _112 >> _113;
  bool _115 = _110 < _114;
  if (_115)
  {
   write_channel_intel(_aFeeder_X_channel, _aFeeder_X_channel_array);
   (void)_aFeeder_X_channel_array;
  } // if _115
  uint _116 = _aFeeder_cycle_temp;
  uint _117 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _118 = _116 + _117;
  _aFeeder_cycle_temp = _118;
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
 //int _addr_temp;
 //_addr_temp = 0;
 int _119 = _A_extent_1 / 320;
 int _120 = _119 + 1;
 for (int _bLoader_s0_i = 0; _bLoader_s0_i < 0 + _120; _bLoader_s0_i++)
 {
  int _121 = _B_extent_0 >> 8;
  for (int _bLoader_s0_j = 0; _bLoader_s0_j < 0 + _121; _bLoader_s0_j++)
  {
   int _122 = _A_extent_0 >> 9;
   for (int _bLoader_s0_k = 0; _bLoader_s0_k < 0 + _122; _bLoader_s0_k++)
   {
    for (int _bLoader_s0_kk_jj_jjj = 0; _bLoader_s0_kk_jj_jjj < 0 + 8192; _bLoader_s0_kk_jj_jjj++)
    {
     bool _123 = _bLoader_s0_j == 0;
     bool _124 = _bLoader_s0_k == 0;
     bool _125 = _123 && _124;
     int _126 = _A_extent_1 / 320;
     bool _127 = _bLoader_s0_i < _126;
     bool _128 = _125 || _127;
     if (_128)
     {
      float16 _129;
      int _130 = _A_extent_1 / 320;
      bool _131 = _bLoader_s0_i < _130;
      if (_131)
      {
       //int _132 = _addr_temp;
       //int _133 = _B_extent_0 >> 8;
       //int _134 = _A_extent_0 >> 9;
       //int _135 = _133 * _134;
       //int _136 = _135 * 8192;
       //int _137 = _132 % _136;
       //int _138 = _137 * 16;
       int addr = (_bLoader_s0_j * _122 + _bLoader_s0_k) * 8192 + _bLoader_s0_kk_jj_jjj;
       float16 _139 = vload16(0, (__address_space__B_serializer_mem_channel float*)_B_serializer_mem_channel + addr * 16);
       _129 = _139;
      } // if _131
      else
      {
       float _140 = float_from_bits(0 /* 0 */);
       float16 _141 = _140;
       _129 = _141;
      } // if _131 else
      float16 _142 = _129;
      write_channel_intel(_bLoader_bFeeder_channel, _142);
      (void)_142;
     } // if _128
     //int _143 = _addr_temp;
     //int _144 = _143 + 1;
     //_addr_temp = _144;
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
 _cga__1 _bFeeder_Y_channel_array;
 float16 _bFeeder_value_shreg;
 uint _bFeeder_time_stamp_shreg;
 float16 _bFeeder_in_v_temp;
 uint _bFeeder_cycle_temp;
 float16 __attribute__((memory, numbanks(8), singlepump)) _bFeeder_DB_0_ibuffer[2][32][32][8];
 #pragma unroll
 for (int _bFeeder_s0_iii_init = 0; _bFeeder_s0_iii_init < 0 + 10; _bFeeder_s0_iii_init++)
 {
  bool _145 = _bFeeder_s0_iii_init == 0;
  if (_145)
  {
   uint _146 = (uint)(ADD_UINT64_T_SUFFIX(24576));
   _bFeeder_cycle_temp = _146;
  } // if _145
 } // for _bFeeder_s0_iii_init
 while(1)
 {
  uint _147 = (uint)(ADD_UINT64_T_SUFFIX(24576));
  uint _148 = _bFeeder_cycle_temp;
  uint _149 = (uint)(ADD_UINT64_T_SUFFIX(32767));
  uint _150 = _148 & _149;
  bool _151 = _147 <= _150;
  if (_151)
  {
   float16 __152 = read_channel_intel(_bLoader_bFeeder_channel);
   _bFeeder_in_v_temp = __152;
  } // if _151
  #pragma unroll
  for (int _bFeeder_s0_buf = 0; _bFeeder_s0_buf < 0 + 8; _bFeeder_s0_buf++)
  {
   bool _153 = _bFeeder_s0_buf == 0;
   if (_153)
   {
    float16 _154 = _bFeeder_in_v_temp;
    _bFeeder_value_shreg = _154;
    (void)_154;
    uint _155 = _bFeeder_cycle_temp;
    _bFeeder_time_stamp_shreg = _155;
    (void)_155;
   } // if _153
   else
   {
    float16 _157 = _bFeeder_value_shreg;
    _bFeeder_value_shreg = _157;
    (void)_157;
    uint _159 = _bFeeder_time_stamp_shreg;
    _bFeeder_time_stamp_shreg = _159;
    (void)_159;
   } // if _153 else
   float16 _161 = _bFeeder_value_shreg;
   float16 _162 = __fpga_reg(__fpga_reg(_161));
   _bFeeder_value_shreg = _162;
   (void)_162;
   uint _164 = _bFeeder_time_stamp_shreg;
   uint _165 = __fpga_reg(__fpga_reg(_164));
   _bFeeder_time_stamp_shreg = _165;
   (void)_165;
   uint _166 = (uint)(ADD_UINT64_T_SUFFIX(24576));
   uint _168 = _bFeeder_time_stamp_shreg;
   uint _169 = (uint)(ADD_UINT64_T_SUFFIX(32767));
   uint _170 = _168 & _169;
   bool _171 = _166 <= _170;
   if (_171)
   {
    uint _173 = _bFeeder_time_stamp_shreg;
    uint _174 = (uint)(ADD_UINT64_T_SUFFIX(32767));
    uint _175 = _173 & _174;
    uint _176 = (uint)(ADD_UINT64_T_SUFFIX(24576));
    uint _177 = _175 - _176;
    uint _178 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _179 = _177 & _178;
    int _180 = (int)(_179);
    bool _181 = _bFeeder_s0_buf == _180;
    if (_181)
    {
     float16 _183 = _bFeeder_value_shreg;
     uint _185 = _bFeeder_time_stamp_shreg;
     uint _186 = (uint)(ADD_UINT64_T_SUFFIX(15));
     uint _187 = _185 >> _186;
     uint _188 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _189 = _187 & _188;
     bool _190 = (bool)(_189);
     uint _192 = (uint)(ADD_UINT64_T_SUFFIX(32767));
     uint _193 = _185 & _192;
     uint _194 = (uint)(ADD_UINT64_T_SUFFIX(24576));
     uint _195 = _193 - _194;
     int _196 = (int)(_195);
     int _197 = _196 >> 8;
     int _199 = _196 >> 3;
     int _200 = _199 & 31;
     _bFeeder_DB_0_ibuffer[_190][_197][_200][_bFeeder_s0_buf] = _183;
    } // if _181
   } // if _171
   uint _201 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _203 = _bFeeder_time_stamp_shreg;
   uint _204 = (uint)(ADD_UINT64_T_SUFFIX(15));
   uint _205 = _203 >> _204;
   bool _206 = _201 < _205;
   if (_206)
   {
    uint _208 = _bFeeder_time_stamp_shreg;
    uint _209 = (uint)(ADD_UINT64_T_SUFFIX(15));
    uint _210 = _208 >> _209;
    uint _211 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _212 = _210 & _211;
    bool _213 = (bool)(_212);
    bool _214 = !(_213);
    uint _216 = (uint)(ADD_UINT64_T_SUFFIX(32767));
    uint _217 = _208 & _216;
    int _218 = (int)(_217);
    int _219 = _218 >> 10;
    int _221 = _218 & 31;
    float16 _222 = _bFeeder_DB_0_ibuffer[_214][_219][_221][_bFeeder_s0_buf];
    _bFeeder_Y_channel_array.s[_bFeeder_s0_buf] = _222;
    (void)_bFeeder_s0_buf;
   } // if _206
  } // for _bFeeder_s0_buf
  uint _223 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _225 = _bFeeder_time_stamp_shreg;
  uint _226 = (uint)(ADD_UINT64_T_SUFFIX(15));
  uint _227 = _225 >> _226;
  bool _228 = _223 < _227;
  if (_228)
  {
   write_channel_intel(_bFeeder_Y_channel, _bFeeder_Y_channel_array);
   (void)_bFeeder_Y_channel_array;
  } // if _228
  uint _229 = _bFeeder_cycle_temp;
  uint _230 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _231 = _229 + _230;
  _bFeeder_cycle_temp = _231;
 } // while _bFeeder_s0_outermost_loop_infinite
} // kernel kernel_bFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 // produce Z
 float _Z_shreg[1024][8][10];
 float _Z_pipe_shreg[8][9217];
 // produce Y
 float16 _Y_shreg[8];
 float _Z_temp[8][10];
 // produce X
 float16 _X_shreg[10];
 _cga__1 _bFeeder_Y_channel_array;
 _cga _aFeeder_X_channel_array;
 float _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 10240;
 _Z_pipe_base_temp = 0;
 int _232 = _A_extent_0 >> 9;
 int _233 = _A_extent_1 / 320;
 int _234 = _B_extent_0 >> 8;
 int _235 = _233 * _234;
 int _236 = _232 * _235;
 int _237 = _236 + 1;
 for (int _X_s0_i_j_k = 0; _X_s0_i_j_k < 0 + _237; _X_s0_i_j_k++)
 {
  for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 32768; _X_s0_kk_ii_jj++)
  {
   #pragma unroll
   for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 10; _dummy__1_s0_iii++)
   {
    #pragma unroll
    for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 8; _dummy_s0_jjj++)
    {
     float _239 = _Z_shreg[1023][_dummy_s0_jjj][_dummy__1_s0_iii];
     _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _239;
     #pragma unroll
     for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 1023; _dummy__2_s0_l1++)
     {
      int _240 = 1023 - _dummy__2_s0_l1;
      int _241 = 1022 - _dummy__2_s0_l1;
      float _243 = _Z_shreg[_241][_dummy_s0_jjj][_dummy__1_s0_iii];
      _Z_shreg[_240][_dummy_s0_jjj][_dummy__1_s0_iii] = _243;
      (void)_243;
     } // for _dummy__2_s0_l1
     float _244 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
     _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _244;
     (void)_244;
    } // for _dummy_s0_jjj
   } // for _dummy__1_s0_iii
   int _245 = _A_extent_0 >> 9;
   int _246 = _A_extent_1 / 320;
   int _247 = _B_extent_0 >> 8;
   int _248 = _246 * _247;
   int _249 = _245 * _248;
   bool _250 = _X_s0_i_j_k < _249;
   if (_250)
   {
    _cga__1 __251 = read_channel_intel(_bFeeder_Y_channel);
    _bFeeder_Y_channel_array = __251;
    (void)__251;
    _cga __252 = read_channel_intel(_aFeeder_X_channel);
    _aFeeder_X_channel_array = __252;
    (void)__252;
   } // if _250
   #pragma unroll
   for (int _X_s0_iii = 0; _X_s0_iii < 0 + 10; _X_s0_iii++)
   {
    #pragma unroll
    for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 8; _X_s0_jjj++)
    {
     float16 _253;
     bool _254 = _X_s0_jjj == 0;
     if (_254)
     {
      float16 __255 = _aFeeder_X_channel_array.s[_X_s0_iii];
      _253 = __255;
     } // if _254
     else
     {
      float16 _257 = _X_shreg[_X_s0_iii];
      _253 = _257;
     } // if _254 else
     float16 _258 = _253;
     _X_shreg[_X_s0_iii] = _258;
     (void)_258;
     float16 _260 = _X_shreg[_X_s0_iii];
     float16 _261 = __fpga_reg(__fpga_reg(_260));
     _X_shreg[_X_s0_iii] = _261;
     (void)_261;
     float16 _262;
     bool _263 = _X_s0_iii == 0;
     if (_263)
     {
      float16 __264 = _bFeeder_Y_channel_array.s[_X_s0_jjj];
      _262 = __264;
     } // if _263
     else
     {
      float16 _266 = _Y_shreg[_X_s0_jjj];
      _262 = _266;
     } // if _263 else
     float16 _267 = _262;
     _Y_shreg[_X_s0_jjj] = _267;
     (void)_267;
     float16 _269 = _Y_shreg[_X_s0_jjj];
     float16 _270 = __fpga_reg(__fpga_reg(_269));
     _Y_shreg[_X_s0_jjj] = _270;
     (void)_270;
     float _271;
     int _272 = _A_extent_0 >> 9;
     int _273 = _X_s0_i_j_k % _272;
     bool _274 = _273 == 0;
     int _275 = _X_s0_kk_ii_jj >> 10;
     bool _276 = _275 == 0;
     bool _277 = _274 && _276;
     if (_277)
     {
      float _278 = float_from_bits(0 /* 0 */);
      _271 = _278;
     } // if _277
     else
     {
      float _280 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
      float _281 = __fpga_reg(_280);
      _271 = _281;
     } // if _277 else
     float _282 = _271;
     _Z_shreg_temp = _282;
     #pragma unroll
     for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
     {
      float _283 = _Z_shreg_temp;
      float _285 = _X_shreg[_X_s0_iii][_X_s0_kkk];
      float _287 = _Y_shreg[_X_s0_jjj][_X_s0_kkk];
      float _288 = _285 * _287;
      float _289 = _283 + _288;
      _Z_shreg_temp = _289;
      int _290 = _X_s0_kkk & 3;
      bool _291 = _290 == 3;
      if (_291)
      {
       float _292 = _Z_shreg_temp;
       float _293 = __fpga_reg(_292);
       _Z_shreg_temp = _293;
      } // if _291
     } // for _X_s0_kkk
     float _294 = _Z_shreg_temp;
     _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _294;
     (void)_294;
     #pragma unroll
     for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
     {
      bool _295 = _X_s0_kkk == 15;
      int _296 = _X_s0_kk_ii_jj >> 10;
      bool _297 = _296 == 31;
      bool _298 = _295 && _297;
      int _299 = _A_extent_0 >> 9;
      int _300 = _X_s0_i_j_k % _299;
      int _301 = _299 + -1;
      bool _302 = _300 == _301;
      bool _303 = _298 && _302;
      if (_303)
      {
       int _304 = _X_s0_iii * 1024;
       float _306 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
       _Z_pipe_shreg[_X_s0_jjj][_304] = _306;
       (void)_306;
      } // if _303
     } // for _X_s0_kkk
    } // for _X_s0_jjj
   } // for _X_s0_iii
   int _307 = _X_s0_kk_ii_jj & 31;
   bool _308 = _307 == 0;
   int _309 = _X_s0_kk_ii_jj & 1023;
   int _310 = _309 >> 5;
   bool _311 = _310 == 0;
   bool _312 = _308 && _311;
   int _313 = _A_extent_0 >> 9;
   int _314 = _X_s0_i_j_k % _313;
   int _315 = _313 + -1;
   bool _316 = _314 == _315;
   bool _317 = _312 && _316;
   int _318 = _X_s0_kk_ii_jj >> 10;
   bool _319 = _318 == 31;
   bool _320 = _317 && _319;
   if (_320)
   {
    int _321 = _Z_pipe_iter_temp;
    _Z_pipe_base_temp = _321;
   } // if _320
   float8 _Out_unloader_channel_temp;
   #pragma unroll
   for (int _Z_pipe_b__6 = 0; _Z_pipe_b__6 < 0 + 8; _Z_pipe_b__6++)
   {
    float _323 = _Z_pipe_shreg[_Z_pipe_b__6][0];
    _Out_unloader_channel_temp[_Z_pipe_b__6] = _323;
    #pragma unroll
    for (int _Z_pipe_b__6_dummy = 0; _Z_pipe_b__6_dummy < 0 + 8; _Z_pipe_b__6_dummy++)
    {
     float _324 = _Out_unloader_channel_temp[_Z_pipe_b__6_dummy];
     float _325 = __fpga_reg(__fpga_reg(_324));
     _Out_unloader_channel_temp[_Z_pipe_b__6_dummy] = _325;
    } // for _Z_pipe_b__6_dummy
   } // for _Z_pipe_b__6
   int _326 = _Z_pipe_iter_temp;
   int _327 = _Z_pipe_base_temp;
   int _328 = _327 + 10240;
   bool _329 = _326 < _328;
   if (_329)
   {
    float8 _330 = _Out_unloader_channel_temp;
    write_channel_intel(_Out_unloader_channel, _330);
    (void)_330;
   } // if _329
   #pragma unroll
   for (int _Z_pipe_b__7 = 0; _Z_pipe_b__7 < 0 + 8; _Z_pipe_b__7++)
   {
    #pragma unroll
    for (int _Z_pipe_p__3 = 0; _Z_pipe_p__3 < 0 + 9; _Z_pipe_p__3++)
    {
     #pragma unroll
     for (int _Z_pipe_l__3 = 0; _Z_pipe_l__3 < 0 + 1023; _Z_pipe_l__3++)
     {
      int _331 = _Z_pipe_p__3 * 1024;
      int _332 = _331 + _Z_pipe_l__3;
      int _333 = _332 + 1;
      float _335 = _Z_pipe_shreg[_Z_pipe_b__7][_333];
      _Z_pipe_shreg[_Z_pipe_b__7][_332] = _335;
      (void)_335;
     } // for _Z_pipe_l__3
     int _336 = _Z_pipe_p__3 * 1024;
     int _337 = _336 + 1023;
     int _338 = _336 + 1024;
     float _340 = _Z_pipe_shreg[_Z_pipe_b__7][_338];
     float _341 = __fpga_reg(__fpga_reg(_340));
     _Z_pipe_shreg[_Z_pipe_b__7][_337] = _341;
     (void)_341;
    } // for _Z_pipe_p__3
   } // for _Z_pipe_b__7
   int _342 = _Z_pipe_iter_temp;
   int _343 = _342 + 1;
   _Z_pipe_iter_temp = _343;
  } // for _X_s0_kk_ii_jj
 } // for _X_s0_i_j_k
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
 int _344 = _A_extent_1 / 320;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _344; _unloader_s0_i++)
 {
  int _345 = _B_extent_0 >> 8;
  for (int _unloader_s0_j = 0; _unloader_s0_j < 0 + _345; _unloader_s0_j++)
  {
   for (int _unloader_s0_iii_ii_jj = 0; _unloader_s0_iii_ii_jj < 0 + 10240; _unloader_s0_iii_ii_jj++)
   {
    float8 __346 = read_channel_intel(_Out_unloader_channel);
    int _347 = _addr_temp;
    int _348 = _347 * 8;
    vstore8(__346, 0, (__address_space__unloader_mem_channel float*)_unloader_mem_channel + _348);
    int _349 = _addr_temp;
    int _350 = _349 + 1;
    _addr_temp = _350;
   } // for _unloader_s0_iii_ii_jj
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

