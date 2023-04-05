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
bool __attribute__ ((aligned(4))) s[4];
struct {bool s0,  s1,  s2,  s3;};
} bool4;
channel complexd4 _ALoader_channel __attribute__((depth(128))) ;
typedef struct { complexd4 s[4]; } _AFeeder_channel_array_t;
channel _AFeeder_channel_array_t _AFeeder_channel __attribute__((depth(128))) ;
channel complexd4 _BLoader_channel __attribute__((depth(128))) ;
typedef struct { complexd4 s[4]; } _BFeeder_channel_array_t;
channel _BFeeder_channel_array_t _BFeeder_channel __attribute__((depth(128))) ;
channel complexd4 _Out_channel __attribute__((depth(128))) ;
// Address spaces for kernel_ALoader
#define __address_space__ASerializer_mem_channel __global
__kernel void kernel_ALoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__ASerializer_mem_channel const complexd *restrict _ASerializer_mem_channel)
{
 int _0 = _A_extent_1 >> 6;
 int _1 = _0 + 1;
 for (int _ALoader_s0_i = 0; _ALoader_s0_i < 0 + _1; _ALoader_s0_i++)
 {
  int _2 = _B_extent_0 >> 6;
  int _3 = _2 - _ALoader_s0_i + ((_ALoader_s0_i < _0) ? 0 : 1);
  for (int _ALoader_s0_j = _ALoader_s0_i; _ALoader_s0_j < _ALoader_s0_i + _3; _ALoader_s0_j++)
  {
   int _4 = _A_extent_0 >> 6;
   for (int _ALoader_s0_k = 0; _ALoader_s0_k < 0 + _4; _ALoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _ALoader_s0_kk = 0; _ALoader_s0_kk < 0 + 16; _ALoader_s0_kk++)
    {
     for (int _ALoader_s0_ii = 0; _ALoader_s0_ii < 0 + 16; _ALoader_s0_ii++)
     {
      for (int _ALoader_s0_iii = 0; _ALoader_s0_iii < 0 + 4; _ALoader_s0_iii++)
      {
       bool _5 = _ALoader_s0_j == _ALoader_s0_i;
       bool _6 = _ALoader_s0_k == 0;
       bool _7 = _5 && _6;
       int _14 = _A_extent_1 >> 6;
       bool _15 = _ALoader_s0_i < _14;
       bool _16 = _7 || _15;
       if (_16)
       {
        complexd4 _18;
        int _19 = _A_extent_1 >> 6;
        bool _20 = _ALoader_s0_i < _19;
        if (_20)
        {
         int _21 = _ALoader_s0_iii * 4 + _ALoader_s0_ii * 16 + _ALoader_s0_kk * 256;
         int _22 = _21 + _ALoader_s0_k * 4096;
         int _23 = _22 + _ALoader_s0_i * 4096 * _4;
         complexd4 _33 = {vload8(0, (__address_space__ASerializer_mem_channel double*)(_ASerializer_mem_channel + _23))};
         _18 = _33;
        } // if _20
        else
        {
         complexd _34 = (complexd)(0.000000, 0.000000);
         complexd4 _35 = (complexd4)(double8){_34, _34, _34, _34};
         _18 = _35;
        } // if _20 else
        complexd4 _36 = _18;
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
 complexd4 _AFeeder_value_shreg;
 uint _AFeeder_time_stamp_shreg;
 complexd4 _AFeeder_in_v_temp;
 uint _AFeeder_cycle_temp;
 complexd4 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _AFeeder_DB_0_ibuffer[2][16][16][4];
 #pragma unroll
 for (int _AFeeder_s0_jjj_init = 0; _AFeeder_s0_jjj_init < 0 + 4; _AFeeder_s0_jjj_init++)
 {
  bool _39 = _AFeeder_s0_jjj_init == 0;
  if (_39)
  {
   uint _40 = (uint)(ADD_UINT64_T_SUFFIX(3072));
   _AFeeder_cycle_temp = _40;
  } // if _39
 } // for _AFeeder_s0_jjj_init
 while(1)
 {
  uint _41 = (uint)(ADD_UINT64_T_SUFFIX(3072));
  uint _42 = _AFeeder_cycle_temp;
  uint _43 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _44 = _42 & _43;
  bool _45 = _41 <= _44;
  if (_45)
  {
   complexd4 __46 = read_channel_intel(_ALoader_channel);
   _AFeeder_in_v_temp = __46;
  } // if _45
  #pragma unroll
  for (int _AFeeder_s0_buf = 0; _AFeeder_s0_buf < 0 + 4; _AFeeder_s0_buf++)
  {
   bool _47 = _AFeeder_s0_buf == 0;
   if (_47)
   {
    complexd4 _48 = _AFeeder_in_v_temp;
    _AFeeder_value_shreg = _48;
    (void)_48;
    uint _49 = _AFeeder_cycle_temp;
    _AFeeder_time_stamp_shreg = _49;
    (void)_49;
   } // if _47
   else
   {
    complexd4 _51 = _AFeeder_value_shreg;
    _AFeeder_value_shreg = _51;
    (void)_51;
    uint _53 = _AFeeder_time_stamp_shreg;
    _AFeeder_time_stamp_shreg = _53;
    (void)_53;
   } // if _47 else
   complexd4 _55 = _AFeeder_value_shreg;
   complexd4 _56 = __fpga_reg(__fpga_reg(_55));
   _AFeeder_value_shreg = _56;
   (void)_56;
   uint _58 = _AFeeder_time_stamp_shreg;
   uint _59 = __fpga_reg(__fpga_reg(_58));
   _AFeeder_time_stamp_shreg = _59;
   (void)_59;
   uint _60 = (uint)(ADD_UINT64_T_SUFFIX(3072));
   uint _62 = _AFeeder_time_stamp_shreg;
   uint _63 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _64 = _62 & _63;
   bool _65 = _60 <= _64;
   if (_65)
   {
    uint _67 = _AFeeder_time_stamp_shreg;
    uint _68 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _69 = _67 & _68;
    uint _70 = (uint)(ADD_UINT64_T_SUFFIX(3072));
    uint _71 = _69 - _70;
    uint _72 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _73 = _71 & _72;
    int _74 = (int)(_73);
    bool _75 = _AFeeder_s0_buf == _74;
    if (_75)
    {
     complexd4 _77 = _AFeeder_value_shreg;
     uint _79 = _AFeeder_time_stamp_shreg;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _81 = _79 >> _80;
     uint _82 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _83 = _81 & _82;
     bool _84 = (bool)(_83);
     uint _86 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _87 = _79 & _86;
     uint _88 = (uint)(ADD_UINT64_T_SUFFIX(3072));
     uint _89 = _87 - _88;
     int _90 = (int)(_89);
     int _91 = _90 >> 6;
     int _93 = _90 >> 2;
     int _94 = _93 & 15;
     _AFeeder_DB_0_ibuffer[_84][_91][_94][_AFeeder_s0_buf] = _77;
    } // if _75
   } // if _65
   uint _95 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _97 = _AFeeder_time_stamp_shreg;
   uint _98 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _99 = _97 >> _98;
   bool _100 = _95 < _99;
   if (_100)
   {
    uint _102 = _AFeeder_time_stamp_shreg;
    uint _103 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _104 = _102 & _103;
    int _105 = (int)(_104);
    uint _106 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _107 = _102 >> _106;
    uint _108 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _109 = _107 & _108;
    bool _110 = (bool)(_109);
    bool _111 = !(_110);
    int _112 = _105 >> 8;
    int _113 = _105 >> 4;
    int _114 = _113 & 15;
    complexd4 _115 = _AFeeder_DB_0_ibuffer[_111][_112][_114][_AFeeder_s0_buf];
    _AFeeder_channel_array.s[_AFeeder_s0_buf] = _115;
    (void)_AFeeder_s0_buf;
   } // if _100
  } // for _AFeeder_s0_buf
  uint _116 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _118 = _AFeeder_time_stamp_shreg;
  uint _119 = (uint)(ADD_UINT64_T_SUFFIX(12));
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
 __address_space__BSerializer_mem_channel const complexd *restrict _BSerializer_mem_channel)
{
 int _125 = _A_extent_1 >> 6;
 int _126 = _125 + 1;
 for (int _BLoader_s0_i = 0; _BLoader_s0_i < 0 + _126; _BLoader_s0_i++)
 {
  int _127 = _B_extent_0 >> 6;
  int _128 = _127 - _BLoader_s0_i + ((_BLoader_s0_i < _125) ? 0 : 1);
  for (int _BLoader_s0_j = _BLoader_s0_i; _BLoader_s0_j < _BLoader_s0_i + _128; _BLoader_s0_j++)
  {
   int _129 = _A_extent_0 >> 6;
   for (int _BLoader_s0_k = 0; _BLoader_s0_k < 0 + _129; _BLoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _BLoader_s0_kk = 0; _BLoader_s0_kk < 0 + 16; _BLoader_s0_kk++)
    {
     for (int _BLoader_s0_jj = 0; _BLoader_s0_jj < 0 + 16; _BLoader_s0_jj++)
     {
      for (int _BLoader_s0_jjj = 0; _BLoader_s0_jjj < 0 + 4; _BLoader_s0_jjj++)
      {
       bool _130 = _BLoader_s0_j == _BLoader_s0_i;
       bool _131 = _BLoader_s0_k == 0;
       bool _132 = _130 && _131;
       int _139 = _A_extent_1 >> 6;
       bool _140 = _BLoader_s0_i < _139;
       bool _141 = _132 || _140;
       if (_141)
       {
        complexd4 _142;
        int _143 = _A_extent_1 >> 6;
        bool _144 = _BLoader_s0_i < _143;
        if (_144)
        {
         int _21 = _BLoader_s0_jjj * 4 + _BLoader_s0_jj * 16 + _BLoader_s0_kk * 256;
         int _22 = _21 + _BLoader_s0_k * 4096;
         int _23 = _22 + _BLoader_s0_j * 4096 * _129;
         complexd4 _153 = {vload8(0, (__address_space__BSerializer_mem_channel double*)(_BSerializer_mem_channel + _23))};
         _142 = _153;
        } // if _144
        else
        {
         complexd _154 = (complexd)(0.000000, 0.000000);
         complexd4 _155 = (complexd4)(double8){_154, _154, _154, _154};
         _142 = _155;
        } // if _144 else
        complexd4 _156 = _142;
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
 complexd4 _BFeeder_value_shreg;
 uint _BFeeder_time_stamp_shreg;
 complexd4 _BFeeder_in_v_temp;
 uint _BFeeder_cycle_temp;
 complexd4 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _BFeeder_DB_0_ibuffer[2][16][16][4];
 #pragma unroll
 for (int _BFeeder_s0_iii_init = 0; _BFeeder_s0_iii_init < 0 + 4; _BFeeder_s0_iii_init++)
 {
  bool _159 = _BFeeder_s0_iii_init == 0;
  if (_159)
  {
   uint _160 = (uint)(ADD_UINT64_T_SUFFIX(3072));
   _BFeeder_cycle_temp = _160;
  } // if _159
 } // for _BFeeder_s0_iii_init
 while(1)
 {
  uint _161 = (uint)(ADD_UINT64_T_SUFFIX(3072));
  uint _162 = _BFeeder_cycle_temp;
  uint _163 = (uint)(ADD_UINT64_T_SUFFIX(4095));
  uint _164 = _162 & _163;
  bool _165 = _161 <= _164;
  if (_165)
  {
   complexd4 __166 = read_channel_intel(_BLoader_channel);
   _BFeeder_in_v_temp = __166;
  } // if _165
  #pragma unroll
  for (int _BFeeder_s0_buf = 0; _BFeeder_s0_buf < 0 + 4; _BFeeder_s0_buf++)
  {
   bool _167 = _BFeeder_s0_buf == 0;
   if (_167)
   {
    complexd4 _168 = _BFeeder_in_v_temp;
    _BFeeder_value_shreg = _168;
    (void)_168;
    uint _169 = _BFeeder_cycle_temp;
    _BFeeder_time_stamp_shreg = _169;
    (void)_169;
   } // if _167
   else
   {
    complexd4 _171 = _BFeeder_value_shreg;
    _BFeeder_value_shreg = _171;
    (void)_171;
    uint _173 = _BFeeder_time_stamp_shreg;
    _BFeeder_time_stamp_shreg = _173;
    (void)_173;
   } // if _167 else
   complexd4 _175 = _BFeeder_value_shreg;
   complexd4 _176 = __fpga_reg(__fpga_reg(_175));
   _BFeeder_value_shreg = _176;
   (void)_176;
   uint _178 = _BFeeder_time_stamp_shreg;
   uint _179 = __fpga_reg(__fpga_reg(_178));
   _BFeeder_time_stamp_shreg = _179;
   (void)_179;
   uint _180 = (uint)(ADD_UINT64_T_SUFFIX(3072));
   uint _182 = _BFeeder_time_stamp_shreg;
   uint _183 = (uint)(ADD_UINT64_T_SUFFIX(4095));
   uint _184 = _182 & _183;
   bool _185 = _180 <= _184;
   if (_185)
   {
    uint _187 = _BFeeder_time_stamp_shreg;
    uint _188 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _189 = _187 & _188;
    uint _190 = (uint)(ADD_UINT64_T_SUFFIX(3072));
    uint _191 = _189 - _190;
    uint _192 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _193 = _191 & _192;
    int _194 = (int)(_193);
    bool _195 = _BFeeder_s0_buf == _194;
    if (_195)
    {
     complexd4 _197 = _BFeeder_value_shreg;
     uint _199 = _BFeeder_time_stamp_shreg;
     uint _200 = (uint)(ADD_UINT64_T_SUFFIX(12));
     uint _201 = _199 >> _200;
     uint _202 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _203 = _201 & _202;
     bool _204 = (bool)(_203);
     uint _206 = (uint)(ADD_UINT64_T_SUFFIX(4095));
     uint _207 = _199 & _206;
     uint _208 = (uint)(ADD_UINT64_T_SUFFIX(3072));
     uint _209 = _207 - _208;
     int _210 = (int)(_209);
     int _211 = _210 >> 6;
     int _213 = _210 >> 2;
     int _214 = _213 & 15;
     _BFeeder_DB_0_ibuffer[_204][_211][_214][_BFeeder_s0_buf] = _197;
    } // if _195
   } // if _185
   uint _215 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _217 = _BFeeder_time_stamp_shreg;
   uint _218 = (uint)(ADD_UINT64_T_SUFFIX(12));
   uint _219 = _217 >> _218;
   bool _220 = _215 < _219;
   if (_220)
   {
    uint _222 = _BFeeder_time_stamp_shreg;
    uint _223 = (uint)(ADD_UINT64_T_SUFFIX(4095));
    uint _224 = _222 & _223;
    int _225 = (int)(_224);
    uint _226 = (uint)(ADD_UINT64_T_SUFFIX(12));
    uint _227 = _222 >> _226;
    uint _228 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _229 = _227 & _228;
    bool _230 = (bool)(_229);
    bool _231 = !(_230);
    int _232 = _225 >> 8;
    int _233 = _225 & 15;
    complexd4 _234 = _BFeeder_DB_0_ibuffer[_231][_232][_233][_BFeeder_s0_buf];
    _BFeeder_channel_array.s[_BFeeder_s0_buf] = _234;
    (void)_BFeeder_s0_buf;
   } // if _220
  } // for _BFeeder_s0_buf
  uint _235 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _237 = _BFeeder_time_stamp_shreg;
  uint _238 = (uint)(ADD_UINT64_T_SUFFIX(12));
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
 complexd _Z_shreg[256][4][4];
 complexd _Z_pipe_shreg[4][769];
 // produce Y
 complexd4 _Y_shreg[4];
 complexd _Z_temp[4][4];
 // produce X
 complexd4 _X_shreg[4];
 complexd _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 1024;
 _Z_pipe_base_temp = 0;
 int _244 = _A_extent_1 >> 6;
 int _246 = _B_extent_0 >> 6;
 int _243 = (2 * _246 - _244 + 1) * _244 / 2;
 int _245 = _243 + 1;
 for (int _X_s0_i_j = 0; _X_s0_i_j < 0 + _245; _X_s0_i_j++)
 {
   int _248 = _A_extent_0 >> 6;
   for (int _X_s0_k = 0; _X_s0_k < 0 + _248; _X_s0_k++)
   {
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 4096; _X_s0_kk_ii_jj++)
    {
       #pragma unroll
       for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 4; _dummy__1_s0_iii++)
       {
        #pragma unroll
        for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 4; _dummy_s0_jjj++)
        {
         complexd _250 = _Z_shreg[255][_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _250;
         #pragma unroll
         for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
         {
          int _251 = 255 - _dummy__2_s0_l1;
          int _252 = 254 - _dummy__2_s0_l1;
          complexd _254 = _Z_shreg[_252][_dummy_s0_jjj][_dummy__1_s0_iii];
          _Z_shreg[_251][_dummy_s0_jjj][_dummy__1_s0_iii] = _254;
          (void)_254;
         } // for _dummy__2_s0_l1
         complexd _255 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _255;
         (void)_255;
        } // for _dummy_s0_jjj
       } // for _dummy__1_s0_iii
       bool _257 = _X_s0_i_j < _243;
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
       for (int _X_s0_iii = 0; _X_s0_iii < 0 + 4; _X_s0_iii++)
       {
        #pragma unroll
        for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 4; _X_s0_jjj++)
        {
         complexd4 _260;
         bool _261 = _X_s0_jjj == 0;
         if (_261)
         {
          complexd4 __262 = _AFeeder_channel_array.s[_X_s0_iii];
          _260 = __262;
         } // if _261
         else
         {
          complexd4 _264 = _X_shreg[_X_s0_iii];
          _260 = _264;
         } // if _261 else
         complexd4 _265 = _260;
         _X_shreg[_X_s0_iii] = _265;
         (void)_265;
         complexd4 _267 = _X_shreg[_X_s0_iii];
         complexd4 _268 = __fpga_reg(__fpga_reg(_267));
         _X_shreg[_X_s0_iii] = _268;
         (void)_268;
         complexd4 _269;
         bool _270 = _X_s0_iii == 0;
         if (_270)
         {
          complexd4 __271 = _BFeeder_channel_array.s[_X_s0_jjj];
          _269 = __271;
         } // if _270
         else
         {
          complexd4 _273 = _Y_shreg[_X_s0_jjj];
          _269 = _273;
         } // if _270 else
         complexd4 _274 = _269;
         _Y_shreg[_X_s0_jjj] = _274;
         (void)_274;
         complexd4 _276 = _Y_shreg[_X_s0_jjj];
         complexd4 _277 = __fpga_reg(__fpga_reg(_276));
         _Y_shreg[_X_s0_jjj] = _277;
         (void)_277;
         complexd _278;
         bool _279 = _X_s0_k == 0;
         bool _280 = (_X_s0_kk_ii_jj >> 8) == 0;
         bool _281 = _279 && _280;
         if (_281)
         {
          complexd _282 = (complexd)(0.000000, 0.000000);
          _278 = _282;
         } // if _281
         else
         {
          complexd _284 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
          complexd _285 = __fpga_reg(_284);
          _278 = _285;
         } // if _281 else
         complexd _286 = _278;
         _Z_shreg_temp = _286;
         #pragma unroll
         for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 4; _X_s0_kkk++)
         {
          complexd _287 = _Z_shreg_temp;
          complexd _289 = _X_shreg[_X_s0_iii].s[_X_s0_kkk];
          complexd _291 = _Y_shreg[_X_s0_jjj].s[_X_s0_kkk];
          complexd _292 = (double2)(_289.s0 * _291.s0 - _289.s1 * _291.s1, _289.s0 * _291.s1 + _289.s1 * _291.s0);
          complexd _293 = _287 + _292;
          _Z_shreg_temp = _293;
          bool _294 = _X_s0_kkk == 3;
          if (_294)
          {
           complexd _295 = _Z_shreg_temp;
           complexd _296 = __fpga_reg(_295);
           _Z_shreg_temp = _296;
          } // if _294
         } // for _X_s0_kkk
         complexd _297 = _Z_shreg_temp;
         _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _297;
         (void)_297;
         #pragma unroll
         for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 4; _X_s0_kkk++)
         {
          bool _298 = _X_s0_kkk == 3;
          bool _299 = (_X_s0_kk_ii_jj >> 8) == 15;
          bool _300 = _298 && _299;
          int _301 = _A_extent_0 >> 6;
          int _302 = _301 + -1;
          bool _303 = _X_s0_k == _302;
          bool _304 = _300 && _303;
          if (_304)
          {
           int _305 = _X_s0_iii * 256;
           complexd _307 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
           _Z_pipe_shreg[_X_s0_jjj][_305] = _307;
           (void)_307;
          } // if _304
         } // for _X_s0_kkk
        } // for _X_s0_jjj
       } // for _X_s0_iii
       bool _308 = (_X_s0_kk_ii_jj & 0xf) == 0;
       bool _309 = ((_X_s0_kk_ii_jj >> 4) & 0xf) == 0;
       bool _310 = _308 && _309;
       int _311 = _A_extent_0 >> 6;
       int _312 = _311 + -1;
       bool _313 = _X_s0_k == _312;
       bool _314 = _310 && _313;
       bool _315 = (_X_s0_kk_ii_jj >> 8) == 15;
       bool _316 = _314 && _315;
       bool _318 = _X_s0_i_j < _243;
       bool _319 = _316 && _318;
       if (_319)
       {
        int _320 = _Z_pipe_iter_temp;
        _Z_pipe_base_temp = _320;
       } // if _319
       complexd4 _Out_channel_temp;
       #pragma unroll
       for (int _Z_pipe_b__62 = 0; _Z_pipe_b__62 < 0 + 4; _Z_pipe_b__62++)
       {
        complexd _322 = _Z_pipe_shreg[_Z_pipe_b__62][0];
        _Out_channel_temp.s[_Z_pipe_b__62] = _322;
        #pragma unroll
        for (int _Z_pipe_b__62_dummy = 0; _Z_pipe_b__62_dummy < 0 + 4; _Z_pipe_b__62_dummy++)
        {
         complexd _323 = _Out_channel_temp.s[_Z_pipe_b__62_dummy];
         complexd _324 = __fpga_reg(__fpga_reg(_323));
         _Out_channel_temp.s[_Z_pipe_b__62_dummy] = _324;
        } // for _Z_pipe_b__62_dummy
       } // for _Z_pipe_b__62
       int _325 = _Z_pipe_iter_temp;
       int _326 = _Z_pipe_base_temp;
       int _327 = _326 + 1024;
       bool _328 = _325 < _327;
       if (_328)
       {
        complexd4 _329 = _Out_channel_temp;
        write_channel_intel(_Out_channel, _329);
        (void)_329;
       } // if _328
       #pragma unroll
       for (int _Z_pipe_b__63 = 0; _Z_pipe_b__63 < 0 + 4; _Z_pipe_b__63++)
       {
        #pragma unroll
        for (int _Z_pipe_p__31 = 0; _Z_pipe_p__31 < 0 + 3; _Z_pipe_p__31++)
        {
         #pragma unroll
         for (int _Z_pipe_l__31 = 0; _Z_pipe_l__31 < 0 + 255; _Z_pipe_l__31++)
         {
          int _330 = _Z_pipe_p__31 * 256;
          int _331 = _330 + _Z_pipe_l__31;
          int _332 = _331 + 1;
          complexd _334 = _Z_pipe_shreg[_Z_pipe_b__63][_332];
          _Z_pipe_shreg[_Z_pipe_b__63][_331] = _334;
          (void)_334;
         } // for _Z_pipe_l__31
         int _335 = _Z_pipe_p__31 * 256;
         int _336 = _335 + 255;
         int _337 = _335 + 256;
         complexd _339 = _Z_pipe_shreg[_Z_pipe_b__63][_337];
         complexd _340 = __fpga_reg(__fpga_reg(_339));
         _Z_pipe_shreg[_Z_pipe_b__63][_336] = _340;
         (void)_340;
        } // for _Z_pipe_p__31
       } // for _Z_pipe_b__63
       int _341 = _Z_pipe_iter_temp;
       int _342 = _341 + 1;
       _Z_pipe_iter_temp = _342;
    } // for _X_s0_kk
   } // for _X_s0_k
 } // for _X_s0_i_j
} // kernel kernel_Out
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel complexd *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _343 = _A_extent_1 >> 6;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _343; _unloader_s0_i++)
 {
  int _344 = _B_extent_0 >> 6;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < 0 + _344; _unloader_s0_j++)
  {
   for (int _unloader_s0_iii_ii_jj = 0; _unloader_s0_iii_ii_jj < 0 + 1024; _unloader_s0_iii_ii_jj++)
   {
      complexd4 __345 = read_channel_intel(_Out_channel);
      int _346 = _addr_temp;
      int _347 = _346 * 4;
      vstore8(__345.t, 0, (__address_space__unloader_mem_channel double*)(_unloader_mem_channel + _347));
      int _348 = _addr_temp;
      int _349 = _348 + 1;
      _addr_temp = _349;
   } // for _unloader_s0_iii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

