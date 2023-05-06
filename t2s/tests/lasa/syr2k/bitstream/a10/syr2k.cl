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
bool __attribute__ ((aligned(8))) s[8];
struct {bool s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7;};
} bool8;
typedef struct { float8 s[8]; } _cga__1;
channel float8 _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _aFeeder_X_channel __attribute__((depth(256))) ;
channel float8 _bLoader_bFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _bFeeder_Y_channel __attribute__((depth(256))) ;
channel float8 _Out_Add_channel __attribute__((depth(256))) ;
channel float8 _aLoader_T_aFeeder_T_channel __attribute__((depth(256))) ;
channel _cga__1 _aFeeder_T_X_T_channel __attribute__((depth(256))) ;
channel float8 _bLoader_T_bFeeder_T_channel __attribute__((depth(256))) ;
channel _cga__1 _bFeeder_T_Y_T_channel __attribute__((depth(256))) ;
channel float8 _Out_T_Add_channel __attribute__((depth(256))) ;
channel float8 _Add_unloader_channel __attribute__((depth(0))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_X_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_X_serializer_mem_channel const float *restrict _A_X_serializer_mem_channel)
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
    for (int _aLoader_s0_kk_ii_iii = 0; _aLoader_s0_kk_ii_iii < 0 + 2048; _aLoader_s0_kk_ii_iii++)
    {
     bool _8 = _aLoader_s0_j == _aLoader_s0_i;
     bool _9 = _aLoader_s0_k == 0;
     bool _10 = _8 && _9;
     int _11 = _A_extent_1 >> 7;
     bool _12 = _aLoader_s0_i < _11;
     bool _13 = _10 || _12;
     if (_13)
     {
      float8 _14;
      int _15 = _A_extent_1 >> 7;
      bool _16 = _aLoader_s0_i < _15;
      if (_16)
      {
       int _17 = _A_extent_0 >> 7;
       int _18 = _17 * _aLoader_s0_i;
       int _19 = _18 * 2048;
       int _20 = _addr_temp;
       int _21 = _17 * 2048;
       int _22 = _20 % _21;
       int _23 = _19 + _22;
       int _24 = _23 * 8;
       float8 _25 = vload8(0, (__address_space__A_X_serializer_mem_channel float*)_A_X_serializer_mem_channel + _24);
       _14 = _25;
      } // if _16
      else
      {
       float _26 = float_from_bits(0 /* 0 */);
       float8 _27 = _26;
       _14 = _27;
      } // if _16 else
      float8 _28 = _14;
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
#undef __address_space__A_X_serializer_mem_channel
// Address spaces for kernel_aFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_aFeeder(
)
{
 _cga__1 _aFeeder_X_channel_array;
 float8 _aFeeder_value_shreg;
 uint _aFeeder_time_stamp_shreg;
 float8 _aFeeder_in_v_temp;
 uint _aFeeder_cycle_temp;
 float8 __attribute__((memory, numbanks(8), singlepump)) _aFeeder_DB_0_ibuffer[2][16][16][8];
 #pragma unroll
 for (int _aFeeder_s0_jjj_init = 0; _aFeeder_s0_jjj_init < 0 + 8; _aFeeder_s0_jjj_init++)
 {
  bool _31 = _aFeeder_s0_jjj_init == 0;
  if (_31)
  {
   uint _32 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   _aFeeder_cycle_temp = _32;
  } // if _31
 } // for _aFeeder_s0_jjj_init
 while(1)
 {
  uint _33 = (uint)(ADD_UINT64_T_SUFFIX(2048));
  uint _34 = _aFeeder_cycle_temp;
  uint _35 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _36 = _34 & _35;
  bool _37 = _33 <= _36;
  if (_37)
  {
   float8 __38 = read_channel_intel(_aLoader_aFeeder_channel);
   _aFeeder_in_v_temp = __38;
  } // if _37
  #pragma unroll
  for (int _aFeeder_s0_buf = 0; _aFeeder_s0_buf < 0 + 8; _aFeeder_s0_buf++)
  {
   bool _39 = _aFeeder_s0_buf == 0;
   if (_39)
   {
    float8 _40 = _aFeeder_in_v_temp;
    _aFeeder_value_shreg = _40;
    (void)_40;
    uint _41 = _aFeeder_cycle_temp;
    _aFeeder_time_stamp_shreg = _41;
    (void)_41;
   } // if _39
   else
   {
    float8 _43 = _aFeeder_value_shreg;
    _aFeeder_value_shreg = _43;
    (void)_43;
    uint _45 = _aFeeder_time_stamp_shreg;
    _aFeeder_time_stamp_shreg = _45;
    (void)_45;
   } // if _39 else
   float8 _47 = _aFeeder_value_shreg;
   float8 _48 = __fpga_reg(__fpga_reg(_47));
   _aFeeder_value_shreg = _48;
   (void)_48;
   uint _50 = _aFeeder_time_stamp_shreg;
   uint _51 = __fpga_reg(__fpga_reg(_50));
   _aFeeder_time_stamp_shreg = _51;
   (void)_51;
   uint _52 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   uint _54 = _aFeeder_time_stamp_shreg;
   uint _55 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _56 = _54 & _55;
   bool _57 = _52 <= _56;
   if (_57)
   {
    uint _59 = _aFeeder_time_stamp_shreg;
    uint _60 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _61 = _59 & _60;
    uint _62 = (uint)(ADD_UINT64_T_SUFFIX(2048));
    uint _63 = _61 - _62;
    uint _64 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _65 = _63 & _64;
    int _66 = (int)(_65);
    bool _67 = _aFeeder_s0_buf == _66;
    if (_67)
    {
     float8 _69 = _aFeeder_value_shreg;
     uint _71 = _aFeeder_time_stamp_shreg;
     uint _72 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _73 = _71 >> _72;
     uint _74 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _75 = _73 & _74;
     bool _76 = (bool)(_75);
     uint _78 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _79 = _71 & _78;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(2048));
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
   uint _90 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _91 = _89 >> _90;
   bool _92 = _87 < _91;
   if (_92)
   {
    uint _94 = _aFeeder_time_stamp_shreg;
    uint _95 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _96 = _94 >> _95;
    uint _97 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _98 = _96 & _97;
    bool _99 = (bool)(_98);
    bool _100 = !(_99);
    uint _102 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _103 = _94 & _102;
    int _104 = (int)(_103);
    int _105 = _104 >> 8;
    int _107 = _104 >> 4;
    int _108 = _107 & 15;
    float8 _109 = _aFeeder_DB_0_ibuffer[_100][_105][_108][_aFeeder_s0_buf];
    _aFeeder_X_channel_array.s[_aFeeder_s0_buf] = _109;
    (void)_aFeeder_s0_buf;
   } // if _92
  } // for _aFeeder_s0_buf
  uint _110 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _112 = _aFeeder_time_stamp_shreg;
  uint _113 = (uint)(ADD_UINT64_T_SUFFIX(12));
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
#define __address_space__B_Y_serializer_mem_channel __global
__kernel void kernel_bLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__B_Y_serializer_mem_channel const float *restrict _B_Y_serializer_mem_channel)
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
    for (int _bLoader_s0_kk_jj_jjj = 0; _bLoader_s0_kk_jj_jjj < 0 + 2048; _bLoader_s0_kk_jj_jjj++)
    {
     bool _127 = _bLoader_s0_j == _bLoader_s0_i;
     bool _128 = _bLoader_s0_k == 0;
     bool _129 = _127 && _128;
     int _130 = _A_extent_1 >> 7;
     bool _131 = _bLoader_s0_i < _130;
     bool _132 = _129 || _131;
     if (_132)
     {
      float8 _133;
      int _134 = _A_extent_1 >> 7;
      bool _135 = _bLoader_s0_i < _134;
      if (_135)
      {
       int _136 = _A_extent_0 >> 7;
       int _137 = _136 * _bLoader_s0_j;
       int _138 = _137 * 2048;
       int _139 = _addr_temp;
       int _140 = _136 * 2048;
       int _141 = _139 % _140;
       int _142 = _138 + _141;
       int _143 = _142 * 8;
       float8 _144 = vload8(0, (__address_space__B_Y_serializer_mem_channel float*)_B_Y_serializer_mem_channel + _143);
       _133 = _144;
      } // if _135
      else
      {
       float _145 = float_from_bits(0 /* 0 */);
       float8 _146 = _145;
       _133 = _146;
      } // if _135 else
      float8 _147 = _133;
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
#undef __address_space__B_Y_serializer_mem_channel
// Address spaces for kernel_bFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_bFeeder(
)
{
 _cga__1 _bFeeder_Y_channel_array;
 float8 _bFeeder_value_shreg;
 uint _bFeeder_time_stamp_shreg;
 float8 _bFeeder_in_v_temp;
 uint _bFeeder_cycle_temp;
 float8 __attribute__((memory, numbanks(8), singlepump)) _bFeeder_DB_0_ibuffer[2][16][16][8];
 #pragma unroll
 for (int _bFeeder_s0_iii_init = 0; _bFeeder_s0_iii_init < 0 + 8; _bFeeder_s0_iii_init++)
 {
  bool _150 = _bFeeder_s0_iii_init == 0;
  if (_150)
  {
   uint _151 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   _bFeeder_cycle_temp = _151;
  } // if _150
 } // for _bFeeder_s0_iii_init
 while(1)
 {
  uint _152 = (uint)(ADD_UINT64_T_SUFFIX(2048));
  uint _153 = _bFeeder_cycle_temp;
  uint _154 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _155 = _153 & _154;
  bool _156 = _152 <= _155;
  if (_156)
  {
   float8 __157 = read_channel_intel(_bLoader_bFeeder_channel);
   _bFeeder_in_v_temp = __157;
  } // if _156
  #pragma unroll
  for (int _bFeeder_s0_buf = 0; _bFeeder_s0_buf < 0 + 8; _bFeeder_s0_buf++)
  {
   bool _158 = _bFeeder_s0_buf == 0;
   if (_158)
   {
    float8 _159 = _bFeeder_in_v_temp;
    _bFeeder_value_shreg = _159;
    (void)_159;
    uint _160 = _bFeeder_cycle_temp;
    _bFeeder_time_stamp_shreg = _160;
    (void)_160;
   } // if _158
   else
   {
    float8 _162 = _bFeeder_value_shreg;
    _bFeeder_value_shreg = _162;
    (void)_162;
    uint _164 = _bFeeder_time_stamp_shreg;
    _bFeeder_time_stamp_shreg = _164;
    (void)_164;
   } // if _158 else
   float8 _166 = _bFeeder_value_shreg;
   float8 _167 = __fpga_reg(__fpga_reg(_166));
   _bFeeder_value_shreg = _167;
   (void)_167;
   uint _169 = _bFeeder_time_stamp_shreg;
   uint _170 = __fpga_reg(__fpga_reg(_169));
   _bFeeder_time_stamp_shreg = _170;
   (void)_170;
   uint _171 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   uint _173 = _bFeeder_time_stamp_shreg;
   uint _174 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _175 = _173 & _174;
   bool _176 = _171 <= _175;
   if (_176)
   {
    uint _178 = _bFeeder_time_stamp_shreg;
    uint _179 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _180 = _178 & _179;
    uint _181 = (uint)(ADD_UINT64_T_SUFFIX(2048));
    uint _182 = _180 - _181;
    uint _183 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _184 = _182 & _183;
    int _185 = (int)(_184);
    bool _186 = _bFeeder_s0_buf == _185;
    if (_186)
    {
     float8 _188 = _bFeeder_value_shreg;
     uint _190 = _bFeeder_time_stamp_shreg;
     uint _191 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _192 = _190 >> _191;
     uint _193 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _194 = _192 & _193;
     bool _195 = (bool)(_194);
     uint _197 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _198 = _190 & _197;
     uint _199 = (uint)(ADD_UINT64_T_SUFFIX(2048));
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
   uint _209 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _210 = _208 >> _209;
   bool _211 = _206 < _210;
   if (_211)
   {
    uint _213 = _bFeeder_time_stamp_shreg;
    uint _214 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _215 = _213 >> _214;
    uint _216 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _217 = _215 & _216;
    bool _218 = (bool)(_217);
    bool _219 = !(_218);
    uint _221 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _222 = _213 & _221;
    int _223 = (int)(_222);
    int _224 = _223 >> 8;
    int _226 = _223 & 15;
    float8 _227 = _bFeeder_DB_0_ibuffer[_219][_224][_226][_bFeeder_s0_buf];
    _bFeeder_Y_channel_array.s[_bFeeder_s0_buf] = _227;
    (void)_bFeeder_s0_buf;
   } // if _211
  } // for _bFeeder_s0_buf
  uint _228 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _230 = _bFeeder_time_stamp_shreg;
  uint _231 = (uint)(ADD_UINT64_T_SUFFIX(12));
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
 float8 _Y_shreg[8];
 float _Z_temp[8][8];
 // produce X
 float8 _X_shreg[8];
 _cga__1 _bFeeder_Y_channel_array;
 _cga__1 _aFeeder_X_channel_array;
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
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 4096; _X_s0_kk_ii_jj++)
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
      _cga__1 __254 = read_channel_intel(_bFeeder_Y_channel);
      _bFeeder_Y_channel_array = __254;
      (void)__254;
      _cga__1 __255 = read_channel_intel(_aFeeder_X_channel);
      _aFeeder_X_channel_array = __255;
      (void)__255;
     } // if _253
     #pragma unroll
     for (int _X_s0_iii = 0; _X_s0_iii < 0 + 8; _X_s0_iii++)
     {
      #pragma unroll
      for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 8; _X_s0_jjj++)
      {
       float8 _256;
       bool _257 = _X_s0_jjj == 0;
       if (_257)
       {
        float8 __258 = _aFeeder_X_channel_array.s[_X_s0_iii];
        _256 = __258;
       } // if _257
       else
       {
        float8 _260 = _X_shreg[_X_s0_iii];
        _256 = _260;
       } // if _257 else
       float8 _261 = _256;
       _X_shreg[_X_s0_iii] = _261;
       (void)_261;
       float8 _263 = _X_shreg[_X_s0_iii];
       float8 _264 = __fpga_reg(__fpga_reg(_263));
       _X_shreg[_X_s0_iii] = _264;
       (void)_264;
       float8 _265;
       bool _266 = _X_s0_iii == 0;
       if (_266)
       {
        float8 __267 = _bFeeder_Y_channel_array.s[_X_s0_jjj];
        _265 = __267;
       } // if _266
       else
       {
        float8 _269 = _Y_shreg[_X_s0_jjj];
        _265 = _269;
       } // if _266 else
       float8 _270 = _265;
       _Y_shreg[_X_s0_jjj] = _270;
       (void)_270;
       float8 _272 = _Y_shreg[_X_s0_jjj];
       float8 _273 = __fpga_reg(__fpga_reg(_272));
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
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
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
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
       {
        bool _296 = _X_s0_kkk == 7;
        int _297 = _X_s0_kk_ii_jj >> 8;
        bool _298 = _297 == 15;
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
     bool _318 = _317 == 15;
     bool _319 = _316 && _318;
     int _320 = _A_extent_1 >> 7;
     bool _321 = _X_s0_i_j < patch_temp;
     bool _322 = _319 && _321;
     if (_322)
     {
      int _323 = _Z_pipe_iter_temp;
      _Z_pipe_base_temp = _323;
     } // if _322
     float8 _Out_Add_channel_temp;
     #pragma unroll
     for (int _Z_pipe_b__14 = 0; _Z_pipe_b__14 < 0 + 8; _Z_pipe_b__14++)
     {
      float _325 = _Z_pipe_shreg[_Z_pipe_b__14][0];
      _Out_Add_channel_temp[_Z_pipe_b__14] = _325;
      #pragma unroll
      for (int _Z_pipe_b__14_dummy = 0; _Z_pipe_b__14_dummy < 0 + 8; _Z_pipe_b__14_dummy++)
      {
       float _326 = _Out_Add_channel_temp[_Z_pipe_b__14_dummy];
       float _327 = __fpga_reg(__fpga_reg(_326));
       _Out_Add_channel_temp[_Z_pipe_b__14_dummy] = _327;
      } // for _Z_pipe_b__14_dummy
     } // for _Z_pipe_b__14
     int _328 = _Z_pipe_iter_temp;
     int _329 = _Z_pipe_base_temp;
     int _330 = _329 + 2048;
     bool _331 = _328 < _330;
     if (_331)
     {
      float8 _332 = _Out_Add_channel_temp;
      write_channel_intel(_Out_Add_channel, _332);
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
// Address spaces for kernel_aLoader_T
#define __address_space__A_X_T_serializer_mem_channel __global
__kernel void kernel_aLoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_X_T_serializer_mem_channel const float *restrict _A_X_T_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _346 = _B_extent_0 >> 7;
 int _347 = _346 + 1;
 for (int _aLoader_T_s0_j = 0; _aLoader_T_s0_j < 0 + _347; _aLoader_T_s0_j++)
 {
  int _348 = _B_extent_0 >> 7;
  int _349 = _aLoader_T_s0_j / _348;
  int _350 = _A_extent_1 >> 7;
  int _351 = _350 - _aLoader_T_s0_j;
  int _352 = _349 + _351;
  for (int _aLoader_T_s0_i = _aLoader_T_s0_j; _aLoader_T_s0_i < _aLoader_T_s0_j + _352; _aLoader_T_s0_i++)
  {
   int _353 = _A_extent_0 >> 7;
   for (int _aLoader_T_s0_k = 0; _aLoader_T_s0_k < 0 + _353; _aLoader_T_s0_k++)
   {
    for (int _aLoader_T_s0_kk_ii_iii = 0; _aLoader_T_s0_kk_ii_iii < 0 + 2048; _aLoader_T_s0_kk_ii_iii++)
    {
     bool _354 = _aLoader_T_s0_i == _aLoader_T_s0_j;
     bool _355 = _aLoader_T_s0_k == 0;
     bool _356 = _354 && _355;
     int _357 = _B_extent_0 >> 7;
     bool _358 = _aLoader_T_s0_j < _357;
     bool _359 = _356 || _358;
     if (_359)
     {
      float8 _360;
      int _361 = _B_extent_0 >> 7;
      bool _362 = _aLoader_T_s0_j < _361;
      if (_362)
      {
       int _363 = _A_extent_0 >> 7;
       int _364 = _363 * _aLoader_T_s0_i;
       int _365 = _364 * 2048;
       int _366 = _addr_temp;
       int _367 = _363 * 2048;
       int _368 = _366 % _367;
       int _369 = _365 + _368;
       int _370 = _369 * 8;
       float8 _371 = vload8(0, (__address_space__A_X_T_serializer_mem_channel float*)_A_X_T_serializer_mem_channel + _370);
       _360 = _371;
      } // if _362
      else
      {
       float _372 = float_from_bits(0 /* 0 */);
       float8 _373 = _372;
       _360 = _373;
      } // if _362 else
      float8 _374 = _360;
      write_channel_intel(_aLoader_T_aFeeder_T_channel, _374);
      (void)_374;
     } // if _359
     int _375 = _addr_temp;
     int _376 = _375 + 1;
     _addr_temp = _376;
    } // for _aLoader_T_s0_kk_ii_iii
   } // for _aLoader_T_s0_k
  } // for _aLoader_T_s0_i
 } // for _aLoader_T_s0_j
} // kernel kernel_aLoader_T
#undef __address_space__A_X_T_serializer_mem_channel
// Address spaces for kernel_aFeeder_T
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_aFeeder_T(
)
{
 _cga__1 _aFeeder_T_X_T_channel_array;
 float8 _aFeeder_T_value_shreg;
 uint _aFeeder_T_time_stamp_shreg;
 float8 _aFeeder_T_in_v_temp;
 uint _aFeeder_T_cycle_temp;
 float8 __attribute__((memory, numbanks(8), singlepump)) _aFeeder_T_DB_0_ibuffer[2][16][16][8];
 #pragma unroll
 for (int _aFeeder_T_s0_jjj_init = 0; _aFeeder_T_s0_jjj_init < 0 + 8; _aFeeder_T_s0_jjj_init++)
 {
  bool _377 = _aFeeder_T_s0_jjj_init == 0;
  if (_377)
  {
   uint _378 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   _aFeeder_T_cycle_temp = _378;
  } // if _377
 } // for _aFeeder_T_s0_jjj_init
 while(1)
 {
  uint _379 = (uint)(ADD_UINT64_T_SUFFIX(2048));
  uint _380 = _aFeeder_T_cycle_temp;
  uint _381 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _382 = _380 & _381;
  bool _383 = _379 <= _382;
  if (_383)
  {
   float8 __384 = read_channel_intel(_aLoader_T_aFeeder_T_channel);
   _aFeeder_T_in_v_temp = __384;
  } // if _383
  #pragma unroll
  for (int _aFeeder_T_s0_buf = 0; _aFeeder_T_s0_buf < 0 + 8; _aFeeder_T_s0_buf++)
  {
   bool _385 = _aFeeder_T_s0_buf == 0;
   if (_385)
   {
    float8 _386 = _aFeeder_T_in_v_temp;
    _aFeeder_T_value_shreg = _386;
    (void)_386;
    uint _387 = _aFeeder_T_cycle_temp;
    _aFeeder_T_time_stamp_shreg = _387;
    (void)_387;
   } // if _385
   else
   {
    float8 _389 = _aFeeder_T_value_shreg;
    _aFeeder_T_value_shreg = _389;
    (void)_389;
    uint _391 = _aFeeder_T_time_stamp_shreg;
    _aFeeder_T_time_stamp_shreg = _391;
    (void)_391;
   } // if _385 else
   float8 _393 = _aFeeder_T_value_shreg;
   float8 _394 = __fpga_reg(__fpga_reg(_393));
   _aFeeder_T_value_shreg = _394;
   (void)_394;
   uint _396 = _aFeeder_T_time_stamp_shreg;
   uint _397 = __fpga_reg(__fpga_reg(_396));
   _aFeeder_T_time_stamp_shreg = _397;
   (void)_397;
   uint _398 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   uint _400 = _aFeeder_T_time_stamp_shreg;
   uint _401 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _402 = _400 & _401;
   bool _403 = _398 <= _402;
   if (_403)
   {
    uint _405 = _aFeeder_T_time_stamp_shreg;
    uint _406 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _407 = _405 & _406;
    uint _408 = (uint)(ADD_UINT64_T_SUFFIX(2048));
    uint _409 = _407 - _408;
    uint _410 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _411 = _409 & _410;
    int _412 = (int)(_411);
    bool _413 = _aFeeder_T_s0_buf == _412;
    if (_413)
    {
     float8 _415 = _aFeeder_T_value_shreg;
     uint _417 = _aFeeder_T_time_stamp_shreg;
     uint _418 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _419 = _417 >> _418;
     uint _420 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _421 = _419 & _420;
     bool _422 = (bool)(_421);
     uint _424 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _425 = _417 & _424;
     uint _426 = (uint)(ADD_UINT64_T_SUFFIX(2048));
     uint _427 = _425 - _426;
     int _428 = (int)(_427);
     int _429 = _428 >> 7;
     int _431 = _428 >> 3;
     int _432 = _431 & 15;
     _aFeeder_T_DB_0_ibuffer[_422][_429][_432][_aFeeder_T_s0_buf] = _415;
    } // if _413
   } // if _403
   uint _433 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _435 = _aFeeder_T_time_stamp_shreg;
   uint _436 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _437 = _435 >> _436;
   bool _438 = _433 < _437;
   if (_438)
   {
    uint _440 = _aFeeder_T_time_stamp_shreg;
    uint _441 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _442 = _440 >> _441;
    uint _443 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _444 = _442 & _443;
    bool _445 = (bool)(_444);
    bool _446 = !(_445);
    uint _448 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _449 = _440 & _448;
    int _450 = (int)(_449);
    int _451 = _450 >> 8;
    int _453 = _450 & 15;
    float8 _454 = _aFeeder_T_DB_0_ibuffer[_446][_451][_453][_aFeeder_T_s0_buf];
    _aFeeder_T_X_T_channel_array.s[_aFeeder_T_s0_buf] = _454;
    (void)_aFeeder_T_s0_buf;
   } // if _438
  } // for _aFeeder_T_s0_buf
  uint _455 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _457 = _aFeeder_T_time_stamp_shreg;
  uint _458 = (uint)(ADD_UINT64_T_SUFFIX(12));
  uint _459 = _457 >> _458;
  bool _460 = _455 < _459;
  if (_460)
  {
   write_channel_intel(_aFeeder_T_X_T_channel, _aFeeder_T_X_T_channel_array);
   (void)_aFeeder_T_X_T_channel_array;
  } // if _460
  uint _461 = _aFeeder_T_cycle_temp;
  uint _462 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _463 = _461 + _462;
  _aFeeder_T_cycle_temp = _463;
 } // while _aFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_aFeeder_T
// Address spaces for kernel_bLoader_T
#define __address_space__B_Y_T_serializer_mem_channel __global
__kernel void kernel_bLoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__B_Y_T_serializer_mem_channel const float *restrict _B_Y_T_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _464 = _B_extent_0 >> 7;
 int _465 = _464 + 1;
 for (int _bLoader_T_s0_j = 0; _bLoader_T_s0_j < 0 + _465; _bLoader_T_s0_j++)
 {
  int _466 = _B_extent_0 >> 7;
  int _467 = _bLoader_T_s0_j / _466;
  int _468 = _A_extent_1 >> 7;
  int _469 = _468 - _bLoader_T_s0_j;
  int _470 = _467 + _469;
  for (int _bLoader_T_s0_i = _bLoader_T_s0_j; _bLoader_T_s0_i < _bLoader_T_s0_j + _470; _bLoader_T_s0_i++)
  {
   int _471 = _A_extent_0 >> 7;
   for (int _bLoader_T_s0_k = 0; _bLoader_T_s0_k < 0 + _471; _bLoader_T_s0_k++)
   {
    for (int _bLoader_T_s0_kk_jj_jjj = 0; _bLoader_T_s0_kk_jj_jjj < 0 + 2048; _bLoader_T_s0_kk_jj_jjj++)
    {
     bool _472 = _bLoader_T_s0_i == _bLoader_T_s0_j;
     bool _473 = _bLoader_T_s0_k == 0;
     bool _474 = _472 && _473;
     int _475 = _B_extent_0 >> 7;
     bool _476 = _bLoader_T_s0_j < _475;
     bool _477 = _474 || _476;
     if (_477)
     {
      float8 _478;
      int _479 = _B_extent_0 >> 7;
      bool _480 = _bLoader_T_s0_j < _479;
      if (_480)
      {
       int _481 = _A_extent_0 >> 7;
       int _482 = _481 * _bLoader_T_s0_j;
       int _483 = _482 * 2048;
       int _484 = _addr_temp;
       int _485 = _481 * 2048;
       int _486 = _484 % _485;
       int _487 = _483 + _486;
       int _488 = _487 * 8;
       float8 _489 = vload8(0, (__address_space__B_Y_T_serializer_mem_channel float*)_B_Y_T_serializer_mem_channel + _488);
       _478 = _489;
      } // if _480
      else
      {
       float _490 = float_from_bits(0 /* 0 */);
       float8 _491 = _490;
       _478 = _491;
      } // if _480 else
      float8 _492 = _478;
      write_channel_intel(_bLoader_T_bFeeder_T_channel, _492);
      (void)_492;
     } // if _477
     int _493 = _addr_temp;
     int _494 = _493 + 1;
     _addr_temp = _494;
    } // for _bLoader_T_s0_kk_jj_jjj
   } // for _bLoader_T_s0_k
  } // for _bLoader_T_s0_i
 } // for _bLoader_T_s0_j
} // kernel kernel_bLoader_T
#undef __address_space__B_Y_T_serializer_mem_channel
// Address spaces for kernel_bFeeder_T
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_bFeeder_T(
)
{
 _cga__1 _bFeeder_T_Y_T_channel_array;
 float8 _bFeeder_T_value_shreg;
 uint _bFeeder_T_time_stamp_shreg;
 float8 _bFeeder_T_in_v_temp;
 uint _bFeeder_T_cycle_temp;
 float8 __attribute__((memory, numbanks(8), singlepump)) _bFeeder_T_DB_0_ibuffer[2][16][16][8];
 #pragma unroll
 for (int _bFeeder_T_s0_iii_init = 0; _bFeeder_T_s0_iii_init < 0 + 8; _bFeeder_T_s0_iii_init++)
 {
  bool _495 = _bFeeder_T_s0_iii_init == 0;
  if (_495)
  {
   uint _496 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   _bFeeder_T_cycle_temp = _496;
  } // if _495
 } // for _bFeeder_T_s0_iii_init
 while(1)
 {
  uint _497 = (uint)(ADD_UINT64_T_SUFFIX(2048));
  uint _498 = _bFeeder_T_cycle_temp;
  uint _499 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _500 = _498 & _499;
  bool _501 = _497 <= _500;
  if (_501)
  {
   float8 __502 = read_channel_intel(_bLoader_T_bFeeder_T_channel);
   _bFeeder_T_in_v_temp = __502;
  } // if _501
  #pragma unroll
  for (int _bFeeder_T_s0_buf = 0; _bFeeder_T_s0_buf < 0 + 8; _bFeeder_T_s0_buf++)
  {
   bool _503 = _bFeeder_T_s0_buf == 0;
   if (_503)
   {
    float8 _504 = _bFeeder_T_in_v_temp;
    _bFeeder_T_value_shreg = _504;
    (void)_504;
    uint _505 = _bFeeder_T_cycle_temp;
    _bFeeder_T_time_stamp_shreg = _505;
    (void)_505;
   } // if _503
   else
   {
    float8 _507 = _bFeeder_T_value_shreg;
    _bFeeder_T_value_shreg = _507;
    (void)_507;
    uint _509 = _bFeeder_T_time_stamp_shreg;
    _bFeeder_T_time_stamp_shreg = _509;
    (void)_509;
   } // if _503 else
   float8 _511 = _bFeeder_T_value_shreg;
   float8 _512 = __fpga_reg(__fpga_reg(_511));
   _bFeeder_T_value_shreg = _512;
   (void)_512;
   uint _514 = _bFeeder_T_time_stamp_shreg;
   uint _515 = __fpga_reg(__fpga_reg(_514));
   _bFeeder_T_time_stamp_shreg = _515;
   (void)_515;
   uint _516 = (uint)(ADD_UINT64_T_SUFFIX(2048));
   uint _518 = _bFeeder_T_time_stamp_shreg;
   uint _519 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _520 = _518 & _519;
   bool _521 = _516 <= _520;
   if (_521)
   {
    uint _523 = _bFeeder_T_time_stamp_shreg;
    uint _524 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _525 = _523 & _524;
    uint _526 = (uint)(ADD_UINT64_T_SUFFIX(2048));
    uint _527 = _525 - _526;
    uint _528 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _529 = _527 & _528;
    int _530 = (int)(_529);
    bool _531 = _bFeeder_T_s0_buf == _530;
    if (_531)
    {
     float8 _533 = _bFeeder_T_value_shreg;
     uint _535 = _bFeeder_T_time_stamp_shreg;
     uint _536 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _537 = _535 >> _536;
     uint _538 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _539 = _537 & _538;
     bool _540 = (bool)(_539);
     uint _542 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _543 = _535 & _542;
     uint _544 = (uint)(ADD_UINT64_T_SUFFIX(2048));
     uint _545 = _543 - _544;
     int _546 = (int)(_545);
     int _547 = _546 >> 7;
     int _549 = _546 >> 3;
     int _550 = _549 & 15;
     _bFeeder_T_DB_0_ibuffer[_540][_547][_550][_bFeeder_T_s0_buf] = _533;
    } // if _531
   } // if _521
   uint _551 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _553 = _bFeeder_T_time_stamp_shreg;
   uint _554 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _555 = _553 >> _554;
   bool _556 = _551 < _555;
   if (_556)
   {
    uint _558 = _bFeeder_T_time_stamp_shreg;
    uint _559 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _560 = _558 >> _559;
    uint _561 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _562 = _560 & _561;
    bool _563 = (bool)(_562);
    bool _564 = !(_563);
    uint _566 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _567 = _558 & _566;
    int _568 = (int)(_567);
    int _569 = _568 >> 8;
    int _571 = _568 >> 4;
    int _572 = _571 & 15;
    float8 _573 = _bFeeder_T_DB_0_ibuffer[_564][_569][_572][_bFeeder_T_s0_buf];
    _bFeeder_T_Y_T_channel_array.s[_bFeeder_T_s0_buf] = _573;
    (void)_bFeeder_T_s0_buf;
   } // if _556
  } // for _bFeeder_T_s0_buf
  uint _574 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _576 = _bFeeder_T_time_stamp_shreg;
  uint _577 = (uint)(ADD_UINT64_T_SUFFIX(12));
  uint _578 = _576 >> _577;
  bool _579 = _574 < _578;
  if (_579)
  {
   write_channel_intel(_bFeeder_T_Y_T_channel, _bFeeder_T_Y_T_channel_array);
   (void)_bFeeder_T_Y_T_channel_array;
  } // if _579
  uint _580 = _bFeeder_T_cycle_temp;
  uint _581 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _582 = _580 + _581;
  _bFeeder_T_cycle_temp = _582;
 } // while _bFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_bFeeder_T
// Address spaces for kernel_Out_T
__kernel void kernel_Out_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 // produce Z_T
 float _Z_T_shreg[256][8][8];
 float _Z_T_pipe_shreg[8][1793];
 // produce Y_T
 float8 _Y_T_shreg[8];
 float _Z_T_temp[8][8];
 float _Z_temp[8][8];
 // produce X_T
 float8 _X_T_shreg[8];
 _cga__1 _bFeeder_T_Y_T_channel_array;
 _cga__1 _aFeeder_T_X_T_channel_array;
 float _Z_T_shreg_temp;
 int _Z_T_pipe_iter_temp;
 int _Z_T_pipe_base_temp;
 _Z_T_pipe_iter_temp = 2048;
 _Z_T_pipe_base_temp = 0;
 int _583 = _B_extent_0 >> 7;
 int _584 = _583 + 1;
 int patch_temp = (2 * (_B_extent_0 >> 7) - (_A_extent_1 >> 7) + 1) * (_A_extent_1 >> 7) / 2;
 for (int _X_T_s0_j_i = 0; _X_T_s0_j_i < 0 + patch_temp + 1; _X_T_s0_j_i++)
 {
  {
   int _590 = _A_extent_0 >> 7;
   for (int _X_T_s0_k = 0; _X_T_s0_k < 0 + _590; _X_T_s0_k++)
   {
    for (int _X_T_s0_kk_jj_ii = 0; _X_T_s0_kk_jj_ii < 0 + 4096; _X_T_s0_kk_jj_ii++)
    {
     #pragma unroll
     for (int _dummy__4_s0_jjj = 0; _dummy__4_s0_jjj < 0 + 8; _dummy__4_s0_jjj++)
     {
      #pragma unroll
      for (int _dummy__3_s0_iii = 0; _dummy__3_s0_iii < 0 + 8; _dummy__3_s0_iii++)
      {
       float _592 = _Z_T_shreg[255][_dummy__3_s0_iii][_dummy__4_s0_jjj];
       _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj] = _592;
       #pragma unroll
       for (int _dummy__5_s0_l1 = 0; _dummy__5_s0_l1 < 0 + 255; _dummy__5_s0_l1++)
       {
        int _593 = 255 - _dummy__5_s0_l1;
        int _594 = 254 - _dummy__5_s0_l1;
        float _596 = _Z_T_shreg[_594][_dummy__3_s0_iii][_dummy__4_s0_jjj];
        _Z_T_shreg[_593][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _596;
        (void)_596;
       } // for _dummy__5_s0_l1
       float _597 = _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj];
       _Z_T_shreg[0][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _597;
       (void)_597;
      } // for _dummy__3_s0_iii
     } // for _dummy__4_s0_jjj
     int _598 = _B_extent_0 >> 7;
     bool _599 = _X_T_s0_j_i < patch_temp;
     if (_599)
     {
      _cga__1 __600 = read_channel_intel(_bFeeder_T_Y_T_channel);
      _bFeeder_T_Y_T_channel_array = __600;
      (void)__600;
      _cga__1 __601 = read_channel_intel(_aFeeder_T_X_T_channel);
      _aFeeder_T_X_T_channel_array = __601;
      (void)__601;
     } // if _599
     #pragma unroll
     for (int _X_T_s0_jjj = 0; _X_T_s0_jjj < 0 + 8; _X_T_s0_jjj++)
     {
      #pragma unroll
      for (int _X_T_s0_iii = 0; _X_T_s0_iii < 0 + 8; _X_T_s0_iii++)
      {
       float8 _602;
       bool _603 = _X_T_s0_jjj == 0;
       if (_603)
       {
        float8 __604 = _aFeeder_T_X_T_channel_array.s[_X_T_s0_iii];
        _602 = __604;
       } // if _603
       else
       {
        float8 _606 = _X_T_shreg[_X_T_s0_iii];
        _602 = _606;
       } // if _603 else
       float8 _607 = _602;
       _X_T_shreg[_X_T_s0_iii] = _607;
       (void)_607;
       float8 _609 = _X_T_shreg[_X_T_s0_iii];
       float8 _610 = __fpga_reg(__fpga_reg(_609));
       _X_T_shreg[_X_T_s0_iii] = _610;
       (void)_610;
       float8 _611;
       bool _612 = _X_T_s0_iii == 0;
       if (_612)
       {
        float8 __613 = _bFeeder_T_Y_T_channel_array.s[_X_T_s0_jjj];
        _611 = __613;
       } // if _612
       else
       {
        float8 _615 = _Y_T_shreg[_X_T_s0_jjj];
        _611 = _615;
       } // if _612 else
       float8 _616 = _611;
       _Y_T_shreg[_X_T_s0_jjj] = _616;
       (void)_616;
       float8 _618 = _Y_T_shreg[_X_T_s0_jjj];
       float8 _619 = __fpga_reg(__fpga_reg(_618));
       _Y_T_shreg[_X_T_s0_jjj] = _619;
       (void)_619;
       float _620;
       bool _621 = _X_T_s0_k == 0;
       int _622 = _X_T_s0_kk_jj_ii >> 8;
       bool _623 = _622 == 0;
       bool _624 = _621 && _623;
       if (_624)
       {
        float _625 = float_from_bits(0 /* 0 */);
        _620 = _625;
       } // if _624
       else
       {
        float _627 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
        float _628 = __fpga_reg(_627);
        _620 = _628;
       } // if _624 else
       float _629 = _620;
       _Z_T_shreg_temp = _629;
       #pragma unroll
       for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
       {
        float _630 = _Z_T_shreg_temp;
        float _632 = _X_T_shreg[_X_T_s0_iii][_X_T_s0_kkk];
        float _634 = _Y_T_shreg[_X_T_s0_jjj][_X_T_s0_kkk];
        float _635 = _632 * _634;
        float _636 = _630 + _635;
        _Z_T_shreg_temp = _636;
        int _637 = _X_T_s0_kkk & 3;
        bool _638 = _637 == 3;
        if (_638)
        {
         float _639 = _Z_T_shreg_temp;
         float _640 = __fpga_reg(_639);
         _Z_T_shreg_temp = _640;
        } // if _638
       } // for _X_T_s0_kkk
       float _641 = _Z_T_shreg_temp;
       _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj] = _641;
       (void)_641;
       #pragma unroll
       for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
       {
        bool _642 = _X_T_s0_kkk == 7;
        int _643 = _X_T_s0_kk_jj_ii >> 8;
        bool _644 = _643 == 15;
        bool _645 = _642 && _644;
        int _646 = _A_extent_0 >> 7;
        int _647 = _646 + -1;
        bool _648 = _X_T_s0_k == _647;
        bool _649 = _645 && _648;
        if (_649)
        {
         int _650 = _X_T_s0_iii * 256;
         float _652 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
         _Z_T_pipe_shreg[_X_T_s0_jjj][_650] = _652;
         (void)_652;
        } // if _649
       } // for _X_T_s0_kkk
      } // for _X_T_s0_iii
     } // for _X_T_s0_jjj
     int _653 = _X_T_s0_kk_jj_ii & 15;
     bool _654 = _653 == 0;
     int _655 = _X_T_s0_kk_jj_ii & 255;
     int _656 = _655 >> 4;
     bool _657 = _656 == 0;
     bool _658 = _654 && _657;
     int _659 = _A_extent_0 >> 7;
     int _660 = _659 + -1;
     bool _661 = _X_T_s0_k == _660;
     bool _662 = _658 && _661;
     int _663 = _X_T_s0_kk_jj_ii >> 8;
     bool _664 = _663 == 15;
     bool _665 = _662 && _664;
     int _666 = _B_extent_0 >> 7;
     bool _667 = _X_T_s0_j_i < patch_temp;
     bool _668 = _665 && _667;
     if (_668)
     {
      int _669 = _Z_T_pipe_iter_temp;
      _Z_T_pipe_base_temp = _669;
     } // if _668
     float8 _Out_T_Add_channel_temp;
     #pragma unroll
     for (int _Z_T_pipe_b__14 = 0; _Z_T_pipe_b__14 < 0 + 8; _Z_T_pipe_b__14++)
     {
      float _671 = _Z_T_pipe_shreg[_Z_T_pipe_b__14][0];
      _Out_T_Add_channel_temp[_Z_T_pipe_b__14] = _671;
      #pragma unroll
      for (int _Z_T_pipe_b__14_dummy = 0; _Z_T_pipe_b__14_dummy < 0 + 8; _Z_T_pipe_b__14_dummy++)
      {
       float _672 = _Out_T_Add_channel_temp[_Z_T_pipe_b__14_dummy];
       float _673 = __fpga_reg(__fpga_reg(_672));
       _Out_T_Add_channel_temp[_Z_T_pipe_b__14_dummy] = _673;
      } // for _Z_T_pipe_b__14_dummy
     } // for _Z_T_pipe_b__14
     int _674 = _Z_T_pipe_iter_temp;
     int _675 = _Z_T_pipe_base_temp;
     int _676 = _675 + 2048;
     bool _677 = _674 < _676;
     if (_677)
     {
      float8 _678 = _Out_T_Add_channel_temp;
      write_channel_intel(_Out_T_Add_channel, _678);
      (void)_678;
     } // if _677
     #pragma unroll
     for (int _Z_T_pipe_b__15 = 0; _Z_T_pipe_b__15 < 0 + 8; _Z_T_pipe_b__15++)
     {
      #pragma unroll
      for (int _Z_T_pipe_p__7 = 0; _Z_T_pipe_p__7 < 0 + 7; _Z_T_pipe_p__7++)
      {
       #pragma unroll
       for (int _Z_T_pipe_l__7 = 0; _Z_T_pipe_l__7 < 0 + 255; _Z_T_pipe_l__7++)
       {
        int _679 = _Z_T_pipe_p__7 * 256;
        int _680 = _679 + _Z_T_pipe_l__7;
        int _681 = _680 + 1;
        float _683 = _Z_T_pipe_shreg[_Z_T_pipe_b__15][_681];
        _Z_T_pipe_shreg[_Z_T_pipe_b__15][_680] = _683;
        (void)_683;
       } // for _Z_T_pipe_l__7
       int _684 = _Z_T_pipe_p__7 * 256;
       int _685 = _684 + 255;
       int _686 = _684 + 256;
       float _688 = _Z_T_pipe_shreg[_Z_T_pipe_b__15][_686];
       float _689 = __fpga_reg(__fpga_reg(_688));
       _Z_T_pipe_shreg[_Z_T_pipe_b__15][_685] = _689;
       (void)_689;
      } // for _Z_T_pipe_p__7
     } // for _Z_T_pipe_b__15
     int _690 = _Z_T_pipe_iter_temp;
     int _691 = _690 + 1;
     _Z_T_pipe_iter_temp = _691;
    } // for _X_T_s0_kk_jj_ii
   } // for _X_T_s0_k
  } // for _X_T_s0_i
 } // for _X_T_s0_j
} // kernel kernel_Out_T
// Address spaces for kernel_Add
__kernel void kernel_Add(
 const int _A_extent_1,
 const int _B_extent_0)
{
 int _692 = _A_extent_1 >> 7;
 for (int _Add_s0_i = 0; _Add_s0_i < 0 + _692; _Add_s0_i++)
 {
  int _693 = _B_extent_0 >> 7;
  int _694 = _693 - _Add_s0_i;
  for (int _Add_s0_j = _Add_s0_i; _Add_s0_j < _Add_s0_i + _694; _Add_s0_j++)
  {
   for (int _Add_s0_ii_jj_iii = 0; _Add_s0_ii_jj_iii < 0 + 2048; _Add_s0_ii_jj_iii++)
   {
    float8 __695 = read_channel_intel(_Out_Add_channel);
    float8 __696 = read_channel_intel(_Out_T_Add_channel);
    float8 _697 = __695 + __696;
    write_channel_intel(_Add_unloader_channel, _697);
    (void)_697;
   } // for _Add_s0_ii_jj_iii
  } // for _Add_s0_j
 } // for _Add_s0_i
} // kernel kernel_Add
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel float *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _698 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _698; _unloader_s0_i++)
 {
  int _699 = _B_extent_0 >> 7;
  int _700 = _699 - _unloader_s0_i;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < _unloader_s0_i + _700; _unloader_s0_j++)
  {
   for (int _unloader_s0_ii_jj_iii = 0; _unloader_s0_ii_jj_iii < 0 + 2048; _unloader_s0_ii_jj_iii++)
   {
    float8 __701 = read_channel_intel(_Add_unloader_channel);
    int _702 = _addr_temp;
    int _703 = _702 * 8;
    vstore8(__701, 0, (__address_space__unloader_mem_channel float*)_unloader_mem_channel + _703);
    int _704 = _addr_temp;
    int _705 = _704 + 1;
    _addr_temp = _705;
   } // for _unloader_s0_ii_jj_iii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

