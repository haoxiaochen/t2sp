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
typedef struct { double8 s[4]; } _AFeeder_channel_array_t;
channel _AFeeder_channel_array_t _AFeeder_channel __attribute__((depth(256))) ;
channel double8 _BLoader_channel __attribute__((depth(256))) ;
typedef struct { double8 s[4]; } _BFeeder_channel_array_t;
channel _BFeeder_channel_array_t _BFeeder_channel __attribute__((depth(256))) ;
channel double4 _Out_channel __attribute__((depth(256))) ;

channel double8 _ALoader_T_channel __attribute__((depth(256))) ;
typedef struct { double8 s[4]; } _AFeeder_T_channel_array_t;
channel _AFeeder_T_channel_array_t _AFeeder_T_channel __attribute__((depth(256))) ;
channel double8 _BLoader_T_channel __attribute__((depth(256))) ;
typedef struct { double8 s[4]; } _BFeeder_T_channel_array_t;
channel _BFeeder_T_channel_array_t _BFeeder_T_channel __attribute__((depth(256))) ;
channel double4 _Out_T_channel __attribute__((depth(256))) ;

channel double4 _E_channel __attribute__((depth(256))) ;
// Address spaces for kernel_ALoader
#define __address_space__ASerializer_mem_channel __global
__kernel void kernel_ALoader(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__ASerializer_mem_channel const double *restrict _ASerializer_mem_channel)
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
    for (int _ALoader_s0_kk = 0; _ALoader_s0_kk < 0 + 8; _ALoader_s0_kk++)
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
        double8 _18;
        int _19 = _A_extent_1 >> 6;
        bool _20 = _ALoader_s0_i < _19;
        if (_20)
        {
         int _21 = _ALoader_s0_iii * 8 + _ALoader_s0_ii * 32 + _ALoader_s0_kk * 512;
         int _22 = _21 + _ALoader_s0_k * 4096;
         int _23 = _22 + _ALoader_s0_i * 4096 * _4;
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
 double8 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _AFeeder_DB_0_ibuffer[2][8][16][4];
 #pragma unroll
 for (int _AFeeder_s0_jjj_init = 0; _AFeeder_s0_jjj_init < 0 + 4; _AFeeder_s0_jjj_init++)
 {
  bool _39 = _AFeeder_s0_jjj_init == 0;
  if (_39)
  {
   uint _40 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   _AFeeder_cycle_temp = _40;
  } // if _39
 } // for _AFeeder_s0_jjj_init
 while(1)
 {
  uint _41 = (uint)(ADD_UINT64_T_SUFFIX(1536));
  uint _42 = _AFeeder_cycle_temp;
  uint _43 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _44 = _42 & _43;
  bool _45 = _41 <= _44;
  if (_45)
  {
   double8 __46 = read_channel_intel(_ALoader_channel);
   _AFeeder_in_v_temp = __46;
  } // if _45
  #pragma unroll
  for (int _AFeeder_s0_buf = 0; _AFeeder_s0_buf < 0 + 4; _AFeeder_s0_buf++)
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
   uint _60 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   uint _62 = _AFeeder_time_stamp_shreg;
   uint _63 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _64 = _62 & _63;
   bool _65 = _60 <= _64;
   if (_65)
   {
    uint _67 = _AFeeder_time_stamp_shreg;
    uint _68 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _69 = _67 & _68;
    uint _70 = (uint)(ADD_UINT64_T_SUFFIX(1536));
    uint _71 = _69 - _70;
    uint _72 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _73 = _71 & _72;
    int _74 = (int)(_73);
    bool _75 = _AFeeder_s0_buf == _74;
    if (_75)
    {
     double8 _77 = _AFeeder_value_shreg;
     uint _79 = _AFeeder_time_stamp_shreg;
     uint _80 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _81 = _79 >> _80;
     uint _82 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _83 = _81 & _82;
     bool _84 = (bool)(_83);
     uint _86 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _87 = _79 & _86;
     uint _88 = (uint)(ADD_UINT64_T_SUFFIX(1536));
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
   uint _98 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _99 = _97 >> _98;
   bool _100 = _95 < _99;
   if (_100)
   {
    uint _102 = _AFeeder_time_stamp_shreg;
    uint _103 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _104 = _102 & _103;
    int _105 = (int)(_104);
    uint _106 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _107 = _102 >> _106;
    uint _108 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _109 = _107 & _108;
    bool _110 = (bool)(_109);
    bool _111 = !(_110);
    int _112 = _105 >> 8;
    int _113 = _105 >> 4;
    int _114 = _113 & 15;
    double8 _115 = _AFeeder_DB_0_ibuffer[_111][_112][_114][_AFeeder_s0_buf];
    _AFeeder_channel_array.s[_AFeeder_s0_buf] = _115;
    (void)_AFeeder_s0_buf;
   } // if _100
  } // for _AFeeder_s0_buf
  uint _116 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _118 = _AFeeder_time_stamp_shreg;
  uint _119 = (uint)(ADD_UINT64_T_SUFFIX(11));
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
    for (int _BLoader_s0_kk = 0; _BLoader_s0_kk < 0 + 8; _BLoader_s0_kk++)
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
        double8 _142;
        int _143 = _A_extent_1 >> 6;
        bool _144 = _BLoader_s0_i < _143;
        if (_144)
        {
         int _18 = _BLoader_s0_jjj * 8 + _BLoader_s0_jj * 32 + _BLoader_s0_kk * 512;
         int _19 = _18 + _BLoader_s0_k * 4096;
         int _20 = _19 + _BLoader_s0_j * 4096 * _129;
         double8 _153 = vload8(0, (__address_space__BSerializer_mem_channel double*)_BSerializer_mem_channel + _20);
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
 double8 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _BFeeder_DB_0_ibuffer[2][8][16][4];
 #pragma unroll
 for (int _BFeeder_s0_iii_init = 0; _BFeeder_s0_iii_init < 0 + 4; _BFeeder_s0_iii_init++)
 {
  bool _159 = _BFeeder_s0_iii_init == 0;
  if (_159)
  {
   uint _160 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   _BFeeder_cycle_temp = _160;
  } // if _159
 } // for _BFeeder_s0_iii_init
 while(1)
 {
  uint _161 = (uint)(ADD_UINT64_T_SUFFIX(1536));
  uint _162 = _BFeeder_cycle_temp;
  uint _163 = (uint)(ADD_UINT64_T_SUFFIX(2047));
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
   uint _180 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   uint _182 = _BFeeder_time_stamp_shreg;
   uint _183 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _184 = _182 & _183;
   bool _185 = _180 <= _184;
   if (_185)
   {
    uint _187 = _BFeeder_time_stamp_shreg;
    uint _188 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _189 = _187 & _188;
    uint _190 = (uint)(ADD_UINT64_T_SUFFIX(1536));
    uint _191 = _189 - _190;
    uint _192 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _193 = _191 & _192;
    int _194 = (int)(_193);
    bool _195 = _BFeeder_s0_buf == _194;
    if (_195)
    {
     double8 _197 = _BFeeder_value_shreg;
     uint _199 = _BFeeder_time_stamp_shreg;
     uint _200 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _201 = _199 >> _200;
     uint _202 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _203 = _201 & _202;
     bool _204 = (bool)(_203);
     uint _206 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _207 = _199 & _206;
     uint _208 = (uint)(ADD_UINT64_T_SUFFIX(1536));
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
   uint _218 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _219 = _217 >> _218;
   bool _220 = _215 < _219;
   if (_220)
   {
    uint _222 = _BFeeder_time_stamp_shreg;
    uint _223 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _224 = _222 & _223;
    int _225 = (int)(_224);
    uint _226 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _227 = _222 >> _226;
    uint _228 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _229 = _227 & _228;
    bool _230 = (bool)(_229);
    bool _231 = !(_230);
    int _232 = _225 >> 8;
    int _233 = _225 & 15;
    double8 _234 = _BFeeder_DB_0_ibuffer[_231][_232][_233][_BFeeder_s0_buf];
    _BFeeder_channel_array.s[_BFeeder_s0_buf] = _234;
    (void)_BFeeder_s0_buf;
   } // if _220
  } // for _BFeeder_s0_buf
  uint _235 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _237 = _BFeeder_time_stamp_shreg;
  uint _238 = (uint)(ADD_UINT64_T_SUFFIX(11));
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
 double _Z_shreg[256][4][4];
 double _Z_pipe_shreg[4][769];
 // produce Y
 double8 _Y_shreg[4];
 double _Z_temp[4][4];
 // produce X
 double8 _X_shreg[4];
 double _Z_shreg_temp;
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
    #pragma loop_coalesce 3
    for (int _X_s0_kk = 0; _X_s0_kk < 0 + 8; _X_s0_kk++)
    {
     for (int _X_s0_ii = 0; _X_s0_ii < 0 + 16; _X_s0_ii++)
     {
      for (int _X_s0_jj = 0; _X_s0_jj < 0 + 16; _X_s0_jj++)
      {
       #pragma unroll
       for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 4; _dummy__1_s0_iii++)
       {
        #pragma unroll
        for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 4; _dummy_s0_jjj++)
        {
         double _250 = _Z_shreg[255][_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _250;
         #pragma unroll
         for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
         {
          int _251 = 255 - _dummy__2_s0_l1;
          int _252 = 254 - _dummy__2_s0_l1;
          double _254 = _Z_shreg[_252][_dummy_s0_jjj][_dummy__1_s0_iii];
          _Z_shreg[_251][_dummy_s0_jjj][_dummy__1_s0_iii] = _254;
          (void)_254;
         } // for _dummy__2_s0_l1
         double _255 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
         _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _255;
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
         bool _279 = _X_s0_k == 0;
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
          bool _300 = _X_s0_kk == 7;
          bool _301 = _299 && _300;
          int _302 = _A_extent_0 >> 6;
          int _303 = _302 + -1;
          bool _304 = _X_s0_k == _303;
          bool _305 = _301 && _304;
          if (_305)
          {
           int _306 = _X_s0_iii * 256;
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
       int _312 = _A_extent_0 >> 6;
       int _313 = _312 + -1;
       bool _314 = _X_s0_k == _313;
       bool _315 = _311 && _314;
       bool _316 = _X_s0_kk == 7;
       bool _317 = _315 && _316;
       bool _319 = _X_s0_i_j < _243;
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
       int _328 = _327 + 1024;
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
        for (int _Z_pipe_p__31 = 0; _Z_pipe_p__31 < 0 + 3; _Z_pipe_p__31++)
        {
         #pragma unroll
         for (int _Z_pipe_l__31 = 0; _Z_pipe_l__31 < 0 + 255; _Z_pipe_l__31++)
         {
          int _331 = _Z_pipe_p__31 * 256;
          int _332 = _331 + _Z_pipe_l__31;
          int _333 = _332 + 1;
          double _335 = _Z_pipe_shreg[_Z_pipe_b__63][_333];
          _Z_pipe_shreg[_Z_pipe_b__63][_332] = _335;
          (void)_335;
         } // for _Z_pipe_l__31
         int _336 = _Z_pipe_p__31 * 256;
         int _337 = _336 + 255;
         int _338 = _336 + 256;
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
 } // for _X_s0_i
} // kernel kernel_Out
// Address spaces for kernel_ALoader_T
#define __address_space__ASerializer_T_mem_channel __global
__kernel void kernel_ALoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__ASerializer_T_mem_channel const double *restrict _ASerializer_T_mem_channel)
{
 int _344 = _B_extent_0 >> 6;
 int _345 = _344 + 1;
 for (int _ALoader_T_s0_j = 0; _ALoader_T_s0_j < 0 + _345; _ALoader_T_s0_j++)
 {
  int _346 = _A_extent_1 >> 6;
  int _347 = _346 - _ALoader_T_s0_j + ((_ALoader_T_s0_j < _344) ? 0 : 1);
  for (int _ALoader_T_s0_i = _ALoader_T_s0_j; _ALoader_T_s0_i < _ALoader_T_s0_j + _347; _ALoader_T_s0_i++)
  {
   int _348 = _A_extent_0 >> 6;
   for (int _ALoader_T_s0_k = 0; _ALoader_T_s0_k < 0 + _348; _ALoader_T_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _ALoader_T_s0_kk = 0; _ALoader_T_s0_kk < 0 + 8; _ALoader_T_s0_kk++)
    {
     for (int _ALoader_T_s0_ii = 0; _ALoader_T_s0_ii < 0 + 16; _ALoader_T_s0_ii++)
     {
      for (int _ALoader_T_s0_iii = 0; _ALoader_T_s0_iii < 0 + 4; _ALoader_T_s0_iii++)
      {
       bool _349 = _ALoader_T_s0_i == _ALoader_T_s0_j;
       bool _350 = _ALoader_T_s0_k == 0;
       bool _351 = _349 && _350;
       int _358 = _B_extent_0 >> 6;
       bool _359 = _ALoader_T_s0_j < _358;
       bool _360 = _351 || _359;
       if (_360)
       {
        double8 _361;
        int _362 = _B_extent_0 >> 6;
        bool _363 = _ALoader_T_s0_j < _362;
        if (_363)
        {
         int _18 = _ALoader_T_s0_iii * 8 + _ALoader_T_s0_ii * 32 + _ALoader_T_s0_kk * 512;
         int _19 = _18 + _ALoader_T_s0_k * 4096;
         int _20 = _19 + _ALoader_T_s0_i * 4096 * _347;
         double8 _372 = vload8(0, (__address_space__ASerializer_T_mem_channel double*)_ASerializer_T_mem_channel + _20);
         _361 = _372;
        } // if _363
        else
        {
         double _373 = (double) float_from_bits(0 /* 0 */);
         double8 _374 = _373;
         _361 = _374;
        } // if _363 else
        double8 _375 = _361;
        write_channel_intel(_ALoader_T_channel, _375);
       } // if _360
      } // for _ALoader_T_s0_iii
     } // for _ALoader_T_s0_ii
    } // for _ALoader_T_s0_kk
   } // for _ALoader_T_s0_k
  } // for _ALoader_T_s0_i
 } // for _ALoader_T_s0_j
} // kernel kernel_ALoader_T
#undef __address_space__ASerializer_T_mem_channel
// Address spaces for kernel_AFeeder_T
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_AFeeder_T(
)
{
 _AFeeder_T_channel_array_t _AFeeder_T_channel_array;
 double8 _AFeeder_T_value_shreg;
 uint _AFeeder_T_time_stamp_shreg;
 double8 _AFeeder_T_in_v_temp;
 uint _AFeeder_T_cycle_temp;
 double8 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _AFeeder_T_DB_0_ibuffer[2][8][16][4];
 #pragma unroll
 for (int _AFeeder_T_s0_jjj_init = 0; _AFeeder_T_s0_jjj_init < 0 + 4; _AFeeder_T_s0_jjj_init++)
 {
  bool _378 = _AFeeder_T_s0_jjj_init == 0;
  if (_378)
  {
   uint _379 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   _AFeeder_T_cycle_temp = _379;
  } // if _378
 } // for _AFeeder_T_s0_jjj_init
 while(1)
 {
  uint _380 = (uint)(ADD_UINT64_T_SUFFIX(1536));
  uint _381 = _AFeeder_T_cycle_temp;
  uint _382 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _383 = _381 & _382;
  bool _384 = _380 <= _383;
  if (_384)
  {
   double8 __385 = read_channel_intel(_ALoader_T_channel);
   _AFeeder_T_in_v_temp = __385;
  } // if _384
  #pragma unroll
  for (int _AFeeder_T_s0_buf = 0; _AFeeder_T_s0_buf < 0 + 4; _AFeeder_T_s0_buf++)
  {
   bool _386 = _AFeeder_T_s0_buf == 0;
   if (_386)
   {
    double8 _387 = _AFeeder_T_in_v_temp;
    _AFeeder_T_value_shreg = _387;
    (void)_387;
    uint _388 = _AFeeder_T_cycle_temp;
    _AFeeder_T_time_stamp_shreg = _388;
    (void)_388;
   } // if _386
   else
   {
    double8 _390 = _AFeeder_T_value_shreg;
    _AFeeder_T_value_shreg = _390;
    (void)_390;
    uint _392 = _AFeeder_T_time_stamp_shreg;
    _AFeeder_T_time_stamp_shreg = _392;
    (void)_392;
   } // if _386 else
   double8 _394 = _AFeeder_T_value_shreg;
   double8 _395 = __fpga_reg(__fpga_reg(_394));
   _AFeeder_T_value_shreg = _395;
   (void)_395;
   uint _397 = _AFeeder_T_time_stamp_shreg;
   uint _398 = __fpga_reg(__fpga_reg(_397));
   _AFeeder_T_time_stamp_shreg = _398;
   (void)_398;
   uint _399 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   uint _401 = _AFeeder_T_time_stamp_shreg;
   uint _402 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _403 = _401 & _402;
   bool _404 = _399 <= _403;
   if (_404)
   {
    uint _406 = _AFeeder_T_time_stamp_shreg;
    uint _407 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _408 = _406 & _407;
    uint _409 = (uint)(ADD_UINT64_T_SUFFIX(1536));
    uint _410 = _408 - _409;
    uint _411 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _412 = _410 & _411;
    int _413 = (int)(_412);
    bool _414 = _AFeeder_T_s0_buf == _413;
    if (_414)
    {
     double8 _416 = _AFeeder_T_value_shreg;
     uint _418 = _AFeeder_T_time_stamp_shreg;
     uint _419 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _420 = _418 >> _419;
     uint _421 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _422 = _420 & _421;
     bool _423 = (bool)(_422);
     uint _425 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _426 = _418 & _425;
     uint _427 = (uint)(ADD_UINT64_T_SUFFIX(1536));
     uint _428 = _426 - _427;
     int _429 = (int)(_428);
     int _430 = _429 >> 6;
     int _432 = _429 >> 2;
     int _433 = _432 & 15;
     _AFeeder_T_DB_0_ibuffer[_423][_430][_433][_AFeeder_T_s0_buf] = _416;
    } // if _414
   } // if _404
   uint _434 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _436 = _AFeeder_T_time_stamp_shreg;
   uint _437 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _438 = _436 >> _437;
   bool _439 = _434 < _438;
   if (_439)
   {
    uint _441 = _AFeeder_T_time_stamp_shreg;
    uint _442 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _443 = _441 & _442;
    int _444 = (int)(_443);
    uint _445 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _446 = _441 >> _445;
    uint _447 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _448 = _446 & _447;
    bool _449 = (bool)(_448);
    bool _450 = !(_449);
    int _451 = _444 >> 8;
    int _452 = _444 & 15;
    double8 _453 = _AFeeder_T_DB_0_ibuffer[_450][_451][_452][_AFeeder_T_s0_buf];
    _AFeeder_T_channel_array.s[_AFeeder_T_s0_buf] = _453;
    (void)_AFeeder_T_s0_buf;
   } // if _439
  } // for _AFeeder_T_s0_buf
  uint _454 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _456 = _AFeeder_T_time_stamp_shreg;
  uint _457 = (uint)(ADD_UINT64_T_SUFFIX(11));
  uint _458 = _456 >> _457;
  bool _459 = _454 < _458;
  if (_459)
  {
   write_channel_intel(_AFeeder_T_channel, _AFeeder_T_channel_array);
   (void)_AFeeder_T_channel_array;
  } // if _459
  uint _460 = _AFeeder_T_cycle_temp;
  uint _461 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _462 = _460 + _461;
  _AFeeder_T_cycle_temp = _462;
 } // while _AFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_AFeeder_T
// Address spaces for kernel_BLoader_T
#define __address_space__BSerializer_T_mem_channel __global
__kernel void kernel_BLoader_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__BSerializer_T_mem_channel const double *restrict _BSerializer_T_mem_channel)
{
 int _463 = _B_extent_0 >> 6;
 int _464 = _463 + 1;
 for (int _BLoader_T_s0_j = 0; _BLoader_T_s0_j < 0 + _464; _BLoader_T_s0_j++)
 {
  int _465 = _A_extent_1 >> 6;
  int _466 = _465 - _BLoader_T_s0_j + ((_BLoader_T_s0_j < _463) ? 0 : 1);
  for (int _BLoader_T_s0_i = _BLoader_T_s0_j; _BLoader_T_s0_i < _BLoader_T_s0_j + _466; _BLoader_T_s0_i++)
  {
   int _467 = _A_extent_0 >> 6;
   for (int _BLoader_T_s0_k = 0; _BLoader_T_s0_k < 0 + _467; _BLoader_T_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _BLoader_T_s0_kk = 0; _BLoader_T_s0_kk < 0 + 8; _BLoader_T_s0_kk++)
    {
     for (int _BLoader_T_s0_jj = 0; _BLoader_T_s0_jj < 0 + 16; _BLoader_T_s0_jj++)
     {
      for (int _BLoader_T_s0_jjj = 0; _BLoader_T_s0_jjj < 0 + 4; _BLoader_T_s0_jjj++)
      {
       bool _468 = _BLoader_T_s0_i == _BLoader_T_s0_j;
       bool _469 = _BLoader_T_s0_k == 0;
       bool _470 = _468 && _469;
       int _477 = _B_extent_0 >> 6;
       bool _478 = _BLoader_T_s0_j < _477;
       bool _479 = _470 || _478;
       if (_479)
       {
        double8 _481;
        int _482 = _B_extent_0 >> 6;
        bool _483 = _BLoader_T_s0_j < _482;
        if (_483)
        {
         int _18 = _BLoader_T_s0_jjj * 8 + _BLoader_T_s0_jj * 32 + _BLoader_T_s0_kk * 512;
         int _19 = _18 + _BLoader_T_s0_k * 4096;
         int _20 = _19 + _BLoader_T_s0_j * 4096 * _466;
         double8 _496 = vload8(0, (__address_space__BSerializer_T_mem_channel double*)_BSerializer_T_mem_channel + _20);
         _481 = _496;
        } // if _483
        else
        {
         double _497 = (double) float_from_bits(0 /* 0 */);
         double8 _498 = _497;
         _481 = _498;
        } // if _483 else
        double8 _499 = _481;
        write_channel_intel(_BLoader_T_channel, _499);
       } // if _479
      } // for _BLoader_T_s0_jjj
     } // for _BLoader_T_s0_jj
    } // for _BLoader_T_s0_kk
   } // for _BLoader_T_s0_k
  } // for _BLoader_T_s0_i
 } // for _BLoader_T_s0_j
} // kernel kernel_BLoader_T
#undef __address_space__BSerializer_T_mem_channel
// Address spaces for kernel_BFeeder_T
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_BFeeder_T(
)
{
 _BFeeder_T_channel_array_t _BFeeder_T_channel_array;
 double8 _BFeeder_T_value_shreg;
 uint _BFeeder_T_time_stamp_shreg;
 double8 _BFeeder_T_in_v_temp;
 uint _BFeeder_T_cycle_temp;
 double8 __attribute__((memory, numbanks(4), singlepump, numwriteports(1), numreadports(1))) _BFeeder_T_DB_0_ibuffer[2][8][16][4];
 #pragma unroll
 for (int _BFeeder_T_s0_iii_init = 0; _BFeeder_T_s0_iii_init < 0 + 4; _BFeeder_T_s0_iii_init++)
 {
  bool _502 = _BFeeder_T_s0_iii_init == 0;
  if (_502)
  {
   uint _503 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   _BFeeder_T_cycle_temp = _503;
  } // if _502
 } // for _BFeeder_T_s0_iii_init
 while(1)
 {
  uint _504 = (uint)(ADD_UINT64_T_SUFFIX(1536));
  uint _505 = _BFeeder_T_cycle_temp;
  uint _506 = (uint)(ADD_UINT64_T_SUFFIX(2047));
  uint _507 = _505 & _506;
  bool _508 = _504 <= _507;
  if (_508)
  {
   double8 __509 = read_channel_intel(_BLoader_T_channel);
   _BFeeder_T_in_v_temp = __509;
  } // if _508
  #pragma unroll
  for (int _BFeeder_T_s0_buf = 0; _BFeeder_T_s0_buf < 0 + 4; _BFeeder_T_s0_buf++)
  {
   bool _510 = _BFeeder_T_s0_buf == 0;
   if (_510)
   {
    double8 _511 = _BFeeder_T_in_v_temp;
    _BFeeder_T_value_shreg = _511;
    (void)_511;
    uint _512 = _BFeeder_T_cycle_temp;
    _BFeeder_T_time_stamp_shreg = _512;
    (void)_512;
   } // if _510
   else
   {
    double8 _514 = _BFeeder_T_value_shreg;
    _BFeeder_T_value_shreg = _514;
    (void)_514;
    uint _516 = _BFeeder_T_time_stamp_shreg;
    _BFeeder_T_time_stamp_shreg = _516;
    (void)_516;
   } // if _510 else
   double8 _518 = _BFeeder_T_value_shreg;
   double8 _519 = __fpga_reg(__fpga_reg(_518));
   _BFeeder_T_value_shreg = _519;
   (void)_519;
   uint _521 = _BFeeder_T_time_stamp_shreg;
   uint _522 = __fpga_reg(__fpga_reg(_521));
   _BFeeder_T_time_stamp_shreg = _522;
   (void)_522;
   uint _523 = (uint)(ADD_UINT64_T_SUFFIX(1536));
   uint _525 = _BFeeder_T_time_stamp_shreg;
   uint _526 = (uint)(ADD_UINT64_T_SUFFIX(2047));
   uint _527 = _525 & _526;
   bool _528 = _523 <= _527;
   if (_528)
   {
    uint _530 = _BFeeder_T_time_stamp_shreg;
    uint _531 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _532 = _530 & _531;
    uint _533 = (uint)(ADD_UINT64_T_SUFFIX(1536));
    uint _534 = _532 - _533;
    uint _535 = (uint)(ADD_UINT64_T_SUFFIX(3));
    uint _536 = _534 & _535;
    int _537 = (int)(_536);
    bool _538 = _BFeeder_T_s0_buf == _537;
    if (_538)
    {
     double8 _540 = _BFeeder_T_value_shreg;
     uint _542 = _BFeeder_T_time_stamp_shreg;
     uint _543 = (uint)(ADD_UINT64_T_SUFFIX(11));
     uint _544 = _542 >> _543;
     uint _545 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _546 = _544 & _545;
     bool _547 = (bool)(_546);
     uint _549 = (uint)(ADD_UINT64_T_SUFFIX(2047));
     uint _550 = _542 & _549;
     uint _551 = (uint)(ADD_UINT64_T_SUFFIX(1536));
     uint _552 = _550 - _551;
     int _553 = (int)(_552);
     int _554 = _553 >> 6;
     int _556 = _553 >> 2;
     int _557 = _556 & 15;
     _BFeeder_T_DB_0_ibuffer[_547][_554][_557][_BFeeder_T_s0_buf] = _540;
    } // if _538
   } // if _528
   uint _558 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _560 = _BFeeder_T_time_stamp_shreg;
   uint _561 = (uint)(ADD_UINT64_T_SUFFIX(11));
   uint _562 = _560 >> _561;
   bool _563 = _558 < _562;
   if (_563)
   {
    uint _565 = _BFeeder_T_time_stamp_shreg;
    uint _566 = (uint)(ADD_UINT64_T_SUFFIX(2047));
    uint _567 = _565 & _566;
    int _568 = (int)(_567);
    uint _569 = (uint)(ADD_UINT64_T_SUFFIX(11));
    uint _570 = _565 >> _569;
    uint _571 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _572 = _570 & _571;
    bool _573 = (bool)(_572);
    bool _574 = !(_573);
    int _575 = _568 >> 8;
    int _576 = _568 >> 4;
    int _577 = _576 & 15;
    double8 _578 = _BFeeder_T_DB_0_ibuffer[_574][_575][_577][_BFeeder_T_s0_buf];
    _BFeeder_T_channel_array.s[_BFeeder_T_s0_buf] = _578;
    (void)_BFeeder_T_s0_buf;
   } // if _563
  } // for _BFeeder_T_s0_buf
  uint _579 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _581 = _BFeeder_T_time_stamp_shreg;
  uint _582 = (uint)(ADD_UINT64_T_SUFFIX(11));
  uint _583 = _581 >> _582;
  bool _584 = _579 < _583;
  if (_584)
  {
   write_channel_intel(_BFeeder_T_channel, _BFeeder_T_channel_array);
   (void)_BFeeder_T_channel_array;
  } // if _584
  uint _585 = _BFeeder_T_cycle_temp;
  uint _586 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _587 = _585 + _586;
  _BFeeder_T_cycle_temp = _587;
 } // while _BFeeder_T_s0_outermost_loop_infinite
} // kernel kernel_BFeeder_T
// Address spaces for kernel_Out_T
__kernel void kernel_Out_T(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 _BFeeder_T_channel_array_t _BFeeder_T_channel_array;
 _AFeeder_T_channel_array_t _AFeeder_T_channel_array;
 // produce Z_T
 double _Z_T_shreg[256][4][4];
 double _Z_T_pipe_shreg[4][769];
 // produce Y_T
 double8 _Y_T_shreg[4];
 double _Z_T_temp[4][4];
 double _Z_temp[4][4];
 // produce X_T
 double8 _X_T_shreg[4];
 double _Z_T_shreg_temp;
 int _Z_T_pipe_iter_temp;
 int _Z_T_pipe_base_temp;
 _Z_T_pipe_iter_temp = 1024;
 _Z_T_pipe_base_temp = 0;
 int _588 = _B_extent_0 >> 6;
 int _590 = _A_extent_1 >> 6;
 int _586 = (2 * _588 - _590 + 1) * _590 / 2;
 int _589 = _586 + 1;
 for (int _X_T_s0_j_i = 0; _X_T_s0_j_i < 0 + _589; _X_T_s0_j_i++)
 {
   int _592 = _A_extent_0 >> 6;
   for (int _X_T_s0_k = 0; _X_T_s0_k < 0 + _592; _X_T_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _X_T_s0_kk = 0; _X_T_s0_kk < 0 + 8; _X_T_s0_kk++)
    {
     for (int _X_T_s0_jj = 0; _X_T_s0_jj < 0 + 16; _X_T_s0_jj++)
     {
      for (int _X_T_s0_ii = 0; _X_T_s0_ii < 0 + 16; _X_T_s0_ii++)
      {
       #pragma unroll
       for (int _dummy__4_s0_jjj = 0; _dummy__4_s0_jjj < 0 + 4; _dummy__4_s0_jjj++)
       {
        #pragma unroll
        for (int _dummy__3_s0_iii = 0; _dummy__3_s0_iii < 0 + 4; _dummy__3_s0_iii++)
        {
         double _594 = _Z_T_shreg[255][_dummy__3_s0_iii][_dummy__4_s0_jjj];
         _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj] = _594;
         #pragma unroll
         for (int _dummy__5_s0_l1 = 0; _dummy__5_s0_l1 < 0 + 255; _dummy__5_s0_l1++)
         {
          int _595 = 255 - _dummy__5_s0_l1;
          int _596 = 254 - _dummy__5_s0_l1;
          double _598 = _Z_T_shreg[_596][_dummy__3_s0_iii][_dummy__4_s0_jjj];
          _Z_T_shreg[_595][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _598;
          (void)_598;
         } // for _dummy__5_s0_l1
         double _599 = _Z_T_temp[_dummy__3_s0_iii][_dummy__4_s0_jjj];
         _Z_T_shreg[0][_dummy__3_s0_iii][_dummy__4_s0_jjj] = _599;
         (void)_599;
        } // for _dummy__3_s0_iii
       } // for _dummy__4_s0_jjj
       bool _601 = _X_T_s0_j_i < _586;
       if (_601)
       {
        _BFeeder_T_channel_array_t __602 = read_channel_intel(_BFeeder_T_channel);
        _BFeeder_T_channel_array = __602;
        (void)__602;
        _AFeeder_T_channel_array_t __603 = read_channel_intel(_AFeeder_T_channel);
        _AFeeder_T_channel_array = __603;
        (void)__603;
       } // if _601
       #pragma unroll
       for (int _X_T_s0_jjj = 0; _X_T_s0_jjj < 0 + 4; _X_T_s0_jjj++)
       {
        #pragma unroll
        for (int _X_T_s0_iii = 0; _X_T_s0_iii < 0 + 4; _X_T_s0_iii++)
        {
         double8 _604;
         bool _605 = _X_T_s0_jjj == 0;
         if (_605)
         {
          double8 __606 = _AFeeder_T_channel_array.s[_X_T_s0_iii];
          _604 = __606;
         } // if _605
         else
         {
          double8 _608 = _X_T_shreg[_X_T_s0_iii];
          _604 = _608;
         } // if _605 else
         double8 _609 = _604;
         _X_T_shreg[_X_T_s0_iii] = _609;
         (void)_609;
         double8 _611 = _X_T_shreg[_X_T_s0_iii];
         double8 _612 = __fpga_reg(__fpga_reg(_611));
         _X_T_shreg[_X_T_s0_iii] = _612;
         (void)_612;
         double8 _613;
         bool _614 = _X_T_s0_iii == 0;
         if (_614)
         {
          double8 __615 = _BFeeder_T_channel_array.s[_X_T_s0_jjj];
          _613 = __615;
         } // if _614
         else
         {
          double8 _617 = _Y_T_shreg[_X_T_s0_jjj];
          _613 = _617;
         } // if _614 else
         double8 _618 = _613;
         _Y_T_shreg[_X_T_s0_jjj] = _618;
         (void)_618;
         double8 _620 = _Y_T_shreg[_X_T_s0_jjj];
         double8 _621 = __fpga_reg(__fpga_reg(_620));
         _Y_T_shreg[_X_T_s0_jjj] = _621;
         (void)_621;
         double _622;
         bool _623 = _X_T_s0_k == 0;
         bool _624 = _X_T_s0_kk == 0;
         bool _625 = _623 && _624;
         if (_625)
         {
          double _626 = (double) float_from_bits(0 /* 0 */);
          _622 = _626;
         } // if _625
         else
         {
          double _628 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
          double _629 = __fpga_reg(_628);
          _622 = _629;
         } // if _625 else
         double _630 = _622;
         _Z_T_shreg_temp = _630;
         #pragma unroll
         for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
         {
          double _631 = _Z_T_shreg_temp;
          double _633 = _X_T_shreg[_X_T_s0_iii][_X_T_s0_kkk];
          double _635 = _Y_T_shreg[_X_T_s0_jjj][_X_T_s0_kkk];
          double _636 = _633 * _635;
          double _637 = _631 + _636;
          _Z_T_shreg_temp = _637;
          int _638 = _X_T_s0_kkk & 3;
          bool _639 = _638 == 3;
          if (_639)
          {
           double _640 = _Z_T_shreg_temp;
           double _641 = __fpga_reg(_640);
           _Z_T_shreg_temp = _641;
          } // if _639
         } // for _X_T_s0_kkk
         double _642 = _Z_T_shreg_temp;
         _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj] = _642;
         (void)_642;
         #pragma unroll
         for (int _X_T_s0_kkk = 0; _X_T_s0_kkk < 0 + 8; _X_T_s0_kkk++)
         {
          bool _643 = _X_T_s0_kkk == 7;
          bool _644 = _X_T_s0_kk == 7;
          bool _645 = _643 && _644;
          int _646 = _A_extent_0 >> 6;
          int _647 = _646 + -1;
          bool _648 = _X_T_s0_k == _647;
          bool _649 = _645 && _648;
          if (_649)
          {
           int _650 = _X_T_s0_iii * 256;
           double _652 = _Z_T_shreg[0][_X_T_s0_iii][_X_T_s0_jjj];
           _Z_T_pipe_shreg[_X_T_s0_jjj][_650] = _652;
           (void)_652;
          } // if _649
         } // for _X_T_s0_kkk
        } // for _X_T_s0_iii
       } // for _X_T_s0_jjj
       bool _653 = _X_T_s0_ii == 0;
       bool _654 = _X_T_s0_jj == 0;
       bool _655 = _653 && _654;
       int _656 = _A_extent_0 >> 6;
       int _657 = _656 + -1;
       bool _658 = _X_T_s0_k == _657;
       bool _659 = _655 && _658;
       bool _660 = _X_T_s0_kk == 7;
       bool _661 = _659 && _660;
       bool _663 = _X_T_s0_j_i < _586;
       bool _664 = _661 && _663;
       if (_664)
       {
        int _665 = _Z_T_pipe_iter_temp;
        _Z_T_pipe_base_temp = _665;
       } // if _664
       double4 _Out_T_channel_temp;
       #pragma unroll
       for (int _Z_T_pipe_b__62 = 0; _Z_T_pipe_b__62 < 0 + 4; _Z_T_pipe_b__62++)
       {
        double _667 = _Z_T_pipe_shreg[_Z_T_pipe_b__62][0];
        _Out_T_channel_temp[_Z_T_pipe_b__62] = _667;
        #pragma unroll
        for (int _Z_T_pipe_b__62_dummy = 0; _Z_T_pipe_b__62_dummy < 0 + 4; _Z_T_pipe_b__62_dummy++)
        {
         double _668 = _Out_T_channel_temp[_Z_T_pipe_b__62_dummy];
         double _669 = __fpga_reg(__fpga_reg(_668));
         _Out_T_channel_temp[_Z_T_pipe_b__62_dummy] = _669;
        } // for _Z_T_pipe_b__62_dummy
       } // for _Z_T_pipe_b__62
       int _670 = _Z_T_pipe_iter_temp;
       int _671 = _Z_T_pipe_base_temp;
       int _672 = _671 + 1024;
       bool _673 = _670 < _672;
       if (_673)
       {
        double4 _674 = _Out_T_channel_temp;
        write_channel_intel(_Out_T_channel, _674);
        (void)_674;
       } // if _673
       #pragma unroll
       for (int _Z_T_pipe_b__63 = 0; _Z_T_pipe_b__63 < 0 + 4; _Z_T_pipe_b__63++)
       {
        #pragma unroll
        for (int _Z_T_pipe_p__31 = 0; _Z_T_pipe_p__31 < 0 + 3; _Z_T_pipe_p__31++)
        {
         #pragma unroll
         for (int _Z_T_pipe_l__31 = 0; _Z_T_pipe_l__31 < 0 + 255; _Z_T_pipe_l__31++)
         {
          int _675 = _Z_T_pipe_p__31 * 256;
          int _676 = _675 + _Z_T_pipe_l__31;
          int _677 = _676 + 1;
          double _679 = _Z_T_pipe_shreg[_Z_T_pipe_b__63][_677];
          _Z_T_pipe_shreg[_Z_T_pipe_b__63][_676] = _679;
          (void)_679;
         } // for _Z_T_pipe_l__31
         int _680 = _Z_T_pipe_p__31 * 256;
         int _681 = _680 + 255;
         int _682 = _680 + 256;
         double _684 = _Z_T_pipe_shreg[_Z_T_pipe_b__63][_682];
         double _685 = __fpga_reg(__fpga_reg(_684));
         _Z_T_pipe_shreg[_Z_T_pipe_b__63][_681] = _685;
         (void)_685;
        } // for _Z_T_pipe_p__31
       } // for _Z_T_pipe_b__63
       int _686 = _Z_T_pipe_iter_temp;
       int _687 = _686 + 1;
       _Z_T_pipe_iter_temp = _687;
      } // for _X_T_s0_ii
     } // for _X_T_s0_jj
    } // for _X_T_s0_kk
   } // for _X_T_s0_k
 } // for _X_T_s0_j
} // kernel kernel_Out_T
// Address spaces for kernel_E
__kernel void kernel_E(
 const int _A_extent_1,
 const int _B_extent_0)
{
 int _688 = _A_extent_1 >> 6;
 for (int _E_s0_i = 0; _E_s0_i < 0 + _688; _E_s0_i++)
 {
  int _689 = _B_extent_0 >> 6;
  int _690 = _689 - _E_s0_i;
  for (int _E_s0_j = _E_s0_i; _E_s0_j < _E_s0_i + _690; _E_s0_j++)
  {
   #pragma loop_coalesce 3
   for (int _E_s0_iii = 0; _E_s0_iii < 0 + 4; _E_s0_iii++)
   {
    for (int _E_s0_ii = 0; _E_s0_ii < 0 + 16; _E_s0_ii++)
    {
     for (int _E_s0_jj = 0; _E_s0_jj < 0 + 16; _E_s0_jj++)
     {
      double4 __691 = read_channel_intel(_Out_channel);
      double4 __692 = read_channel_intel(_Out_T_channel);
      double4 _693 = __691 + __692;
      write_channel_intel(_E_channel, _693);
      (void)_693;
     } // for _E_s0_iii
    } // for _E_s0_jj
   } // for _E_s0_ii
  } // for _E_s0_j
 } // for _E_s0_i
} // kernel kernel_E
// Address spaces for kernel_unloader
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel double *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _694 = _A_extent_1 >> 6;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _694; _unloader_s0_i++)
 {
  int _695 = _B_extent_0 >> 6;
  int _696 = _695 - _unloader_s0_i;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < _unloader_s0_i + _696; _unloader_s0_j++)
  {
   #pragma loop_coalesce 3
   for (int _unloader_s0_iii = 0; _unloader_s0_iii < 0 + 4; _unloader_s0_iii++)
   {
    for (int _unloader_s0_ii = 0; _unloader_s0_ii < 0 + 16; _unloader_s0_ii++)
    {
     for (int _unloader_s0_jj = 0; _unloader_s0_jj < 0 + 16; _unloader_s0_jj++)
     {
      double4 __697 = read_channel_intel(_E_channel);
      int _698 = _addr_temp;
      int _699 = _698 * 4;
      vstore4(__697, 0, (__address_space__unloader_mem_channel double*)_unloader_mem_channel + _699);
      int _700 = _addr_temp;
      int _701 = _700 + 1;
      _addr_temp = _701;
     } // for _unloader_s0_iii
    } // for _unloader_s0_jj
   } // for _unloader_s0_ii
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader
#undef __address_space__unloader_mem_channel

