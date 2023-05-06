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
  int _2 = _A_extent_1 >> 7;
  int _3 = _aLoader_s0_i / _2;
  int _4 = _B_extent_0 >> 7;
  int _5 = _4 - _aLoader_s0_i;
  int _6 = _3 + _5;
  for (int _aLoader_s0_j = _aLoader_s0_i; _aLoader_s0_j < _aLoader_s0_i + _6; _aLoader_s0_j++)
  {
   int _7 = _A_extent_0 >> 7;
   for (int _aLoader_s0_k = 0; _aLoader_s0_k < 0 + _7; _aLoader_s0_k++)
   {
    for (int _aLoader_s0_kk_ii_iii = 0; _aLoader_s0_kk_ii_iii < 0 + 1024; _aLoader_s0_kk_ii_iii++)
    {
     bool _8 = _aLoader_s0_j == _aLoader_s0_i;
     bool _9 = _aLoader_s0_k == 0;
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
       int _17 = _A_extent_0 >> 7;
       int _18 = _17 * _aLoader_s0_i;
       int _19 = _18 * 1024;
       int _20 = _addr_temp;
       int _21 = _17 * 1024;
       int _22 = _20 % _21;
       int _23 = _19 + _22;
       int _24 = _23 * 16;
       float16 _25 = vload16(0, (__address_space__A_serializer_mem_channel float*)_A_serializer_mem_channel + _24);
       _14 = _25;
      } // if _16
      else
      {
       float _26 = float_from_bits(0 /* 0 */);
       float16 _27 = _26;
       _14 = _27;
      } // if _16 else
      float16 _28 = _14;
      write_channel_intel(_aLoader_aFeeder_channel, _28);
      (void)_28;
     } // if _13
     int _29 = _addr_temp;
     int _30 = _29 + 1;
     _addr_temp = _30;
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
  bool _31 = _aFeeder_s0_jjj_init == 0;
  if (_31)
  {
   uint _32 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   _aFeeder_cycle_temp = _32;
  } // if _31
 } // for _aFeeder_s0_jjj_init
 while(1)
 {
  uint _33 = (uint)(ADD_UINT64_T_SUFFIX(1024));
  uint _34 = _aFeeder_cycle_temp;
  uint _35 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _36 = _34 & _35;
  bool _37 = _33 <= _36;
  if (_37)
  {
   float16 __38 = read_channel_intel(_aLoader_aFeeder_channel);
   _aFeeder_in_v_temp = __38;
  } // if _37
  #pragma unroll
  for (int _aFeeder_s0_buf = 0; _aFeeder_s0_buf < 0 + 8; _aFeeder_s0_buf++)
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
   uint _52 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   uint _54 = _aFeeder_time_stamp_shreg;
   uint _55 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _56 = _54 & _55;
   bool _57 = _52 <= _56;
   if (_57)
   {
    uint _59 = _aFeeder_time_stamp_shreg;
    uint _60 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _61 = _59 & _60;
    uint _62 = (uint)(ADD_UINT64_T_SUFFIX(1024));
    uint _63 = _61 - _62;
    uint _64 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _65 = _63 & _64;
    int _66 = (int)(_65);
    bool _67 = _aFeeder_s0_buf == _66;
    if (_67)
    {
     float16 _69 = _aFeeder_value_shreg;
     uint _71 = _aFeeder_time_stamp_shreg;
     uint _72 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _73 = _71 >> _72;
     uint _74 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _75 = _73 & _74;
     bool _76 = (bool)(_75);
     uint _78 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _79 = _71 & _78;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(1024));
     uint _81 = _79 - _80;
     int _82 = (int)(_81);
     int _83 = _82 >> 7;
     int _85 = _82 >> 3;
     int _86 = _85 & 15;
     _aFeeder_DB_0_ibuffer[_76][_83][_86][_aFeeder_s0_buf] = _69;
    } // if _67
   } // if _57
   uint _87 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _89 = _aFeeder_time_stamp_shreg;
   uint _90 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _91 = _89 >> _90;
   bool _92 = _87 < _91;
   if (_92)
   {
    uint _94 = _aFeeder_time_stamp_shreg;
    uint _95 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _96 = _94 >> _95;
    uint _97 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _98 = _96 & _97;
    bool _99 = (bool)(_98);
    bool _100 = !(_99);
    uint _102 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _103 = _94 & _102;
    int _104 = (int)(_103);
    int _105 = _104 >> 8;
    int _107 = _104 >> 4;
    int _108 = _107 & 15;
    float16 _109 = _aFeeder_DB_0_ibuffer[_100][_105][_108][_aFeeder_s0_buf];
    _aFeeder_X_channel_array.s[_aFeeder_s0_buf] = _109;
    (void)_aFeeder_s0_buf;
   } // if _92
  } // for _aFeeder_s0_buf
  uint _110 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _112 = _aFeeder_time_stamp_shreg;
  uint _113 = (uint)(ADD_UINT64_T_SUFFIX(11));
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
 int _addr_temp;
 _addr_temp = 0;
 int _119 = _A_extent_1 >> 7;
 int _120 = _119 + 1;
 for (int _bLoader_s0_i = 0; _bLoader_s0_i < 0 + _120; _bLoader_s0_i++)
 {
  int _121 = _A_extent_1 >> 7;
  int _122 = _bLoader_s0_i / _121;
  int _123 = _B_extent_0 >> 7;
  int _124 = _123 - _bLoader_s0_i;
  int _125 = _122 + _124;
  for (int _bLoader_s0_j = _bLoader_s0_i; _bLoader_s0_j < _bLoader_s0_i + _125; _bLoader_s0_j++)
  {
   int _126 = _A_extent_0 >> 7;
   for (int _bLoader_s0_k = 0; _bLoader_s0_k < 0 + _126; _bLoader_s0_k++)
   {
    for (int _bLoader_s0_kk_jj_jjj = 0; _bLoader_s0_kk_jj_jjj < 0 + 1024; _bLoader_s0_kk_jj_jjj++)
    {
     bool _127 = _bLoader_s0_j == _bLoader_s0_i;
     bool _128 = _bLoader_s0_k == 0;
     bool _129 = _127 && _128;
     int _130 = _A_extent_1 >> 7;
     bool _131 = _bLoader_s0_i < _130;
     bool _132 = _129 || _131;
     if (_132)
     {
      float16 _133;
      int _134 = _A_extent_1 >> 7;
      bool _135 = _bLoader_s0_i < _134;
      if (_135)
      {
       int _136 = _A_extent_0 >> 7;
       int _137 = _136 * _bLoader_s0_j;
       int _138 = _137 * 1024;
       int _139 = _addr_temp;
       int _140 = _136 * 1024;
       int _141 = _139 % _140;
       int _142 = _138 + _141;
       int _143 = _142 * 16;
       float16 _144 = vload16(0, (__address_space__B_serializer_mem_channel float*)_B_serializer_mem_channel + _143);
       _133 = _144;
      } // if _135
      else
      {
       float _145 = float_from_bits(0 /* 0 */);
       float16 _146 = _145;
       _133 = _146;
      } // if _135 else
      float16 _147 = _133;
      write_channel_intel(_bLoader_bFeeder_channel, _147);
      (void)_147;
     } // if _132
     int _148 = _addr_temp;
     int _149 = _148 + 1;
     _addr_temp = _149;
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
  bool _150 = _bFeeder_s0_iii_init == 0;
  if (_150)
  {
   uint _151 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   _bFeeder_cycle_temp = _151;
  } // if _150
 } // for _bFeeder_s0_iii_init
 while(1)
 {
  uint _152 = (uint)(ADD_UINT64_T_SUFFIX(1024));
  uint _153 = _bFeeder_cycle_temp;
  uint _154 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _155 = _153 & _154;
  bool _156 = _152 <= _155;
  if (_156)
  {
   float16 __157 = read_channel_intel(_bLoader_bFeeder_channel);
   _bFeeder_in_v_temp = __157;
  } // if _156
  #pragma unroll
  for (int _bFeeder_s0_buf = 0; _bFeeder_s0_buf < 0 + 8; _bFeeder_s0_buf++)
  {
   bool _158 = _bFeeder_s0_buf == 0;
   if (_158)
   {
    float16 _159 = _bFeeder_in_v_temp;
    _bFeeder_value_shreg = _159;
    (void)_159;
    uint _160 = _bFeeder_cycle_temp;
    _bFeeder_time_stamp_shreg = _160;
    (void)_160;
   } // if _158
   else
   {
    float16 _162 = _bFeeder_value_shreg;
    _bFeeder_value_shreg = _162;
    (void)_162;
    uint _164 = _bFeeder_time_stamp_shreg;
    _bFeeder_time_stamp_shreg = _164;
    (void)_164;
   } // if _158 else
   float16 _166 = _bFeeder_value_shreg;
   float16 _167 = __fpga_reg(__fpga_reg(_166));
   _bFeeder_value_shreg = _167;
   (void)_167;
   uint _169 = _bFeeder_time_stamp_shreg;
   uint _170 = __fpga_reg(__fpga_reg(_169));
   _bFeeder_time_stamp_shreg = _170;
   (void)_170;
   uint _171 = (uint)(ADD_UINT64_T_SUFFIX(1024));
   uint _173 = _bFeeder_time_stamp_shreg;
   uint _174 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _175 = _173 & _174;
   bool _176 = _171 <= _175;
   if (_176)
   {
    uint _178 = _bFeeder_time_stamp_shreg;
    uint _179 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _180 = _178 & _179;
    uint _181 = (uint)(ADD_UINT64_T_SUFFIX(1024));
    uint _182 = _180 - _181;
    uint _183 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _184 = _182 & _183;
    int _185 = (int)(_184);
    bool _186 = _bFeeder_s0_buf == _185;
    if (_186)
    {
     float16 _188 = _bFeeder_value_shreg;
     uint _190 = _bFeeder_time_stamp_shreg;
     uint _191 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _192 = _190 >> _191;
     uint _193 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _194 = _192 & _193;
     bool _195 = (bool)(_194);
     uint _197 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _198 = _190 & _197;
     uint _199 = (uint)(ADD_UINT64_T_SUFFIX(1024));
     uint _200 = _198 - _199;
     int _201 = (int)(_200);
     int _202 = _201 >> 7;
     int _204 = _201 >> 3;
     int _205 = _204 & 15;
     _bFeeder_DB_0_ibuffer[_195][_202][_205][_bFeeder_s0_buf] = _188;
    } // if _186
   } // if _176
   uint _206 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _208 = _bFeeder_time_stamp_shreg;
   uint _209 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _210 = _208 >> _209;
   bool _211 = _206 < _210;
   if (_211)
   {
    uint _213 = _bFeeder_time_stamp_shreg;
    uint _214 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _215 = _213 >> _214;
    uint _216 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _217 = _215 & _216;
    bool _218 = (bool)(_217);
    bool _219 = !(_218);
    uint _221 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _222 = _213 & _221;
    int _223 = (int)(_222);
    int _224 = _223 >> 8;
    int _226 = _223 & 15;
    float16 _227 = _bFeeder_DB_0_ibuffer[_219][_224][_226][_bFeeder_s0_buf];
    _bFeeder_Y_channel_array.s[_bFeeder_s0_buf] = _227;
    (void)_bFeeder_s0_buf;
   } // if _211
  } // for _bFeeder_s0_buf
  uint _228 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _230 = _bFeeder_time_stamp_shreg;
  uint _231 = (uint)(ADD_UINT64_T_SUFFIX(11));
  uint _232 = _230 >> _231;
  bool _233 = _228 < _232;
  if (_233)
  {
   write_channel_intel(_bFeeder_Y_channel, _bFeeder_Y_channel_array);
   (void)_bFeeder_Y_channel_array;
  } // if _233
  uint _234 = _bFeeder_cycle_temp;
  uint _235 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _236 = _234 + _235;
  _bFeeder_cycle_temp = _236;
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
 int _237 = _A_extent_1 >> 7;
 int _238 = _237 + 1;
 int patch_temp = (2 * (_B_extent_0 >> 7) - (_A_extent_1 >> 7) + 1) * (_A_extent_1 >> 7) / 2;
 for (int _X_s0_i_j = 0; _X_s0_i_j < 0 + patch_temp + 1; _X_s0_i_j++)
 {
  {
   int _244 = _A_extent_0 >> 7;
   for (int _X_s0_k = 0; _X_s0_k < 0 + _244; _X_s0_k++)
   {
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 2048; _X_s0_kk_ii_jj++)
    {
     #pragma unroll
     for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 8; _dummy__1_s0_iii++)
     {
      #pragma unroll
      for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 8; _dummy_s0_jjj++)
      {
       float _246 = _Z_shreg[255][_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _246;
       #pragma unroll
       for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
       {
        int _247 = 255 - _dummy__2_s0_l1;
        int _248 = 254 - _dummy__2_s0_l1;
        float _250 = _Z_shreg[_248][_dummy_s0_jjj][_dummy__1_s0_iii];
        _Z_shreg[_247][_dummy_s0_jjj][_dummy__1_s0_iii] = _250;
        (void)_250;
       } // for _dummy__2_s0_l1
       float _251 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _251;
       (void)_251;
      } // for _dummy_s0_jjj
     } // for _dummy__1_s0_iii
     int _252 = _A_extent_1 >> 7;
     bool _253 = _X_s0_i_j < patch_temp;
     if (_253)
     {
      _cga __254 = read_channel_intel(_bFeeder_Y_channel);
      _bFeeder_Y_channel_array = __254;
      (void)__254;
      _cga __255 = read_channel_intel(_aFeeder_X_channel);
      _aFeeder_X_channel_array = __255;
      (void)__255;
     } // if _253
     #pragma unroll
     for (int _X_s0_iii = 0; _X_s0_iii < 0 + 8; _X_s0_iii++)
     {
      #pragma unroll
      for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 8; _X_s0_jjj++)
      {
       float16 _256;
       bool _257 = _X_s0_jjj == 0;
       if (_257)
       {
        float16 __258 = _aFeeder_X_channel_array.s[_X_s0_iii];
        _256 = __258;
       } // if _257
       else
       {
        float16 _260 = _X_shreg[_X_s0_iii];
        _256 = _260;
       } // if _257 else
       float16 _261 = _256;
       _X_shreg[_X_s0_iii] = _261;
       (void)_261;
       float16 _263 = _X_shreg[_X_s0_iii];
       float16 _264 = __fpga_reg(__fpga_reg(_263));
       _X_shreg[_X_s0_iii] = _264;
       (void)_264;
       float16 _265;
       bool _266 = _X_s0_iii == 0;
       if (_266)
       {
        float16 __267 = _bFeeder_Y_channel_array.s[_X_s0_jjj];
        _265 = __267;
       } // if _266
       else
       {
        float16 _269 = _Y_shreg[_X_s0_jjj];
        _265 = _269;
       } // if _266 else
       float16 _270 = _265;
       _Y_shreg[_X_s0_jjj] = _270;
       (void)_270;
       float16 _272 = _Y_shreg[_X_s0_jjj];
       float16 _273 = __fpga_reg(__fpga_reg(_272));
       _Y_shreg[_X_s0_jjj] = _273;
       (void)_273;
       float _274;
       bool _275 = _X_s0_k == 0;
       int _276 = _X_s0_kk_ii_jj >> 8;
       bool _277 = _276 == 0;
       bool _278 = _275 && _277;
       if (_278)
       {
        float _279 = float_from_bits(0 /* 0 */);
        _274 = _279;
       } // if _278
       else
       {
        float _281 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
        float _282 = __fpga_reg(_281);
        _274 = _282;
       } // if _278 else
       float _283 = _274;
       _Z_shreg_temp = _283;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
       {
        float _284 = _Z_shreg_temp;
        float _286 = _X_shreg[_X_s0_iii][_X_s0_kkk];
        float _288 = _Y_shreg[_X_s0_jjj][_X_s0_kkk];
        float _289 = _286 * _288;
        float _290 = _284 + _289;
        _Z_shreg_temp = _290;
        int _291 = _X_s0_kkk & 3;
        bool _292 = _291 == 3;
        if (_292)
        {
         float _293 = _Z_shreg_temp;
         float _294 = __fpga_reg(_293);
         _Z_shreg_temp = _294;
        } // if _292
       } // for _X_s0_kkk
       float _295 = _Z_shreg_temp;
       _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _295;
       (void)_295;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 16; _X_s0_kkk++)
       {
        bool _296 = _X_s0_kkk == 15;
        int _297 = _X_s0_kk_ii_jj >> 8;
        bool _298 = _297 == 7;
        bool _299 = _296 && _298;
        int _300 = _A_extent_0 >> 7;
        int _301 = _300 + -1;
        bool _302 = _X_s0_k == _301;
        bool _303 = _299 && _302;
        if (_303)
        {
         int _304 = _X_s0_iii * 256;
         float _306 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
         _Z_pipe_shreg[_X_s0_jjj][_304] = _306;
         (void)_306;
        } // if _303
       } // for _X_s0_kkk
      } // for _X_s0_jjj
     } // for _X_s0_iii
     int _307 = _X_s0_kk_ii_jj & 15;
     bool _308 = _307 == 0;
     int _309 = _X_s0_kk_ii_jj & 255;
     int _310 = _309 >> 4;
     bool _311 = _310 == 0;
     bool _312 = _308 && _311;
     int _313 = _A_extent_0 >> 7;
     int _314 = _313 + -1;
     bool _315 = _X_s0_k == _314;
     bool _316 = _312 && _315;
     int _317 = _X_s0_kk_ii_jj >> 8;
     bool _318 = _317 == 7;
     bool _319 = _316 && _318;
     int _320 = _A_extent_1 >> 7;
     bool _321 = _X_s0_i_j < patch_temp;
     bool _322 = _319 && _321;
     if (_322)
     {
      int _323 = _Z_pipe_iter_temp;
      _Z_pipe_base_temp = _323;
     } // if _322
     float8 _Out_unloader_channel_temp;
     #pragma unroll
     for (int _Z_pipe_b__14 = 0; _Z_pipe_b__14 < 0 + 8; _Z_pipe_b__14++)
     {
      float _325 = _Z_pipe_shreg[_Z_pipe_b__14][0];
      _Out_unloader_channel_temp[_Z_pipe_b__14] = _325;
      #pragma unroll
      for (int _Z_pipe_b__14_dummy = 0; _Z_pipe_b__14_dummy < 0 + 8; _Z_pipe_b__14_dummy++)
      {
       float _326 = _Out_unloader_channel_temp[_Z_pipe_b__14_dummy];
       float _327 = __fpga_reg(__fpga_reg(_326));
       _Out_unloader_channel_temp[_Z_pipe_b__14_dummy] = _327;
      } // for _Z_pipe_b__14_dummy
     } // for _Z_pipe_b__14
     int _328 = _Z_pipe_iter_temp;
     int _329 = _Z_pipe_base_temp;
     int _330 = _329 + 2048;
     bool _331 = _328 < _330;
     if (_331)
     {
      float8 _332 = _Out_unloader_channel_temp;
      write_channel_intel(_Out_unloader_channel, _332);
      (void)_332;
     } // if _331
     #pragma unroll
     for (int _Z_pipe_b__15 = 0; _Z_pipe_b__15 < 0 + 8; _Z_pipe_b__15++)
     {
      #pragma unroll
      for (int _Z_pipe_p__7 = 0; _Z_pipe_p__7 < 0 + 7; _Z_pipe_p__7++)
      {
       #pragma unroll
       for (int _Z_pipe_l__7 = 0; _Z_pipe_l__7 < 0 + 255; _Z_pipe_l__7++)
       {
        int _333 = _Z_pipe_p__7 * 256;
        int _334 = _333 + _Z_pipe_l__7;
        int _335 = _334 + 1;
        float _337 = _Z_pipe_shreg[_Z_pipe_b__15][_335];
        _Z_pipe_shreg[_Z_pipe_b__15][_334] = _337;
        (void)_337;
       } // for _Z_pipe_l__7
       int _338 = _Z_pipe_p__7 * 256;
       int _339 = _338 + 255;
       int _340 = _338 + 256;
       float _342 = _Z_pipe_shreg[_Z_pipe_b__15][_340];
       float _343 = __fpga_reg(__fpga_reg(_342));
       _Z_pipe_shreg[_Z_pipe_b__15][_339] = _343;
       (void)_343;
      } // for _Z_pipe_p__7
     } // for _Z_pipe_b__15
     int _344 = _Z_pipe_iter_temp;
     int _345 = _344 + 1;
     _Z_pipe_iter_temp = _345;
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
 int _346 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _346; _unloader_s0_i++)
 {
  int _347 = _B_extent_0 >> 7;
  int _348 = _347 - _unloader_s0_i;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < _unloader_s0_i + _348; _unloader_s0_j++)
  {
   for (int _unloader_s0_iii_ii_jj = 0; _unloader_s0_iii_ii_jj < 0 + 2048; _unloader_s0_iii_ii_jj++)
   {
    float8 __349 = read_channel_intel(_Out_unloader_channel);
    int _350 = _addr_temp;
    int _351 = _350 * 8;
    vstore8(__349, 0, (__address_space__unloader_mem_channel float*)_unloader_mem_channel + _351);
    int _352 = _addr_temp;
    int _353 = _352 + 1;
    _addr_temp = _353;
   } // for _unloader_s0_iii_ii_jj
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

