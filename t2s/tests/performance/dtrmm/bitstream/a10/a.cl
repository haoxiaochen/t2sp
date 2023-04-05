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
channel double8 _ALoader_channel __attribute__((depth(256))) ;
typedef struct { double8 s[8]; } _AFeeder_channel_array_t;
channel _AFeeder_channel_array_t _AFeeder_channel __attribute__((depth(256))) ;
channel double8 _BLoader_channel __attribute__((depth(256))) ;
typedef struct { double8 s[4]; } _BFeeder_channel_array_t;
channel _BFeeder_channel_array_t _BFeeder_channel __attribute__((depth(256))) ;
channel double4 _Out_channel __attribute__((depth(256))) ;
// Address spaces for kernel_ALoader
#define __address_space__ASerializer_mem_channel __global
__kernel void kernel_ALoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__ASerializer_mem_channel const double *restrict _ASerializer_mem_channel)
{
 int _0 = _A_extent_1 >> 7;
 int _1 = _0 + 1;
 for (int _ALoader_s0_i = 0; _ALoader_s0_i < 0 + _1; _ALoader_s0_i++)
 {
  int _2 = _B_extent_0 >> 7;
  for (int _ALoader_s0_j = 0; _ALoader_s0_j < 0 + _2; _ALoader_s0_j++)
  {
   int _3 = _A_extent_0 >> 7;
   int _4 = _3 - _ALoader_s0_i + ((_ALoader_s0_i < _0) ? 0 : 1);
   for (int _ALoader_s0_k = _ALoader_s0_i; _ALoader_s0_k < _ALoader_s0_i + _4; _ALoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _ALoader_s0_kk = 0; _ALoader_s0_kk < 0 + 16; _ALoader_s0_kk++)
    {
     for (int _ALoader_s0_ii = 0; _ALoader_s0_ii < 0 + 16; _ALoader_s0_ii++)
     {
      for (int _ALoader_s0_iii = 0; _ALoader_s0_iii < 0 + 8; _ALoader_s0_iii++)
      {
       bool _5 = _ALoader_s0_j == 0;
       bool _6 = _ALoader_s0_k == _ALoader_s0_i;
       bool _7 = _5 && _6;
       int _14 = _A_extent_1 >> 7;
       bool _15 = _ALoader_s0_i < _14;
       bool _16 = _7 || _15;
       if (_16)
       {
        double8 _18;
        int _19 = _A_extent_1 >> 7;
        bool _20 = _ALoader_s0_i < _19;
        if (_20)
        {
         int _21 = _ALoader_s0_iii * 8 + _ALoader_s0_ii * 64 + _ALoader_s0_kk * 1024;
         int _22 = _21 + _ALoader_s0_k * 16384;
         int _23 = _22 + _ALoader_s0_i * 16384 * _3;
         double8 _33 = vload8(0, (__address_space__ASerializer_mem_channel double*)_ASerializer_mem_channel + _23);
         _18 = _33;
        } // if _20
        else
        {
         double _34 = (double) float_from_bits(0 /* 0 */);
         double8 _35 = _34;
         _18 = _35;
        } // if _20 else
        double8 _36 = _18;
        write_channel_intel(_ALoader_channel, _36);
       } // if _16
      } // for _ALoader_s0_iii
     } // for _ALoader_s0_ii
    } // for _ALoader_s0_kk
   } // for _ALoader_s0_k
  } // for _ALoader_s0_j
 } // for _ALoader_s0_i
} // kernel kernel_ALoader
#undef __address_space__ASerializer_mem_channel
// Address spaces for kernel_AFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_AFeeder(
)
{
 _AFeeder_channel_array_t _AFeeder_channel_array;
 double8 _AFeeder_value_shreg;
 uint _AFeeder_time_stamp_shreg;
 double8 _AFeeder_in_v_temp;
 uint _AFeeder_cycle_temp;
 double8 __attribute__((memory, numbanks(8), singlepump, numwriteports(1), numreadports(1))) _AFeeder_DB_0_ibuffer[2][16][16][8];
 #pragma unroll
 for (int _AFeeder_s0_jjj_init = 0; _AFeeder_s0_jjj_init < 0 + 4; _AFeeder_s0_jjj_init++)
 {
  bool _39 = _AFeeder_s0_jjj_init == 0;
  if (_39)
  {
   uint _40 = (uint)(ADD_UINT64_T_SUFFIX(6144));
   _AFeeder_cycle_temp = _40;
  } // if _39
 } // for _AFeeder_s0_jjj_init
 while(1)
 {
  uint _41 = (uint)(ADD_UINT64_T_SUFFIX(6144));
  uint _42 = _AFeeder_cycle_temp;
  uint _43 = (uint)(ADD_UINT64_T_SUFFIX(8191));
  uint _44 = _42 & _43;
  bool _45 = _41 <= _44;
  if (_45)
  {
   double8 __46 = read_channel_intel(_ALoader_channel);
   _AFeeder_in_v_temp = __46;
  } // if _45
  #pragma unroll
  for (int _AFeeder_s0_buf = 0; _AFeeder_s0_buf < 0 + 8; _AFeeder_s0_buf++)
  {
   bool _47 = _AFeeder_s0_buf == 0;
   if (_47)
   {
    double8 _48 = _AFeeder_in_v_temp;
    _AFeeder_value_shreg = _48;
    (void)_48;
    uint _49 = _AFeeder_cycle_temp;
    _AFeeder_time_stamp_shreg = _49;
    (void)_49;
   } // if _47
   else
   {
    double8 _51 = _AFeeder_value_shreg;
    _AFeeder_value_shreg = _51;
    (void)_51;
    uint _53 = _AFeeder_time_stamp_shreg;
    _AFeeder_time_stamp_shreg = _53;
    (void)_53;
   } // if _47 else
   double8 _55 = _AFeeder_value_shreg;
   double8 _56 = __fpga_reg(__fpga_reg(_55));
   _AFeeder_value_shreg = _56;
   (void)_56;
   uint _58 = _AFeeder_time_stamp_shreg;
   uint _59 = __fpga_reg(__fpga_reg(_58));
   _AFeeder_time_stamp_shreg = _59;
   (void)_59;
   uint _60 = (uint)(ADD_UINT64_T_SUFFIX(6144));
   uint _62 = _AFeeder_time_stamp_shreg;
   uint _63 = (uint)(ADD_UINT64_T_SUFFIX(8191));
   uint _64 = _62 & _63;
   bool _65 = _60 <= _64;
   if (_65)
   {
    uint _67 = _AFeeder_time_stamp_shreg;
    uint _68 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _69 = _67 & _68;
    uint _70 = (uint)(ADD_UINT64_T_SUFFIX(6144));
    uint _71 = _69 - _70;
    uint _72 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _73 = _71 & _72;
    int _74 = (int)(_73);
    bool _75 = _AFeeder_s0_buf == _74;
    if (_75)
    {
     double8 _77 = _AFeeder_value_shreg;
     uint _79 = _AFeeder_time_stamp_shreg;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(13));
     uint _81 = _79 >> _80;
     uint _82 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _83 = _81 & _82;
     bool _84 = (bool)(_83);
     uint _86 = (uint)(ADD_UINT64_T_SUFFIX(8191));
     uint _87 = _79 & _86;
     uint _88 = (uint)(ADD_UINT64_T_SUFFIX(6144));
     uint _89 = _87 - _88;
     int _90 = (int)(_89);
     int _91 = _90 >> 7;
     int _93 = _90 >> 3;
     int _94 = _93 & 15;
     _AFeeder_DB_0_ibuffer[_84][_91][_94][_AFeeder_s0_buf] = _77;
    } // if _75
   } // if _65
   uint _95 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _97 = _AFeeder_time_stamp_shreg;
   uint _98 = (uint)(ADD_UINT64_T_SUFFIX(13));
   uint _99 = _97 >> _98;
   bool _100 = _95 < _99;
   if (_100)
   {
    uint _102 = _AFeeder_time_stamp_shreg;
    uint _103 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _104 = _102 & _103;
    int _105 = (int)(_104);
    uint _106 = (uint)(ADD_UINT64_T_SUFFIX(13));
    uint _107 = _102 >> _106;
    uint _108 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _109 = _107 & _108;
    bool _110 = (bool)(_109);
    bool _111 = !(_110);
    int _112 = _105 >> 9;
    int _113 = _105 >> 5;
    int _114 = _113 & 15;
    double8 _115 = _AFeeder_DB_0_ibuffer[_111][_112][_114][_AFeeder_s0_buf];
    _AFeeder_channel_array.s[_AFeeder_s0_buf] = _115;
    (void)_AFeeder_s0_buf;
   } // if _100
  } // for _AFeeder_s0_buf
  uint _116 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _118 = _AFeeder_time_stamp_shreg;
  uint _119 = (uint)(ADD_UINT64_T_SUFFIX(13));
  uint _120 = _118 >> _119;
  bool _121 = _116 < _120;
  if (_121)
  {
   write_channel_intel(_AFeeder_channel, _AFeeder_channel_array);
   (void)_AFeeder_channel_array;
  } // if _121
  uint _122 = _AFeeder_cycle_temp;
  uint _123 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _124 = _122 + _123;
  _AFeeder_cycle_temp = _124;
 } // while _AFeeder_s0_outermost_loop_infinite
} // kernel kernel_AFeeder
// Address spaces for kernel_BLoader
#define __address_space__BSerializer_mem_channel __global
__kernel void kernel_BLoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__BSerializer_mem_channel const double *restrict _BSerializer_mem_channel)
{
 int _125 = _A_extent_1 >> 7;
 int _126 = _125 + 1;
 for (int _BLoader_s0_i = 0; _BLoader_s0_i < 0 + _126; _BLoader_s0_i++)
 {
  int _127 = _B_extent_0 >> 7;
  for (int _BLoader_s0_j = 0; _BLoader_s0_j < 0 + _127; _BLoader_s0_j++)
  {
   int _128 = _A_extent_0 >> 7;
   int _129 = _128 - _BLoader_s0_i + ((_BLoader_s0_i < _125) ? 0 : 1);
   for (int _BLoader_s0_k = _BLoader_s0_i; _BLoader_s0_k < _BLoader_s0_i + _129; _BLoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _BLoader_s0_kk = 0; _BLoader_s0_kk < 0 + 16; _BLoader_s0_kk++)
    {
     for (int _BLoader_s0_jj = 0; _BLoader_s0_jj < 0 + 32; _BLoader_s0_jj++)
     {
      for (int _BLoader_s0_jjj = 0; _BLoader_s0_jjj < 0 + 4; _BLoader_s0_jjj++)
      {
       bool _130 = _BLoader_s0_j == 0;
       bool _131 = _BLoader_s0_k == _BLoader_s0_i;
       bool _132 = _130 && _131;
       int _139 = _A_extent_1 >> 7;
       bool _140 = _BLoader_s0_i < _139;
       bool _141 = _132 || _140;
       if (_141)
       {
        double8 _142;
        int _143 = _A_extent_1 >> 7;
        bool _144 = _BLoader_s0_i < _143;
        if (_144)
        {
         int _21 = _BLoader_s0_jjj * 8 + _BLoader_s0_jj * 32 + _BLoader_s0_kk * 1024;
         int _22 = _21 + _BLoader_s0_k * 16384;
         int _23 = _22 + _BLoader_s0_j * 16384 * _128;
         double8 _153 = vload8(0, (__address_space__BSerializer_mem_channel double*)_BSerializer_mem_channel + _23);
         _142 = _153;
        } // if _144
        else
        {
         double _154 = (double) float_from_bits(0 /* 0 */);
         double8 _155 = _154;
         _142 = _155;
        } // if _144 else
        double8 _156 = _142;
        write_channel_intel(_BLoader_channel, _156);
       } // if _141
      } // for _BLoader_s0_jjj
     } // for _BLoader_s0_jj
    } // for _BLoader_s0_kk
   } // for _BLoader_s0_k
  } // for _BLoader_s0_j
 } // for _BLoader_s0_i
} // kernel kernel_BLoader
#undef __address_space__BSerializer_mem_channel
// Address spaces for kernel_BFeeder
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_BFeeder(
)
{
 _BFeeder_channel_array_t _BFeeder_channel_array;
 double8 _BFeeder_value_shreg;
 uint _BFeeder_time_stamp_shreg;
 double8 _BFeeder_in_v_temp;
 uint _BFeeder_cycle_temp;
 double8 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _BFeeder_DB_0_ibuffer[2][16][32][4];
 #pragma unroll
 for (int _BFeeder_s0_iii_init = 0; _BFeeder_s0_iii_init < 0 + 8; _BFeeder_s0_iii_init++)
 {
  bool _159 = _BFeeder_s0_iii_init == 0;
  if (_159)
  {
   uint _160 = (uint)(ADD_UINT64_T_SUFFIX(6144));
   _BFeeder_cycle_temp = _160;
  } // if _159
 } // for _BFeeder_s0_iii_init
 while(1)
 {
  uint _161 = (uint)(ADD_UINT64_T_SUFFIX(6144));
  uint _162 = _BFeeder_cycle_temp;
  uint _163 = (uint)(ADD_UINT64_T_SUFFIX(8191));
  uint _164 = _162 & _163;
  bool _165 = _161 <= _164;
  if (_165)
  {
   double8 __166 = read_channel_intel(_BLoader_channel);
   _BFeeder_in_v_temp = __166;
  } // if _165
  #pragma unroll
  for (int _BFeeder_s0_buf = 0; _BFeeder_s0_buf < 0 + 4; _BFeeder_s0_buf++)
  {
   bool _167 = _BFeeder_s0_buf == 0;
   if (_167)
   {
    double8 _168 = _BFeeder_in_v_temp;
    _BFeeder_value_shreg = _168;
    (void)_168;
    uint _169 = _BFeeder_cycle_temp;
    _BFeeder_time_stamp_shreg = _169;
    (void)_169;
   } // if _167
   else
   {
    double8 _171 = _BFeeder_value_shreg;
    _BFeeder_value_shreg = _171;
    (void)_171;
    uint _173 = _BFeeder_time_stamp_shreg;
    _BFeeder_time_stamp_shreg = _173;
    (void)_173;
   } // if _167 else
   double8 _175 = _BFeeder_value_shreg;
   double8 _176 = __fpga_reg(__fpga_reg(_175));
   _BFeeder_value_shreg = _176;
   (void)_176;
   uint _178 = _BFeeder_time_stamp_shreg;
   uint _179 = __fpga_reg(__fpga_reg(_178));
   _BFeeder_time_stamp_shreg = _179;
   (void)_179;
   uint _180 = (uint)(ADD_UINT64_T_SUFFIX(6144));
   uint _182 = _BFeeder_time_stamp_shreg;
   uint _183 = (uint)(ADD_UINT64_T_SUFFIX(8191));
   uint _184 = _182 & _183;
   bool _185 = _180 <= _184;
   if (_185)
   {
    uint _187 = _BFeeder_time_stamp_shreg;
    uint _188 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _189 = _187 & _188;
    uint _190 = (uint)(ADD_UINT64_T_SUFFIX(6144));
    uint _191 = _189 - _190;
    uint _192 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _193 = _191 & _192;
    int _194 = (int)(_193);
    bool _195 = _BFeeder_s0_buf == _194;
    if (_195)
    {
     double8 _197 = _BFeeder_value_shreg;
     uint _199 = _BFeeder_time_stamp_shreg;
     uint _200 = (uint)(ADD_UINT64_T_SUFFIX(13));
     uint _201 = _199 >> _200;
     uint _202 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _203 = _201 & _202;
     bool _204 = (bool)(_203);
     uint _206 = (uint)(ADD_UINT64_T_SUFFIX(8191));
     uint _207 = _199 & _206;
     uint _208 = (uint)(ADD_UINT64_T_SUFFIX(6144));
     uint _209 = _207 - _208;
     int _210 = (int)(_209);
     int _211 = _210 >> 7;
     int _213 = _210 >> 2;
     int _214 = _213 & 31;
     _BFeeder_DB_0_ibuffer[_204][_211][_214][_BFeeder_s0_buf] = _197;
    } // if _195
   } // if _185
   uint _215 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _217 = _BFeeder_time_stamp_shreg;
   uint _218 = (uint)(ADD_UINT64_T_SUFFIX(13));
   uint _219 = _217 >> _218;
   bool _220 = _215 < _219;
   if (_220)
   {
    uint _222 = _BFeeder_time_stamp_shreg;
    uint _223 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _224 = _222 & _223;
    int _225 = (int)(_224);
    uint _226 = (uint)(ADD_UINT64_T_SUFFIX(13));
    uint _227 = _222 >> _226;
    uint _228 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _229 = _227 & _228;
    bool _230 = (bool)(_229);
    bool _231 = !(_230);
    int _232 = _225 >> 9;
    int _233 = _225 & 31;
    double8 _234 = _BFeeder_DB_0_ibuffer[_231][_232][_233][_BFeeder_s0_buf];
    _BFeeder_channel_array.s[_BFeeder_s0_buf] = _234;
    (void)_BFeeder_s0_buf;
   } // if _220
  } // for _BFeeder_s0_buf
  uint _235 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _237 = _BFeeder_time_stamp_shreg;
  uint _238 = (uint)(ADD_UINT64_T_SUFFIX(13));
  uint _239 = _237 >> _238;
  bool _240 = _235 < _239;
  if (_240)
  {
   write_channel_intel(_BFeeder_channel, _BFeeder_channel_array);
   (void)_BFeeder_channel_array;
  } // if _240
  uint _241 = _BFeeder_cycle_temp;
  uint _242 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _243 = _241 + _242;
  _BFeeder_cycle_temp = _243;
 } // while _BFeeder_s0_outermost_loop_infinite
} // kernel kernel_BFeeder
// Address spaces for kernel_Out
__kernel void kernel_Out(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 _BFeeder_channel_array_t _BFeeder_channel_array;
 _AFeeder_channel_array_t _AFeeder_channel_array;
 // produce Z
 double _Z_shreg[512][4][8];
 double _Z_pipe_shreg[4][3585];
 // produce Y
 double8 _Y_shreg[4];
 double _Z_temp[4][8];
 // produce X
 double8 _X_shreg[8];
 double _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 4096;
 _Z_pipe_base_temp = 0;
 int _244 = _A_extent_1 >> 7;
 int _245 = _244 + 1;
 for (int _X_s0_i = 0; _X_s0_i < 0 + _245; _X_s0_i++)
 {
  int _246 = _B_extent_0 >> 7;
  for (int _X_s0_j = 0; _X_s0_j < 0 + _246; _X_s0_j++)
  {
   int _247 = _A_extent_0 >> 7;
   int _248 = _247 - _X_s0_i + ((_X_s0_i < _244) ? 0 : 1);
   for (int _X_s0_k = _X_s0_i; _X_s0_k < _X_s0_i + _248; _X_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _X_s0_kk = 0; _X_s0_kk < 0 + 16; _X_s0_kk++)
    {
     for (int _X_s0_ii = 0; _X_s0_ii < 0 + 16; _X_s0_ii++)
     {
      for (int _X_s0_jj = 0; _X_s0_jj < 0 + 32; _X_s0_jj++)
      {
       #pragma unroll
       for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 8; _dummy__1_s0_iii++)
       {
        #pragma unroll
        for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 4; _dummy_s0_jjj++)
        {
         double _250 = _Z_shreg[511][_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _250;
         #pragma unroll
         for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 511; _dummy__2_s0_l1++)
         {
          int _251 = 511 - _dummy__2_s0_l1;
          int _252 = 510 - _dummy__2_s0_l1;
          double _254 = _Z_shreg[_252][_dummy_s0_jjj][_dummy__1_s0_iii];
          _Z_shreg[_251][_dummy_s0_jjj][_dummy__1_s0_iii] = _254;
          (void)_254;
         } // for _dummy__2_s0_l1
         double _255 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _255;
         (void)_255;
        } // for _dummy_s0_jjj
       } // for _dummy__1_s0_iii
       int _256 = _A_extent_1 >> 7;
       bool _257 = _X_s0_i < _256;
       if (_257)
       {
        _BFeeder_channel_array_t __258 = read_channel_intel(_BFeeder_channel);
        _BFeeder_channel_array = __258;
        (void)__258;
        _AFeeder_channel_array_t __259 = read_channel_intel(_AFeeder_channel);
        _AFeeder_channel_array = __259;
        (void)__259;
       } // if _257
       #pragma unroll
       for (int _X_s0_iii = 0; _X_s0_iii < 0 + 8; _X_s0_iii++)
       {
        #pragma unroll
        for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 4; _X_s0_jjj++)
        {
         double8 _260;
         bool _261 = _X_s0_jjj == 0;
         if (_261)
         {
          double8 __262 = _AFeeder_channel_array.s[_X_s0_iii];
          _260 = __262;
         } // if _261
         else
         {
          double8 _264 = _X_shreg[_X_s0_iii];
          _260 = _264;
         } // if _261 else
         double8 _265 = _260;
         _X_shreg[_X_s0_iii] = _265;
         (void)_265;
         double8 _267 = _X_shreg[_X_s0_iii];
         double8 _268 = __fpga_reg(__fpga_reg(_267));
         _X_shreg[_X_s0_iii] = _268;
         (void)_268;
         double8 _269;
         bool _270 = _X_s0_iii == 0;
         if (_270)
         {
          double8 __271 = _BFeeder_channel_array.s[_X_s0_jjj];
          _269 = __271;
         } // if _270
         else
         {
          double8 _273 = _Y_shreg[_X_s0_jjj];
          _269 = _273;
         } // if _270 else
         double8 _274 = _269;
         _Y_shreg[_X_s0_jjj] = _274;
         (void)_274;
         double8 _276 = _Y_shreg[_X_s0_jjj];
         double8 _277 = __fpga_reg(__fpga_reg(_276));
         _Y_shreg[_X_s0_jjj] = _277;
         (void)_277;
         double _278;
         bool _279 = _X_s0_k == _X_s0_i;
         bool _280 = _X_s0_kk == 0;
         bool _281 = _279 && _280;
         if (_281)
         {
          double _282 = (double) float_from_bits(0 /* 0 */);
          _278 = _282;
         } // if _281
         else
         {
          double _284 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
          double _285 = __fpga_reg(_284);
          _278 = _285;
         } // if _281 else
         double _286 = _278;
         _Z_shreg_temp = _286;
         #pragma unroll
         for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
         {
          double _287 = _Z_shreg_temp;
          double _289 = _X_shreg[_X_s0_iii][_X_s0_kkk];
          double _291 = _Y_shreg[_X_s0_jjj][_X_s0_kkk];
          double _292 = _289 * _291;
          double _293 = _287 + _292;
          _Z_shreg_temp = _293;
          int _294 = _X_s0_kkk & 3;
          bool _295 = _294 == 3;
          if (_295)
          {
           double _296 = _Z_shreg_temp;
           double _297 = __fpga_reg(_296);
           _Z_shreg_temp = _297;
          } // if _295
         } // for _X_s0_kkk
         double _298 = _Z_shreg_temp;
         _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _298;
         (void)_298;
         #pragma unroll
         for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 8; _X_s0_kkk++)
         {
          bool _299 = _X_s0_kkk == 7;
          bool _300 = _X_s0_kk == 15;
          bool _301 = _299 && _300;
          int _302 = _A_extent_0 >> 7;
          int _303 = _302 + -1;
          bool _304 = _X_s0_k == _303;
          bool _305 = _301 && _304;
          if (_305)
          {
           int _306 = _X_s0_iii * 512;
           double _308 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
           _Z_pipe_shreg[_X_s0_jjj][_306] = _308;
           (void)_308;
          } // if _305
         } // for _X_s0_kkk
        } // for _X_s0_jjj
       } // for _X_s0_iii
       bool _309 = _X_s0_jj == 0;
       bool _310 = _X_s0_ii == 0;
       bool _311 = _309 && _310;
       int _312 = _A_extent_0 >> 7;
       int _313 = _312 + -1;
       bool _314 = _X_s0_k == _313;
       bool _315 = _311 && _314;
       bool _316 = _X_s0_kk == 15;
       bool _317 = _315 && _316;
       int _318 = _A_extent_1 >> 7;
       bool _319 = _X_s0_i < _318;
       bool _320 = _317 && _319;
       if (_320)
       {
        int _321 = _Z_pipe_iter_temp;
        _Z_pipe_base_temp = _321;
       } // if _320
       double4 _Out_channel_temp;
       #pragma unroll
       for (int _Z_pipe_b__62 = 0; _Z_pipe_b__62 < 0 + 4; _Z_pipe_b__62++)
       {
        double _323 = _Z_pipe_shreg[_Z_pipe_b__62][0];
        _Out_channel_temp[_Z_pipe_b__62] = _323;
        #pragma unroll
        for (int _Z_pipe_b__62_dummy = 0; _Z_pipe_b__62_dummy < 0 + 4; _Z_pipe_b__62_dummy++)
        {
         double _324 = _Out_channel_temp[_Z_pipe_b__62_dummy];
         double _325 = __fpga_reg(__fpga_reg(_324));
         _Out_channel_temp[_Z_pipe_b__62_dummy] = _325;
        } // for _Z_pipe_b__62_dummy
       } // for _Z_pipe_b__62
       int _326 = _Z_pipe_iter_temp;
       int _327 = _Z_pipe_base_temp;
       int _328 = _327 + 4096;
       bool _329 = _326 < _328;
       if (_329)
       {
        double4 _330 = _Out_channel_temp;
        write_channel_intel(_Out_channel, _330);
        (void)_330;
       } // if _329
       #pragma unroll
       for (int _Z_pipe_b__63 = 0; _Z_pipe_b__63 < 0 + 4; _Z_pipe_b__63++)
       {
        #pragma unroll
        for (int _Z_pipe_p__31 = 0; _Z_pipe_p__31 < 0 + 7; _Z_pipe_p__31++)
        {
         #pragma unroll
         for (int _Z_pipe_l__31 = 0; _Z_pipe_l__31 < 0 + 511; _Z_pipe_l__31++)
         {
          int _331 = _Z_pipe_p__31 * 512;
          int _332 = _331 + _Z_pipe_l__31;
          int _333 = _332 + 1;
          double _335 = _Z_pipe_shreg[_Z_pipe_b__63][_333];
          _Z_pipe_shreg[_Z_pipe_b__63][_332] = _335;
          (void)_335;
         } // for _Z_pipe_l__31
         int _336 = _Z_pipe_p__31 * 512;
         int _337 = _336 + 511;
         int _338 = _336 + 512;
         double _340 = _Z_pipe_shreg[_Z_pipe_b__63][_338];
         double _341 = __fpga_reg(__fpga_reg(_340));
         _Z_pipe_shreg[_Z_pipe_b__63][_337] = _341;
         (void)_341;
        } // for _Z_pipe_p__31
       } // for _Z_pipe_b__63
       int _342 = _Z_pipe_iter_temp;
       int _343 = _342 + 1;
       _Z_pipe_iter_temp = _343;
      } // for _X_s0_jj
     } // for _X_s0_ii
    } // for _X_s0_kk
   } // for _X_s0_k
  } // for _X_s0_j
 } // for _X_s0_i
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel double *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _344 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _344; _unloader_s0_i++)
 {
  int _345 = _B_extent_0 >> 7;
  for (int _unloader_s0_j = 0; _unloader_s0_j < 0 + _345; _unloader_s0_j++)
  {
   #pragma loop_coalesce 3
   for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 8; _unloader_s0_iii++)
   {
    for (int _unloader_s0_ii = 0; _unloader_s0_ii < 0 + 16; _unloader_s0_ii++)
    {
     for (int _unloader_s0_jj = 0; _unloader_s0_jj < 0 + 32; _unloader_s0_jj++)
     {
      double4 __346 = read_channel_intel(_Out_channel);
      int _347 = _addr_temp;
      int _348 = _347 * 4;
      vstore4(__346, 0, (__address_space__unloader_mem_channel double*)_unloader_mem_channel + _348);
      int _349 = _addr_temp;
      int _350 = _349 + 1;
      _addr_temp = _350;
     } // for _unloader_s0_jj
    } // for _unloader_s0_ii
   } // for _unloader_s0_iii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

