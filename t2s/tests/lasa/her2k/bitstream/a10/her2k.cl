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
typedef union {
bool __attribute__ ((aligned(4))) s[4];
struct {bool s0,  s1,  s2,  s3;};
} bool4;
typedef struct { complex8 s[4]; } _cga__1;
channel complex8 _aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _aFeeder_X_channel __attribute__((depth(256))) ;
channel complex8 _bLoader_bFeeder_channel __attribute__((depth(256))) ;
channel _cga__1 _bFeeder_Y_channel __attribute__((depth(256))) ;
channel complex4 _Out_Add_channel __attribute__((depth(256))) ;
channel complex8 _aLoader_T_aFeeder_T_channel __attribute__((depth(256))) ;
channel _cga__1 _aFeeder_T_X_T_channel __attribute__((depth(256))) ;
channel complex8 _bLoader_T_bFeeder_T_channel __attribute__((depth(256))) ;
channel _cga__1 _bFeeder_T_Y_T_channel __attribute__((depth(256))) ;
channel complex4 _Out_T_Add_channel __attribute__((depth(256))) ;
channel complex4 _Add_unloader_channel __attribute__((depth(0))) ;
// Address spaces for kernel_aLoader
#define __address_space__A_X_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_X_serializer_mem_channel const complex *restrict _A_X_serializer_mem_channel)
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
      complex8 _14;
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
       complex8 _25 = {vload16(0, (__address_space__A_X_serializer_mem_channel float*)(_A_X_serializer_mem_channel + _24))};
       _14 = _25;
      } // if _16
      else
      {
       complex _26 = (complex)(ADD_UINT64_T_SUFFIX(0));
       complex8 _27 = (complex8)(float16){_26, _26, _26, _26, _26, _26, _26, _26};
       _14 = _27;
      } // if _16 else
      complex8 _28 = _14;
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
 complex8 _aFeeder_value_shreg;
 uint _aFeeder_time_stamp_shreg;
 complex8 _aFeeder_in_v_temp;
 uint _aFeeder_cycle_temp;
 complex8 __attribute__((memory, numbanks(4), singlepump)) _aFeeder_DB_0_ibuffer[2][16][32][4];
 #pragma unroll
 for (int _aFeeder_s0_jjj_init = 0; _aFeeder_s0_jjj_init < 0 + 4; _aFeeder_s0_jjj_init++)
 {
  bool _31 = _aFeeder_s0_jjj_init == 0;
  if (_31)
  {
   uint _32 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   _aFeeder_cycle_temp = _32;
  } // if _31
 } // for _aFeeder_s0_jjj_init
 while(1)
 {
  uint _33 = (uint)(ADD_UINT64_T_SUFFIX(14336));
  uint _34 = _aFeeder_cycle_temp;
  uint _35 = (uint)(ADD_UINT64_T_SUFFIX(16383));
  uint _36 = _34 & _35;
  bool _37 = _33 <= _36;
  if (_37)
  {
   complex8 __38 = read_channel_intel(_aLoader_aFeeder_channel);
   _aFeeder_in_v_temp = __38;
  } // if _37
  #pragma unroll
  for (int _aFeeder_s0_buf = 0; _aFeeder_s0_buf < 0 + 4; _aFeeder_s0_buf++)
  {
   bool _39 = _aFeeder_s0_buf == 0;
   if (_39)
   {
    complex8 _40 = _aFeeder_in_v_temp;
    _aFeeder_value_shreg = _40;
    (void)_40;
    uint _41 = _aFeeder_cycle_temp;
    _aFeeder_time_stamp_shreg = _41;
    (void)_41;
   } // if _39
   else
   {
    complex8 _43 = _aFeeder_value_shreg;
    _aFeeder_value_shreg = _43;
    (void)_43;
    uint _45 = _aFeeder_time_stamp_shreg;
    _aFeeder_time_stamp_shreg = _45;
    (void)_45;
   } // if _39 else
   complex8 _47 = _aFeeder_value_shreg;
   complex8 _48 = __fpga_reg(__fpga_reg(_47));
   _aFeeder_value_shreg = _48;
   (void)_48;
   uint _50 = _aFeeder_time_stamp_shreg;
   uint _51 = __fpga_reg(__fpga_reg(_50));
   _aFeeder_time_stamp_shreg = _51;
   (void)_51;
   uint _52 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   uint _54 = _aFeeder_time_stamp_shreg;
   uint _55 = (uint)(ADD_UINT64_T_SUFFIX(16383));
   uint _56 = _54 & _55;
   bool _57 = _52 <= _56;
   if (_57)
   {
    uint _59 = _aFeeder_time_stamp_shreg;
    uint _60 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _61 = _59 & _60;
    uint _62 = (uint)(ADD_UINT64_T_SUFFIX(14336));
    uint _63 = _61 - _62;
    uint _64 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _65 = _63 & _64;
    int _66 = (int)(_65);
    bool _67 = _aFeeder_s0_buf == _66;
    if (_67)
    {
     complex8 _69 = _aFeeder_value_shreg;
     uint _71 = _aFeeder_time_stamp_shreg;
     uint _72 = (uint)(ADD_UINT64_T_SUFFIX(14));
     uint _73 = _71 >> _72;
     uint _74 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _75 = _73 & _74;
     bool _76 = (bool)(_75);
     uint _78 = (uint)(ADD_UINT64_T_SUFFIX(16383));
     uint _79 = _71 & _78;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(14336));
     uint _81 = _79 - _80;
     int _82 = (int)(_81);
     int _83 = _82 >> 7;
     int _85 = _82 >> 2;
     int _86 = _85 & 31;
     _aFeeder_DB_0_ibuffer[_76][_83][_86][_aFeeder_s0_buf] = _69;
    } // if _67
   } // if _57
   uint _87 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _89 = _aFeeder_time_stamp_shreg;
   uint _90 = (uint)(ADD_UINT64_T_SUFFIX(14));
   uint _91 = _89 >> _90;
   bool _92 = _87 < _91;
   if (_92)
   {
    uint _94 = _aFeeder_time_stamp_shreg;
    uint _95 = (uint)(ADD_UINT64_T_SUFFIX(14));
    uint _96 = _94 >> _95;
    uint _97 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _98 = _96 & _97;
    bool _99 = (bool)(_98);
    bool _100 = !(_99);
    uint _102 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _103 = _94 & _102;
    int _104 = (int)(_103);
    int _105 = _104 >> 10;
    int _107 = _104 >> 5;
    int _108 = _107 & 31;
    complex8 _109 = _aFeeder_DB_0_ibuffer[_100][_105][_108][_aFeeder_s0_buf];
    _aFeeder_X_channel_array.s[_aFeeder_s0_buf] = _109;
    (void)_aFeeder_s0_buf;
   } // if _92
  } // for _aFeeder_s0_buf
  uint _110 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _112 = _aFeeder_time_stamp_shreg;
  uint _113 = (uint)(ADD_UINT64_T_SUFFIX(14));
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
 __address_space__B_Y_serializer_mem_channel const complex *restrict _B_Y_serializer_mem_channel)
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
      complex8 _133;
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
       complex8 _144 = {vload16(0, (__address_space__B_Y_serializer_mem_channel float*)(_B_Y_serializer_mem_channel + _143))};
       _133 = _144;
      } // if _135
      else
      {
       complex _145 = (complex)(ADD_UINT64_T_SUFFIX(0));
       complex8 _146 = (complex8)(float16){_145, _145, _145, _145, _145, _145, _145, _145};
       _133 = _146;
      } // if _135 else
      complex8 _147 = _133;
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
 complex8 _bFeeder_value_shreg;
 uint _bFeeder_time_stamp_shreg;
 complex8 _bFeeder_in_v_temp;
 uint _bFeeder_cycle_temp;
 complex8 __attribute__((memory, numbanks(4), singlepump)) _bFeeder_DB_0_ibuffer[2][16][32][4];
 #pragma unroll
 for (int _bFeeder_s0_iii_init = 0; _bFeeder_s0_iii_init < 0 + 4; _bFeeder_s0_iii_init++)
 {
  bool _150 = _bFeeder_s0_iii_init == 0;
  if (_150)
  {
   uint _151 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   _bFeeder_cycle_temp = _151;
  } // if _150
 } // for _bFeeder_s0_iii_init
 while(1)
 {
  uint _152 = (uint)(ADD_UINT64_T_SUFFIX(14336));
  uint _153 = _bFeeder_cycle_temp;
  uint _154 = (uint)(ADD_UINT64_T_SUFFIX(16383));
  uint _155 = _153 & _154;
  bool _156 = _152 <= _155;
  if (_156)
  {
   complex8 __157 = read_channel_intel(_bLoader_bFeeder_channel);
   _bFeeder_in_v_temp = __157;
  } // if _156
  #pragma unroll
  for (int _bFeeder_s0_buf = 0; _bFeeder_s0_buf < 0 + 4; _bFeeder_s0_buf++)
  {
   bool _158 = _bFeeder_s0_buf == 0;
   if (_158)
   {
    complex8 _159 = _bFeeder_in_v_temp;
    _bFeeder_value_shreg = _159;
    (void)_159;
    uint _160 = _bFeeder_cycle_temp;
    _bFeeder_time_stamp_shreg = _160;
    (void)_160;
   } // if _158
   else
   {
    complex8 _162 = _bFeeder_value_shreg;
    _bFeeder_value_shreg = _162;
    (void)_162;
    uint _164 = _bFeeder_time_stamp_shreg;
    _bFeeder_time_stamp_shreg = _164;
    (void)_164;
   } // if _158 else
   complex8 _166 = _bFeeder_value_shreg;
   complex8 _167 = __fpga_reg(__fpga_reg(_166));
   _bFeeder_value_shreg = _167;
   (void)_167;
   uint _169 = _bFeeder_time_stamp_shreg;
   uint _170 = __fpga_reg(__fpga_reg(_169));
   _bFeeder_time_stamp_shreg = _170;
   (void)_170;
   uint _171 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   uint _173 = _bFeeder_time_stamp_shreg;
   uint _174 = (uint)(ADD_UINT64_T_SUFFIX(16383));
   uint _175 = _173 & _174;
   bool _176 = _171 <= _175;
   if (_176)
   {
    uint _178 = _bFeeder_time_stamp_shreg;
    uint _179 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _180 = _178 & _179;
    uint _181 = (uint)(ADD_UINT64_T_SUFFIX(14336));
    uint _182 = _180 - _181;
    uint _183 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _184 = _182 & _183;
    int _185 = (int)(_184);
    bool _186 = _bFeeder_s0_buf == _185;
    if (_186)
    {
     complex8 _188 = _bFeeder_value_shreg;
     uint _190 = _bFeeder_time_stamp_shreg;
     uint _191 = (uint)(ADD_UINT64_T_SUFFIX(14));
     uint _192 = _190 >> _191;
     uint _193 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _194 = _192 & _193;
     bool _195 = (bool)(_194);
     uint _197 = (uint)(ADD_UINT64_T_SUFFIX(16383));
     uint _198 = _190 & _197;
     uint _199 = (uint)(ADD_UINT64_T_SUFFIX(14336));
     uint _200 = _198 - _199;
     int _201 = (int)(_200);
     int _202 = _201 >> 7;
     int _204 = _201 >> 2;
     int _205 = _204 & 31;
     _bFeeder_DB_0_ibuffer[_195][_202][_205][_bFeeder_s0_buf] = _188;
    } // if _186
   } // if _176
   uint _206 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _208 = _bFeeder_time_stamp_shreg;
   uint _209 = (uint)(ADD_UINT64_T_SUFFIX(14));
   uint _210 = _208 >> _209;
   bool _211 = _206 < _210;
   if (_211)
   {
    uint _213 = _bFeeder_time_stamp_shreg;
    uint _214 = (uint)(ADD_UINT64_T_SUFFIX(14));
    uint _215 = _213 >> _214;
    uint _216 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _217 = _215 & _216;
    bool _218 = (bool)(_217);
    bool _219 = !(_218);
    uint _221 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _222 = _213 & _221;
    int _223 = (int)(_222);
    int _224 = _223 >> 10;
    int _226 = _223 & 31;
    complex8 _227 = _bFeeder_DB_0_ibuffer[_219][_224][_226][_bFeeder_s0_buf];
    _bFeeder_Y_channel_array.s[_bFeeder_s0_buf] = _227;
    (void)_bFeeder_s0_buf;
   } // if _211
  } // for _bFeeder_s0_buf
  uint _228 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _230 = _bFeeder_time_stamp_shreg;
  uint _231 = (uint)(ADD_UINT64_T_SUFFIX(14));
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
 complex _Z_shreg[1024][4][4];
 complex _Z_pipe_shreg[4][3073];
 // produce Y
 complex8 _Y_shreg[4];
 complex _Z_temp[4][4];
 // produce X
 complex8 _X_shreg[4];
 _cga__1 _bFeeder_Y_channel_array;
 _cga__1 _aFeeder_X_channel_array;
 complex _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 4096;
 _Z_pipe_base_temp = 0;
 int patch_temp = (2 * (_B_extent_0 >> 7) - (_A_extent_1 >> 7) + 1) * (_A_extent_1 >> 7) / 2;
 for (int _X_s0_i_j = 0; _X_s0_i_j < patch_temp + 1; _X_s0_i_j++)
 {
   int _244 = _A_extent_0 >> 7;
   for (int _X_s0_k = 0; _X_s0_k < 0 + _244; _X_s0_k++)
   {
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 16384; _X_s0_kk_ii_jj++)
    {
     #pragma unroll
     for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 4; _dummy__1_s0_iii++)
     {
      #pragma unroll
      for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 4; _dummy_s0_jjj++)
      {
       complex _246 = _Z_shreg[1023][_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _246;
       #pragma unroll
       for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 1023; _dummy__2_s0_l1++)
       {
        int _247 = 1023 - _dummy__2_s0_l1;
        int _248 = 1022 - _dummy__2_s0_l1;
        complex _250 = _Z_shreg[_248][_dummy_s0_jjj][_dummy__1_s0_iii];
        _Z_shreg[_247][_dummy_s0_jjj][_dummy__1_s0_iii] = _250;
        (void)_250;
       } // for _dummy__2_s0_l1
       complex _251 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
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
     for (int _X_s0_iii = 0; _X_s0_iii < 0 + 4; _X_s0_iii++)
     {
      #pragma unroll
      for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 4; _X_s0_jjj++)
      {
       complex8 _256;
       bool _257 = _X_s0_jjj == 0;
       if (_257)
       {
        complex8 __258 = _aFeeder_X_channel_array.s[_X_s0_iii];
        _256 = __258;
       } // if _257
       else
       {
        complex8 _260 = _X_shreg[_X_s0_iii];
        _256 = _260;
       } // if _257 else
       complex8 _261 = _256;
       _X_shreg[_X_s0_iii] = _261;
       (void)_261;
       complex8 _263 = _X_shreg[_X_s0_iii];
       complex8 _264 = __fpga_reg(__fpga_reg(_263));
       _X_shreg[_X_s0_iii] = _264;
       (void)_264;
       complex8 _265;
       bool _266 = _X_s0_iii == 0;
       if (_266)
       {
        complex8 __267 = _bFeeder_Y_channel_array.s[_X_s0_jjj];
        _265 = __267;
       } // if _266
       else
       {
        complex8 _269 = _Y_shreg[_X_s0_jjj];
        _265 = _269;
       } // if _266 else
       complex8 _270 = _265;
       _Y_shreg[_X_s0_jjj] = _270;
       (void)_270;
       complex8 _272 = _Y_shreg[_X_s0_jjj];
       complex8 _273 = __fpga_reg(__fpga_reg(_272));
       _Y_shreg[_X_s0_jjj] = _273;
       (void)_273;
       complex _274;
       bool _275 = _X_s0_k == 0;
       int _276 = _X_s0_kk_ii_jj >> 10;
       bool _277 = _276 == 0;
       bool _278 = _275 && _277;
       if (_278)
       {
        complex _279 = (complex)(ADD_UINT64_T_SUFFIX(0));
        _274 = _279;
       } // if _278
       else
       {
        complex _281 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
        complex _282 = __fpga_reg(_281);
        _274 = _282;
       } // if _278 else
       complex _283 = _274;
       _Z_shreg_temp = _283;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
       {
        complex _284 = _Z_shreg_temp;
        complex _286 = _X_shreg[_X_s0_iii].s[_X_s0_kkk];
        complex _288 = _Y_shreg[_X_s0_jjj].s[_X_s0_kkk];
        complex _289 = conjugate_c32(_288);
        complex _290 = (complex) {_286.s0 * _289.s0 - _286.s1 * _289.s1, _286.s0 * _289.s1 + _286.s1 * _289.s0};
        complex _291 = _284 + _290;
        _Z_shreg_temp = _291;
        int _292 = _X_s0_kkk & 3;
        bool _293 = _292 == 3;
        if (_293)
        {
         complex _294 = _Z_shreg_temp;
         complex _295 = __fpga_reg(_294);
         _Z_shreg_temp = _295;
        } // if _293
       } // for _X_s0_kkk
       complex _296 = _Z_shreg_temp;
       _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _296;
       (void)_296;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
       {
        bool _297 = _X_s0_kkk == 7;
        int _298 = _X_s0_kk_ii_jj >> 10;
        bool _299 = _298 == 15;
        bool _300 = _297 && _299;
        int _301 = _A_extent_0 >> 7;
        int _302 = _301 + -1;
        bool _303 = _X_s0_k == _302;
        bool _304 = _300 && _303;
        if (_304)
        {
         int _305 = _X_s0_iii * 1024;
         complex _307 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
         _Z_pipe_shreg[_X_s0_jjj][_305] = _307;
         (void)_307;
        } // if _304
       } // for _X_s0_kkk
      } // for _X_s0_jjj
     } // for _X_s0_iii
     int _308 = _X_s0_kk_ii_jj & 31;
     bool _309 = _308 == 0;
     int _310 = _X_s0_kk_ii_jj & 1023;
     int _311 = _310 >> 5;
     bool _312 = _311 == 0;
     bool _313 = _309 && _312;
     int _314 = _A_extent_0 >> 7;
     int _315 = _314 + -1;
     bool _316 = _X_s0_k == _315;
     bool _317 = _313 && _316;
     int _318 = _X_s0_kk_ii_jj >> 10;
     bool _319 = _318 == 15;
     bool _320 = _317 && _319;
     int _321 = _A_extent_1 >> 7;
     bool _322 = _X_s0_i_j < patch_temp;
     bool _323 = _320 && _322;
     if (_323)
     {
      int _324 = _Z_pipe_iter_temp;
      _Z_pipe_base_temp = _324;
     } // if _323
     complex4 _Out_Add_channel_temp;
     #pragma unroll
     for (int _Z_pipe_b__14 = 0; _Z_pipe_b__14 < 0 + 4; _Z_pipe_b__14++)
     {
      complex _326 = _Z_pipe_shreg[_Z_pipe_b__14][0];
      _Out_Add_channel_temp.s[_Z_pipe_b__14] = _326;
      #pragma unroll
      for (int _Z_pipe_b__14_dummy = 0; _Z_pipe_b__14_dummy < 0 + 4; _Z_pipe_b__14_dummy++)
      {
       complex _327 = _Out_Add_channel_temp.s[_Z_pipe_b__14_dummy];
       complex _328 = __fpga_reg(__fpga_reg(_327));
       _Out_Add_channel_temp.s[_Z_pipe_b__14_dummy] = _328;
      } // for _Z_pipe_b__14_dummy
     } // for _Z_pipe_b__14
     int _329 = _Z_pipe_iter_temp;
     int _330 = _Z_pipe_base_temp;
     int _331 = _330 + 4096;
     bool _332 = _329 < _331;
     if (_332)
     {
      complex4 _333 = _Out_Add_channel_temp;
      write_channel_intel(_Out_Add_channel, _333);
      (void)_333;
     } // if _332
     #pragma unroll
     for (int _Z_pipe_b__15 = 0; _Z_pipe_b__15 < 0 + 4; _Z_pipe_b__15++)
     {
      #pragma unroll
      for (int _Z_pipe_p__7 = 0; _Z_pipe_p__7 < 0 + 3; _Z_pipe_p__7++)
      {
       #pragma unroll
       for (int _Z_pipe_l__7 = 0; _Z_pipe_l__7 < 0 + 1023; _Z_pipe_l__7++)
       {
        int _334 = _Z_pipe_p__7 * 1024;
        int _335 = _334 + _Z_pipe_l__7;
        int _336 = _335 + 1;
        complex _338 = _Z_pipe_shreg[_Z_pipe_b__15][_336];
        _Z_pipe_shreg[_Z_pipe_b__15][_335] = _338;
        (void)_338;
       } // for _Z_pipe_l__7
       int _339 = _Z_pipe_p__7 * 1024;
       int _340 = _339 + 1023;
       int _341 = _339 + 1024;
       complex _343 = _Z_pipe_shreg[_Z_pipe_b__15][_341];
       complex _344 = __fpga_reg(__fpga_reg(_343));
       _Z_pipe_shreg[_Z_pipe_b__15][_340] = _344;
       (void)_344;
      } // for _Z_pipe_p__7
     } // for _Z_pipe_b__15
     int _345 = _Z_pipe_iter_temp;
     int _346 = _345 + 1;
     _Z_pipe_iter_temp = _346;
    } // for _X_s0_kk_ii_jj
   } // for _X_s0_k
 } // for _X_s0_i
} // kernel kernel_Out
// Address spaces for kernel_aLoader_T
#define __address_space__A_X_T_serializer_mem_channel __global
__kernel void kernel_aLoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__A_X_T_serializer_mem_channel const complex *restrict _A_X_T_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _347 = _B_extent_0 >> 7;
 int _348 = _347 + 1;
 for (int _aLoader_T_s0_j = 0; _aLoader_T_s0_j < 0 + _348; _aLoader_T_s0_j++)
 {
  int _349 = _B_extent_0 >> 7;
  int _350 = _aLoader_T_s0_j / _349;
  int _351 = _A_extent_1 >> 7;
  int _352 = _351 - _aLoader_T_s0_j;
  int _353 = _350 + _352;
  for (int _aLoader_T_s0_i = _aLoader_T_s0_j; _aLoader_T_s0_i < _aLoader_T_s0_j + _353; _aLoader_T_s0_i++)
  {
   int _354 = _A_extent_0 >> 7;
   for (int _aLoader_T_s0_k = 0; _aLoader_T_s0_k < 0 + _354; _aLoader_T_s0_k++)
   {
    for (int _aLoader_T_s0_kk_ii_iii = 0; _aLoader_T_s0_kk_ii_iii < 0 + 2048; _aLoader_T_s0_kk_ii_iii++)
    {
     bool _355 = _aLoader_T_s0_i == _aLoader_T_s0_j;
     bool _356 = _aLoader_T_s0_k == 0;
     bool _357 = _355 && _356;
     int _358 = _B_extent_0 >> 7;
     bool _359 = _aLoader_T_s0_j < _358;
     bool _360 = _357 || _359;
     if (_360)
     {
      complex8 _361;
      int _362 = _B_extent_0 >> 7;
      bool _363 = _aLoader_T_s0_j < _362;
      if (_363)
      {
       int _364 = _A_extent_0 >> 7;
       int _365 = _364 * _aLoader_T_s0_i;
       int _366 = _365 * 2048;
       int _367 = _addr_temp;
       int _368 = _364 * 2048;
       int _369 = _367 % _368;
       int _370 = _366 + _369;
       int _371 = _370 * 8;
       complex8 _372 = {vload16(0, (__address_space__A_X_T_serializer_mem_channel float*)(_A_X_T_serializer_mem_channel + _371))};
       _361 = _372;
      } // if _363
      else
      {
       complex _373 = (complex)(ADD_UINT64_T_SUFFIX(0));
       complex8 _374 = (complex8)(float16){_373, _373, _373, _373, _373, _373, _373, _373};
       _361 = _374;
      } // if _363 else
      complex8 _375 = _361;
      write_channel_intel(_aLoader_T_aFeeder_T_channel, _375);
      (void)_375;
     } // if _360
     int _376 = _addr_temp;
     int _377 = _376 + 1;
     _addr_temp = _377;
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
 complex8 _aFeeder_T_value_shreg;
 uint _aFeeder_T_time_stamp_shreg;
 complex8 _aFeeder_T_in_v_temp;
 uint _aFeeder_T_cycle_temp;
 complex8 __attribute__((memory, numbanks(4), singlepump)) _aFeeder_T_DB_0_ibuffer[2][16][32][4];
 #pragma unroll
 for (int _aFeeder_T_s0_jjj_init = 0; _aFeeder_T_s0_jjj_init < 0 + 4; _aFeeder_T_s0_jjj_init++)
 {
  bool _378 = _aFeeder_T_s0_jjj_init == 0;
  if (_378)
  {
   uint _379 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   _aFeeder_T_cycle_temp = _379;
  } // if _378
 } // for _aFeeder_T_s0_jjj_init
 while(1)
 {
  uint _380 = (uint)(ADD_UINT64_T_SUFFIX(14336));
  uint _381 = _aFeeder_T_cycle_temp;
  uint _382 = (uint)(ADD_UINT64_T_SUFFIX(16383));
  uint _383 = _381 & _382;
  bool _384 = _380 <= _383;
  if (_384)
  {
   complex8 __385 = read_channel_intel(_aLoader_T_aFeeder_T_channel);
   _aFeeder_T_in_v_temp = __385;
  } // if _384
  #pragma unroll
  for (int _aFeeder_T_s0_buf = 0; _aFeeder_T_s0_buf < 0 + 4; _aFeeder_T_s0_buf++)
  {
   bool _386 = _aFeeder_T_s0_buf == 0;
   if (_386)
   {
    complex8 _387 = _aFeeder_T_in_v_temp;
    _aFeeder_T_value_shreg = _387;
    (void)_387;
    uint _388 = _aFeeder_T_cycle_temp;
    _aFeeder_T_time_stamp_shreg = _388;
    (void)_388;
   } // if _386
   else
   {
    complex8 _390 = _aFeeder_T_value_shreg;
    _aFeeder_T_value_shreg = _390;
    (void)_390;
    uint _392 = _aFeeder_T_time_stamp_shreg;
    _aFeeder_T_time_stamp_shreg = _392;
    (void)_392;
   } // if _386 else
   complex8 _394 = _aFeeder_T_value_shreg;
   complex8 _395 = __fpga_reg(__fpga_reg(_394));
   _aFeeder_T_value_shreg = _395;
   (void)_395;
   uint _397 = _aFeeder_T_time_stamp_shreg;
   uint _398 = __fpga_reg(__fpga_reg(_397));
   _aFeeder_T_time_stamp_shreg = _398;
   (void)_398;
   uint _399 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   uint _401 = _aFeeder_T_time_stamp_shreg;
   uint _402 = (uint)(ADD_UINT64_T_SUFFIX(16383));
   uint _403 = _401 & _402;
   bool _404 = _399 <= _403;
   if (_404)
   {
    uint _406 = _aFeeder_T_time_stamp_shreg;
    uint _407 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _408 = _406 & _407;
    uint _409 = (uint)(ADD_UINT64_T_SUFFIX(14336));
    uint _410 = _408 - _409;
    uint _411 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _412 = _410 & _411;
    int _413 = (int)(_412);
    bool _414 = _aFeeder_T_s0_buf == _413;
    if (_414)
    {
     complex8 _416 = _aFeeder_T_value_shreg;
     uint _418 = _aFeeder_T_time_stamp_shreg;
     uint _419 = (uint)(ADD_UINT64_T_SUFFIX(14));
     uint _420 = _418 >> _419;
     uint _421 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _422 = _420 & _421;
     bool _423 = (bool)(_422);
     uint _425 = (uint)(ADD_UINT64_T_SUFFIX(16383));
     uint _426 = _418 & _425;
     uint _427 = (uint)(ADD_UINT64_T_SUFFIX(14336));
     uint _428 = _426 - _427;
     int _429 = (int)(_428);
     int _430 = _429 >> 7;
     int _432 = _429 >> 2;
     int _433 = _432 & 31;
     _aFeeder_T_DB_0_ibuffer[_423][_430][_433][_aFeeder_T_s0_buf] = _416;
    } // if _414
   } // if _404
   uint _434 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _436 = _aFeeder_T_time_stamp_shreg;
   uint _437 = (uint)(ADD_UINT64_T_SUFFIX(14));
   uint _438 = _436 >> _437;
   bool _439 = _434 < _438;
   if (_439)
   {
    uint _441 = _aFeeder_T_time_stamp_shreg;
    uint _442 = (uint)(ADD_UINT64_T_SUFFIX(14));
    uint _443 = _441 >> _442;
    uint _444 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _445 = _443 & _444;
    bool _446 = (bool)(_445);
    bool _447 = !(_446);
    uint _449 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _450 = _441 & _449;
    int _451 = (int)(_450);
    int _452 = _451 >> 10;
    int _454 = _451 & 31;
    complex8 _455 = _aFeeder_T_DB_0_ibuffer[_447][_452][_454][_aFeeder_T_s0_buf];
    _aFeeder_T_X_T_channel_array.s[_aFeeder_T_s0_buf] = _455;
    (void)_aFeeder_T_s0_buf;
   } // if _439
  } // for _aFeeder_T_s0_buf
  uint _456 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _458 = _aFeeder_T_time_stamp_shreg;
  uint _459 = (uint)(ADD_UINT64_T_SUFFIX(14));
  uint _460 = _458 >> _459;
  bool _461 = _456 < _460;
  if (_461)
  {
   write_channel_intel(_aFeeder_T_X_T_channel, _aFeeder_T_X_T_channel_array);
   (void)_aFeeder_T_X_T_channel_array;
  } // if _461
  uint _462 = _aFeeder_T_cycle_temp;
  uint _463 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _464 = _462 + _463;
  _aFeeder_T_cycle_temp = _464;
 } // while _aFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_aFeeder_T
// Address spaces for kernel_bLoader_T
#define __address_space__B_Y_T_serializer_mem_channel __global
__kernel void kernel_bLoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__B_Y_T_serializer_mem_channel const complex *restrict _B_Y_T_serializer_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _465 = _B_extent_0 >> 7;
 int _466 = _465 + 1;
 for (int _bLoader_T_s0_j = 0; _bLoader_T_s0_j < 0 + _466; _bLoader_T_s0_j++)
 {
  int _467 = _B_extent_0 >> 7;
  int _468 = _bLoader_T_s0_j / _467;
  int _469 = _A_extent_1 >> 7;
  int _470 = _469 - _bLoader_T_s0_j;
  int _471 = _468 + _470;
  for (int _bLoader_T_s0_i = _bLoader_T_s0_j; _bLoader_T_s0_i < _bLoader_T_s0_j + _471; _bLoader_T_s0_i++)
  {
   int _472 = _A_extent_0 >> 7;
   for (int _bLoader_T_s0_k = 0; _bLoader_T_s0_k < 0 + _472; _bLoader_T_s0_k++)
   {
    for (int _bLoader_T_s0_kk_jj_jjj = 0; _bLoader_T_s0_kk_jj_jjj < 0 + 2048; _bLoader_T_s0_kk_jj_jjj++)
    {
     bool _473 = _bLoader_T_s0_i == _bLoader_T_s0_j;
     bool _474 = _bLoader_T_s0_k == 0;
     bool _475 = _473 && _474;
     int _476 = _B_extent_0 >> 7;
     bool _477 = _bLoader_T_s0_j < _476;
     bool _478 = _475 || _477;
     if (_478)
     {
      complex8 _479;
      int _480 = _B_extent_0 >> 7;
      bool _481 = _bLoader_T_s0_j < _480;
      if (_481)
      {
       int _482 = _A_extent_0 >> 7;
       int _483 = _482 * _bLoader_T_s0_j;
       int _484 = _483 * 2048;
       int _485 = _addr_temp;
       int _486 = _482 * 2048;
       int _487 = _485 % _486;
       int _488 = _484 + _487;
       int _489 = _488 * 8;
       complex8 _490 = {vload16(0, (__address_space__B_Y_T_serializer_mem_channel float*)(_B_Y_T_serializer_mem_channel + _489))};
       _479 = _490;
      } // if _481
      else
      {
       complex _491 = (complex)(ADD_UINT64_T_SUFFIX(0));
       complex8 _492 = (complex8)(float16){_491, _491, _491, _491, _491, _491, _491, _491};
       _479 = _492;
      } // if _481 else
      complex8 _493 = _479;
      write_channel_intel(_bLoader_T_bFeeder_T_channel, _493);
      (void)_493;
     } // if _478
     int _494 = _addr_temp;
     int _495 = _494 + 1;
     _addr_temp = _495;
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
 complex8 _bFeeder_T_value_shreg;
 uint _bFeeder_T_time_stamp_shreg;
 complex8 _bFeeder_T_in_v_temp;
 uint _bFeeder_T_cycle_temp;
 complex8 __attribute__((memory, numbanks(4), singlepump)) _bFeeder_T_DB_0_ibuffer[2][16][32][4];
 #pragma unroll
 for (int _bFeeder_T_s0_iii_init = 0; _bFeeder_T_s0_iii_init < 0 + 4; _bFeeder_T_s0_iii_init++)
 {
  bool _496 = _bFeeder_T_s0_iii_init == 0;
  if (_496)
  {
   uint _497 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   _bFeeder_T_cycle_temp = _497;
  } // if _496
 } // for _bFeeder_T_s0_iii_init
 while(1)
 {
  uint _498 = (uint)(ADD_UINT64_T_SUFFIX(14336));
  uint _499 = _bFeeder_T_cycle_temp;
  uint _500 = (uint)(ADD_UINT64_T_SUFFIX(16383));
  uint _501 = _499 & _500;
  bool _502 = _498 <= _501;
  if (_502)
  {
   complex8 __503 = read_channel_intel(_bLoader_T_bFeeder_T_channel);
   _bFeeder_T_in_v_temp = __503;
  } // if _502
  #pragma unroll
  for (int _bFeeder_T_s0_buf = 0; _bFeeder_T_s0_buf < 0 + 4; _bFeeder_T_s0_buf++)
  {
   bool _504 = _bFeeder_T_s0_buf == 0;
   if (_504)
   {
    complex8 _505 = _bFeeder_T_in_v_temp;
    _bFeeder_T_value_shreg = _505;
    (void)_505;
    uint _506 = _bFeeder_T_cycle_temp;
    _bFeeder_T_time_stamp_shreg = _506;
    (void)_506;
   } // if _504
   else
   {
    complex8 _508 = _bFeeder_T_value_shreg;
    _bFeeder_T_value_shreg = _508;
    (void)_508;
    uint _510 = _bFeeder_T_time_stamp_shreg;
    _bFeeder_T_time_stamp_shreg = _510;
    (void)_510;
   } // if _504 else
   complex8 _512 = _bFeeder_T_value_shreg;
   complex8 _513 = __fpga_reg(__fpga_reg(_512));
   _bFeeder_T_value_shreg = _513;
   (void)_513;
   uint _515 = _bFeeder_T_time_stamp_shreg;
   uint _516 = __fpga_reg(__fpga_reg(_515));
   _bFeeder_T_time_stamp_shreg = _516;
   (void)_516;
   uint _517 = (uint)(ADD_UINT64_T_SUFFIX(14336));
   uint _519 = _bFeeder_T_time_stamp_shreg;
   uint _520 = (uint)(ADD_UINT64_T_SUFFIX(16383));
   uint _521 = _519 & _520;
   bool _522 = _517 <= _521;
   if (_522)
   {
    uint _524 = _bFeeder_T_time_stamp_shreg;
    uint _525 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _526 = _524 & _525;
    uint _527 = (uint)(ADD_UINT64_T_SUFFIX(14336));
    uint _528 = _526 - _527;
    uint _529 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _530 = _528 & _529;
    int _531 = (int)(_530);
    bool _532 = _bFeeder_T_s0_buf == _531;
    if (_532)
    {
     complex8 _534 = _bFeeder_T_value_shreg;
     uint _536 = _bFeeder_T_time_stamp_shreg;
     uint _537 = (uint)(ADD_UINT64_T_SUFFIX(14));
     uint _538 = _536 >> _537;
     uint _539 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _540 = _538 & _539;
     bool _541 = (bool)(_540);
     uint _543 = (uint)(ADD_UINT64_T_SUFFIX(16383));
     uint _544 = _536 & _543;
     uint _545 = (uint)(ADD_UINT64_T_SUFFIX(14336));
     uint _546 = _544 - _545;
     int _547 = (int)(_546);
     int _548 = _547 >> 7;
     int _550 = _547 >> 2;
     int _551 = _550 & 31;
     _bFeeder_T_DB_0_ibuffer[_541][_548][_551][_bFeeder_T_s0_buf] = _534;
    } // if _532
   } // if _522
   uint _552 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _554 = _bFeeder_T_time_stamp_shreg;
   uint _555 = (uint)(ADD_UINT64_T_SUFFIX(14));
   uint _556 = _554 >> _555;
   bool _557 = _552 < _556;
   if (_557)
   {
    uint _559 = _bFeeder_T_time_stamp_shreg;
    uint _560 = (uint)(ADD_UINT64_T_SUFFIX(14));
    uint _561 = _559 >> _560;
    uint _562 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _563 = _561 & _562;
    bool _564 = (bool)(_563);
    bool _565 = !(_564);
    uint _567 = (uint)(ADD_UINT64_T_SUFFIX(16383));
    uint _568 = _559 & _567;
    int _569 = (int)(_568);
    int _570 = _569 >> 10;
    int _572 = _569 >> 5;
    int _573 = _572 & 31;
    complex8 _574 = _bFeeder_T_DB_0_ibuffer[_565][_570][_573][_bFeeder_T_s0_buf];
    _bFeeder_T_Y_T_channel_array.s[_bFeeder_T_s0_buf] = _574;
    (void)_bFeeder_T_s0_buf;
   } // if _557
  } // for _bFeeder_T_s0_buf
  uint _575 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _577 = _bFeeder_T_time_stamp_shreg;
  uint _578 = (uint)(ADD_UINT64_T_SUFFIX(14));
  uint _579 = _577 >> _578;
  bool _580 = _575 < _579;
  if (_580)
  {
   write_channel_intel(_bFeeder_T_Y_T_channel, _bFeeder_T_Y_T_channel_array);
   (void)_bFeeder_T_Y_T_channel_array;
  } // if _580
  uint _581 = _bFeeder_T_cycle_temp;
  uint _582 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _583 = _581 + _582;
  _bFeeder_T_cycle_temp = _583;
 } // while _bFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_bFeeder_T
// Address spaces for kernel_Out_T
__kernel void kernel_Out_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 // produce Z_T
 complex _Z_T_shreg[1024][4][4];
 complex _Z_T_pipe_shreg[4][3073];
 // produce Y_T
 complex8 _Y_T_shreg[4];
 complex _Z_T_temp[4][4];
 complex _Z_temp[4][4];
 // produce X_T
 complex8 _X_T_shreg[4];
 _cga__1 _bFeeder_T_Y_T_channel_array;
 _cga__1 _aFeeder_T_X_T_channel_array;
 complex _Z_T_shreg_temp;
 int _Z_T_pipe_iter_temp;
 int _Z_T_pipe_base_temp;
 _Z_T_pipe_iter_temp = 4096;
 _Z_T_pipe_base_temp = 0;
 int _584 = _B_extent_0 >> 7;
 int _585 = _584 + 1;
 int patch_temp = (2 * (_B_extent_0 >> 7) - (_A_extent_1 >> 7) + 1) * (_A_extent_1 >> 7) / 2;
 for (int _X_T_s0_j_i = 0; _X_T_s0_j_i < 0 + patch_temp + 1; _X_T_s0_j_i++)
 {
  {
   int _591 = _A_extent_0 >> 7;
   for (int _X_T_s0_k = 0; _X_T_s0_k < 0 + _591; _X_T_s0_k++)
   {
    for (int _X_T_s0_kk_jj_ii = 0; _X_T_s0_kk_jj_ii < 0 + 16384; _X_T_s0_kk_jj_ii++)
    {
     #pragma unroll
     for (int _dummy__4_s0_jjj = 0; _dummy__4_s0_jjj < 0 + 4; _dummy__4_s0_jjj++)
     {
      #pragma unroll
      for (int _dummy__3_s0_iii = 0; _dummy__3_s0_iii < 0 + 4; _dummy__3_s0_iii++)
      {
       complex _593 = _Z_T_shreg[1023][_dummy__3_s0_iii][_dummy__4_s0_jjj];
       _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj] = _593;
       #pragma unroll
       for (int _dummy__5_s0_l1 = 0; _dummy__5_s0_l1 < 0 + 1023; _dummy__5_s0_l1++)
       {
        int _594 = 1023 - _dummy__5_s0_l1;
        int _595 = 1022 - _dummy__5_s0_l1;
        complex _597 = _Z_T_shreg[_595][_dummy__3_s0_iii][_dummy__4_s0_jjj];
        _Z_T_shreg[_594][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _597;
        (void)_597;
       } // for _dummy__5_s0_l1
       complex _598 = _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj];
       _Z_T_shreg[0][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _598;
       (void)_598;
      } // for _dummy__3_s0_iii
     } // for _dummy__4_s0_jjj
     int _599 = _B_extent_0 >> 7;
     bool _600 = _X_T_s0_j_i < patch_temp;
     if (_600)
     {
      _cga__1 __601 = read_channel_intel(_bFeeder_T_Y_T_channel);
      _bFeeder_T_Y_T_channel_array = __601;
      (void)__601;
      _cga__1 __602 = read_channel_intel(_aFeeder_T_X_T_channel);
      _aFeeder_T_X_T_channel_array = __602;
      (void)__602;
     } // if _600
     #pragma unroll
     for (int _X_T_s0_jjj = 0; _X_T_s0_jjj < 0 + 4; _X_T_s0_jjj++)
     {
      #pragma unroll
      for (int _X_T_s0_iii = 0; _X_T_s0_iii < 0 + 4; _X_T_s0_iii++)
      {
       complex8 _603;
       bool _604 = _X_T_s0_jjj == 0;
       if (_604)
       {
        complex8 __605 = _aFeeder_T_X_T_channel_array.s[_X_T_s0_iii];
        _603 = __605;
       } // if _604
       else
       {
        complex8 _607 = _X_T_shreg[_X_T_s0_iii];
        _603 = _607;
       } // if _604 else
       complex8 _608 = _603;
       _X_T_shreg[_X_T_s0_iii] = _608;
       (void)_608;
       complex8 _610 = _X_T_shreg[_X_T_s0_iii];
       complex8 _611 = __fpga_reg(__fpga_reg(_610));
       _X_T_shreg[_X_T_s0_iii] = _611;
       (void)_611;
       complex8 _612;
       bool _613 = _X_T_s0_iii == 0;
       if (_613)
       {
        complex8 __614 = _bFeeder_T_Y_T_channel_array.s[_X_T_s0_jjj];
        _612 = __614;
       } // if _613
       else
       {
        complex8 _616 = _Y_T_shreg[_X_T_s0_jjj];
        _612 = _616;
       } // if _613 else
       complex8 _617 = _612;
       _Y_T_shreg[_X_T_s0_jjj] = _617;
       (void)_617;
       complex8 _619 = _Y_T_shreg[_X_T_s0_jjj];
       complex8 _620 = __fpga_reg(__fpga_reg(_619));
       _Y_T_shreg[_X_T_s0_jjj] = _620;
       (void)_620;
       complex _621;
       bool _622 = _X_T_s0_k == 0;
       int _623 = _X_T_s0_kk_jj_ii >> 10;
       bool _624 = _623 == 0;
       bool _625 = _622 && _624;
       if (_625)
       {
        complex _626 = (complex)(ADD_UINT64_T_SUFFIX(0));
        _621 = _626;
       } // if _625
       else
       {
        complex _628 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
        complex _629 = __fpga_reg(_628);
        _621 = _629;
       } // if _625 else
       complex _630 = _621;
       _Z_T_shreg_temp = _630;
       #pragma unroll
       for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
       {
        complex _631 = _Z_T_shreg_temp;
        complex _633 = _X_T_shreg[_X_T_s0_iii].s[_X_T_s0_kkk];
        complex _634 = conjugate_c32(_633);
        complex _636 = _Y_T_shreg[_X_T_s0_jjj].s[_X_T_s0_kkk];
        complex _637 = (complex) {_634.s0 * _636.s0 - _634.s1 * _636.s1, _634.s0 * _636.s1 + _634.s1 * _636.s0};
        complex _638 = _631 + _637;
        _Z_T_shreg_temp = _638;
        int _639 = _X_T_s0_kkk & 3;
        bool _640 = _639 == 3;
        if (_640)
        {
         complex _641 = _Z_T_shreg_temp;
         complex _642 = __fpga_reg(_641);
         _Z_T_shreg_temp = _642;
        } // if _640
       } // for _X_T_s0_kkk
       complex _643 = _Z_T_shreg_temp;
       _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj] = _643;
       (void)_643;
       #pragma unroll
       for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
       {
        bool _644 = _X_T_s0_kkk == 7;
        int _645 = _X_T_s0_kk_jj_ii >> 10;
        bool _646 = _645 == 15;
        bool _647 = _644 && _646;
        int _648 = _A_extent_0 >> 7;
        int _649 = _648 + -1;
        bool _650 = _X_T_s0_k == _649;
        bool _651 = _647 && _650;
        if (_651)
        {
         int _652 = _X_T_s0_iii * 1024;
         complex _654 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
         _Z_T_pipe_shreg[_X_T_s0_jjj][_652] = _654;
         (void)_654;
        } // if _651
       } // for _X_T_s0_kkk
      } // for _X_T_s0_iii
     } // for _X_T_s0_jjj
     int _655 = _X_T_s0_kk_jj_ii & 31;
     bool _656 = _655 == 0;
     int _657 = _X_T_s0_kk_jj_ii & 1023;
     int _658 = _657 >> 5;
     bool _659 = _658 == 0;
     bool _660 = _656 && _659;
     int _661 = _A_extent_0 >> 7;
     int _662 = _661 + -1;
     bool _663 = _X_T_s0_k == _662;
     bool _664 = _660 && _663;
     int _665 = _X_T_s0_kk_jj_ii >> 10;
     bool _666 = _665 == 15;
     bool _667 = _664 && _666;
     int _668 = _B_extent_0 >> 7;
     bool _669 = _X_T_s0_j_i < patch_temp;
     bool _670 = _667 && _669;
     if (_670)
     {
      int _671 = _Z_T_pipe_iter_temp;
      _Z_T_pipe_base_temp = _671;
     } // if _670
     complex4 _Out_T_Add_channel_temp;
     #pragma unroll
     for (int _Z_T_pipe_b__14 = 0; _Z_T_pipe_b__14 < 0 + 4; _Z_T_pipe_b__14++)
     {
      complex _673 = _Z_T_pipe_shreg[_Z_T_pipe_b__14][0];
      _Out_T_Add_channel_temp.s[_Z_T_pipe_b__14] = _673;
      #pragma unroll
      for (int _Z_T_pipe_b__14_dummy = 0; _Z_T_pipe_b__14_dummy < 0 + 4; _Z_T_pipe_b__14_dummy++)
      {
       complex _674 = _Out_T_Add_channel_temp.s[_Z_T_pipe_b__14_dummy];
       complex _675 = __fpga_reg(__fpga_reg(_674));
       _Out_T_Add_channel_temp.s[_Z_T_pipe_b__14_dummy] = _675;
      } // for _Z_T_pipe_b__14_dummy
     } // for _Z_T_pipe_b__14
     int _676 = _Z_T_pipe_iter_temp;
     int _677 = _Z_T_pipe_base_temp;
     int _678 = _677 + 4096;
     bool _679 = _676 < _678;
     if (_679)
     {
      complex4 _680 = _Out_T_Add_channel_temp;
      write_channel_intel(_Out_T_Add_channel, _680);
      (void)_680;
     } // if _679
     #pragma unroll
     for (int _Z_T_pipe_b__15 = 0; _Z_T_pipe_b__15 < 0 + 4; _Z_T_pipe_b__15++)
     {
      #pragma unroll
      for (int _Z_T_pipe_p__7 = 0; _Z_T_pipe_p__7 < 0 + 3; _Z_T_pipe_p__7++)
      {
       #pragma unroll
       for (int _Z_T_pipe_l__7 = 0; _Z_T_pipe_l__7 < 0 + 1023; _Z_T_pipe_l__7++)
       {
        int _681 = _Z_T_pipe_p__7 * 1024;
        int _682 = _681 + _Z_T_pipe_l__7;
        int _683 = _682 + 1;
        complex _685 = _Z_T_pipe_shreg[_Z_T_pipe_b__15][_683];
        _Z_T_pipe_shreg[_Z_T_pipe_b__15][_682] = _685;
        (void)_685;
       } // for _Z_T_pipe_l__7
       int _686 = _Z_T_pipe_p__7 * 1024;
       int _687 = _686 + 1023;
       int _688 = _686 + 1024;
       complex _690 = _Z_T_pipe_shreg[_Z_T_pipe_b__15][_688];
       complex _691 = __fpga_reg(__fpga_reg(_690));
       _Z_T_pipe_shreg[_Z_T_pipe_b__15][_687] = _691;
       (void)_691;
      } // for _Z_T_pipe_p__7
     } // for _Z_T_pipe_b__15
     int _692 = _Z_T_pipe_iter_temp;
     int _693 = _692 + 1;
     _Z_T_pipe_iter_temp = _693;
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
 int _694 = _A_extent_1 >> 7;
 for (int _Add_s0_i = 0; _Add_s0_i < 0 + _694; _Add_s0_i++)
 {
  int _695 = _B_extent_0 >> 7;
  int _696 = _695 - _Add_s0_i;
  for (int _Add_s0_j = _Add_s0_i; _Add_s0_j < _Add_s0_i + _696; _Add_s0_j++)
  {
   for (int _Add_s0_ii_jj_iii = 0; _Add_s0_ii_jj_iii < 0 + 4096; _Add_s0_ii_jj_iii++)
   {
    complex4 __697 = read_channel_intel(_Out_Add_channel);
    complex4 __698 = read_channel_intel(_Out_T_Add_channel);
    complex4 _699 = (complex4){__697.t + __698.t};
    write_channel_intel(_Add_unloader_channel, _699);
    (void)_699;
   } // for _Add_s0_ii_jj_iii
  } // for _Add_s0_j
 } // for _Add_s0_i
} // kernel kernel_Add
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel complex *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _700 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _700; _unloader_s0_i++)
 {
  int _701 = _B_extent_0 >> 7;
  int _702 = _701 - _unloader_s0_i;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < _unloader_s0_i + _702; _unloader_s0_j++)
  {
   for (int _unloader_s0_ii_jj_iii = 0; _unloader_s0_ii_jj_iii < 0 + 4096; _unloader_s0_ii_jj_iii++)
   {
    complex4 __703 = read_channel_intel(_Add_unloader_channel);
    int _704 = _addr_temp;
    int _705 = _704 * 4;
    vstore8(__703.t, 0, (__address_space__unloader_mem_channel float*)(_unloader_mem_channel + _705));
    int _706 = _addr_temp;
    int _707 = _706 + 1;
    _addr_temp = _707;
   } // for _unloader_s0_ii_jj_iii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

