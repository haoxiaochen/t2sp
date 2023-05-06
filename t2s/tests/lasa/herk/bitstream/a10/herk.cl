/*OpenCL C x86-64-linux-avx-avx2-avx512-avx512_skylake-enable_synthesis-f16c-fma-intel_fpga-opencl-sse41*/
#pragma OPENCL FP_CONTRACT ON
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
inline float2 conjugate(float2 x) {return (float2)(x.s0, -x.s1); }
inline float2 sqrt_c32(float2 x) {return (float2)(sqrt_f32(x.s0), 0.0f); }
inline float2 fast_inverse_c32(float2 x) {return (float2)(fast_inverse_f32(x.s0), 0.0f); }
inline float2 fast_inverse_sqrt_c32(float2 x) {return (float2)(fast_inverse_sqrt_f32(x.s0), 0.0f); }
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
channel complex4 _ALoader_channel __attribute__((depth(128))) ;
typedef struct { complex4 s[8]; } _AFeeder_channel_array_t;
channel _AFeeder_channel_array_t _AFeeder_channel __attribute__((depth(128))) ;
channel complex4 _BLoader_channel __attribute__((depth(128))) ;
typedef struct { complex4 s[8]; } _BFeeder_channel_array_t;
channel _BFeeder_channel_array_t _BFeeder_channel __attribute__((depth(128))) ;
channel complex8 _Out_channel __attribute__((depth(128))) ;
// Address spaces for kernel_ALoader_1
#define __address_space__ASerializer_mem_channel __global
__kernel void kernel_ALoader_1(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__ASerializer_mem_channel const complex *restrict _ASerializer_mem_channel)
{
 int _372 = _A_extent_1 >> 7;
 int _373 = _372 + 1;
 for (int _ALoader_s0_i = 0; _ALoader_s0_i < 0 + _373; _ALoader_s0_i++)
 {
  int _374 = _B_extent_0 >> 7;
  int _375 = _374 - _ALoader_s0_i + ((_ALoader_s0_i < _372) ? 0 : 1);
  for (int _ALoader_s0_j = _ALoader_s0_i; _ALoader_s0_j < _ALoader_s0_i + _375; _ALoader_s0_j++)
  {
   int _376 = _A_extent_0 >> 7;
   for (int _ALoader_s0_k = 0; _ALoader_s0_k < 0 + _376; _ALoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _ALoader_s0_kk = 0; _ALoader_s0_kk < 0 + 32; _ALoader_s0_kk++)
    {
     for (int _ALoader_s0_ii = 0; _ALoader_s0_ii < 0 + 16; _ALoader_s0_ii++)
     {
      for (int _ALoader_s0_iii = 0; _ALoader_s0_iii < 0 + 8; _ALoader_s0_iii++)
      {
        bool _377 = _ALoader_s0_j == _ALoader_s0_i;
        bool _378 = _ALoader_s0_k == 0;
        bool _379 = _377 && _378;
        int _390 = _A_extent_1 >> 7;
        bool _391 = _ALoader_s0_i < _390;
        bool _392 = _379 || _391;
        if (_392)
        {
         complex4 _393;
         int _394 = _A_extent_1 >> 7;
         bool _395 = _ALoader_s0_i < _394;
         if (_395)
         {
          int _18 = _ALoader_s0_iii*4 + _ALoader_s0_ii*32 + _ALoader_s0_kk*512;
          int _19 = _18 + _ALoader_s0_k*16384;
          int _20 = _19 + _ALoader_s0_i*16384*_376;
          complex4 _409 = {vload8(0, (__address_space__ASerializer_mem_channel float*)(_ASerializer_mem_channel + _20))};
          _393 = _409;
         } // if _395
         else
         {
          float _28 = float_from_bits(0 /* 0 */);
          _393.t = _28;
         } // if _395 else
         complex4 _412 = _393;
         write_channel_intel(_ALoader_channel, _412);
         (void)_412;
        } // if _392
      } // for _ALoader_s0_iii
     } // for _ALoader_s0_ii
    } // for _ALoader_s0_kk
   } // for _ALoader_s0_k
  } // for _ALoader_s0_j
 } // for _ALoader_s0_i
} // kernel kernel_ALoader_1
#undef __address_space__ASerializer_mem_channel
// Address spaces for kernel_AFeeder_1
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_AFeeder_1(
)
{
 _AFeeder_channel_array_t _AFeeder_channel_array;
 complex4 _AFeeder_value_shreg;
 uint _AFeeder_time_stamp_shreg;
 complex4 _AFeeder_in_v_temp;
 uint _AFeeder_cycle_temp;
 complex4 __attribute__((memory, numbanks(8), singlepump, numwriteports(1), numreadports(1))) _AFeeder_DB_0_ibuffer[2][32][16][8];
 #pragma unroll
 for (int _AFeeder_s0_jjj_init = 0; _AFeeder_s0_jjj_init < 0 + 8; _AFeeder_s0_jjj_init++)
 {
  bool _415 = _AFeeder_s0_jjj_init == 0;
  if (_415)
  {
   uint _416 = (uint)(ADD_UINT64_T_SUFFIX(4096));
   _AFeeder_cycle_temp = _416;
  } // if _415
 } // for _AFeeder_s0_jjj_init
 while(1)
 {
  uint _417 = (uint)(ADD_UINT64_T_SUFFIX(4096));
  uint _418 = _AFeeder_cycle_temp;
  uint _419 = (uint)(ADD_UINT64_T_SUFFIX(8191));
  uint _420 = _418 & _419;
  bool _421 = _417 <= _420;
  if (_421)
  {
   complex4 __422 = read_channel_intel(_ALoader_channel);
   _AFeeder_in_v_temp = __422;
  } // if _421
  #pragma unroll
  for (int _AFeeder_s0_buf = 0; _AFeeder_s0_buf < 0 + 8; _AFeeder_s0_buf++)
  {
   bool _423 = _AFeeder_s0_buf == 0;
   if (_423)
   {
    complex4 _424 = _AFeeder_in_v_temp;
    _AFeeder_value_shreg = _424;
    (void)_424;
    uint _425 = _AFeeder_cycle_temp;
    _AFeeder_time_stamp_shreg = _425;
    (void)_425;
   } // if _423
   else
   {
    complex4 _427 = _AFeeder_value_shreg;
    _AFeeder_value_shreg = _427;
    (void)_427;
    uint _429 = _AFeeder_time_stamp_shreg;
    _AFeeder_time_stamp_shreg = _429;
    (void)_429;
   } // if _423 else
   complex4 _431 = _AFeeder_value_shreg;
   complex4 _432 = __fpga_reg(__fpga_reg(_431));
   _AFeeder_value_shreg = _432;
   (void)_432;
   uint _434 = _AFeeder_time_stamp_shreg;
   uint _435 = __fpga_reg(__fpga_reg(_434));
   _AFeeder_time_stamp_shreg = _435;
   (void)_435;
   uint _436 = (uint)(ADD_UINT64_T_SUFFIX(4096));
   uint _438 = _AFeeder_time_stamp_shreg;
   uint _439 = (uint)(ADD_UINT64_T_SUFFIX(8191));
   uint _440 = _438 & _439;
   bool _441 = _436 <= _440;
   if (_441)
   {
    uint _443 = _AFeeder_time_stamp_shreg;
    uint _444 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _445 = _443 & _444;
    uint _446 = (uint)(ADD_UINT64_T_SUFFIX(4096));
    uint _447 = _445 - _446;
    uint _448 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _449 = _447 & _448;
    int _450 = (int)(_449);
    bool _451 = _AFeeder_s0_buf == _450;
    if (_451)
    {
     complex4 _453 = _AFeeder_value_shreg;
     uint _455 = _AFeeder_time_stamp_shreg;
     uint _456 = (uint)(ADD_UINT64_T_SUFFIX(13));
     uint _457 = _455 >> _456;
     uint _458 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _459 = _457 & _458;
     bool _460 = (bool)(_459);
     uint _462 = (uint)(ADD_UINT64_T_SUFFIX(8191));
     uint _463 = _455 & _462;
     uint _464 = (uint)(ADD_UINT64_T_SUFFIX(4096));
     uint _465 = _463 - _464;
     int _466 = (int)(_465);
     int _467 = _466 >> 7;
     int _469 = _466 >> 3;
     int _470 = _469 & 15;
     _AFeeder_DB_0_ibuffer[_460][_467][_470][_AFeeder_s0_buf] = _453;
    } // if _451
   } // if _441
   uint _471 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _473 = _AFeeder_time_stamp_shreg;
   uint _474 = (uint)(ADD_UINT64_T_SUFFIX(13));
   uint _475 = _473 >> _474;
   bool _476 = _471 < _475;
   if (_476)
   {
    uint _478 = _AFeeder_time_stamp_shreg;
    uint _479 = (uint)(ADD_UINT64_T_SUFFIX(13));
    uint _480 = _478 >> _479;
    uint _481 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _482 = _480 & _481;
    bool _483 = (bool)(_482);
    bool _484 = !(_483);
    uint _486 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _487 = _478 & _486;
    int _488 = (int)(_487);
    int _489 = _488 >> 8;
    int _491 = _488 >> 4;
    int _492 = _491 & 15;
    complex4 _493 = _AFeeder_DB_0_ibuffer[_484][_489][_492][_AFeeder_s0_buf];
    _AFeeder_channel_array.s[_AFeeder_s0_buf] = _493;
    (void)_AFeeder_s0_buf;
   } // if _476
  } // for _AFeeder_s0_buf
  uint _494 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _496 = _AFeeder_time_stamp_shreg;
  uint _497 = (uint)(ADD_UINT64_T_SUFFIX(13));
  uint _498 = _496 >> _497;
  bool _499 = _494 < _498;
  if (_499)
  {
   write_channel_intel(_AFeeder_channel, _AFeeder_channel_array);
   (void)_AFeeder_channel_array;
  } // if _499
  uint _500 = _AFeeder_cycle_temp;
  uint _501 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _502 = _500 + _501;
  _AFeeder_cycle_temp = _502;
 } // while _AFeeder_s0_outermost_loop_infinite
} // kernel kernel_AFeeder_1
// Address spaces for kernel_BLoader_1
#define __address_space__BSerializer_mem_channel __global
__kernel void kernel_BLoader_1(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__BSerializer_mem_channel const complex *restrict _BSerializer_mem_channel)
{
 int _504 = _A_extent_1 >> 7;
 int _505 = _504 + 1;
 for (int _BLoader_s0_i = 0; _BLoader_s0_i < 0 + _505; _BLoader_s0_i++)
 {
  int _506 = _B_extent_0 >> 7;
  int _507 = _506 - _BLoader_s0_i + ((_BLoader_s0_i < _504) ? 0 : 1);
  for (int _BLoader_s0_j = _BLoader_s0_i; _BLoader_s0_j < _BLoader_s0_i + _507; _BLoader_s0_j++)
  {
   int _508 = _A_extent_0 >> 7;
   for (int _BLoader_s0_k = 0; _BLoader_s0_k < 0 + _508; _BLoader_s0_k++)
   {
    #pragma loop_coalesce 3
    for (int _BLoader_s0_kk = 0; _BLoader_s0_kk < 0 + 32; _BLoader_s0_kk++)
    {
     for (int _BLoader_s0_jj = 0; _BLoader_s0_jj < 0 + 16; _BLoader_s0_jj++)
     {
      for (int _BLoader_s0_jjj = 0; _BLoader_s0_jjj < 0 + 8; _BLoader_s0_jjj++)
      {
        bool _509 = _BLoader_s0_j == _BLoader_s0_i;
        bool _510 = _BLoader_s0_k == 0;
        bool _511 = _509 && _510;
        int _522 = _A_extent_1 >> 7;
        bool _523 = _BLoader_s0_i < _522;
        bool _524 = _511 || _523;
        if (_524)
        {
         complex4 _525;
         int _526 = _A_extent_1 >> 7;
         bool _527 = _BLoader_s0_i < _526;
         if (_527)
         {
          int _18 = _BLoader_s0_jjj*4 + _BLoader_s0_jj*32 + _BLoader_s0_kk*512;
          int _19 = _18 + _BLoader_s0_k*16384;
          int _20 = _19 + _BLoader_s0_j*16384*_508;
          complex4 _536 = {vload8(0, (__address_space__BSerializer_mem_channel float*)(_BSerializer_mem_channel + _20))};
         _525 = _536;
         } // if _527
         else
         {
          float _142 = float_from_bits(0 /* 0 */);
          _525.t = _142;
         } // if _527 else
         complex4 _539 = _525;
         write_channel_intel(_BLoader_channel, _539);
         (void)_539;
        } // if _524
      } // for _BLoader_s0_jjj
     } // for _BLoader_s0_jj
    } // for _BLoader_s0_kk
   } // for _BLoader_s0_k
  } // for _BLoader_s0_j
 } // for _BLoader_s0_i
} // kernel kernel_BLoader_1
#undef __address_space__BSerializer_mem_channel
// Address spaces for kernel_BFeeder_1
__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_BFeeder_1(
)
{
 _BFeeder_channel_array_t _BFeeder_channel_array;
 complex4 _BFeeder_value_shreg;
 uint _BFeeder_time_stamp_shreg;
 complex4 _BFeeder_in_v_temp;
 uint _BFeeder_cycle_temp;
 complex4 __attribute__((memory, numbanks(8), singlepump, numwriteports(1), numreadports(1))) _BFeeder_DB_0_ibuffer[2][32][16][8];
 #pragma unroll
 for (int _BFeeder_s0_iii_init = 0; _BFeeder_s0_iii_init < 0 + 8; _BFeeder_s0_iii_init++)
 {
  bool _542 = _BFeeder_s0_iii_init == 0;
  if (_542)
  {
   uint _543 = (uint)(ADD_UINT64_T_SUFFIX(4096));
   _BFeeder_cycle_temp = _543;
  } // if _542
 } // for _BFeeder_s0_iii_init
 while(1)
 {
  uint _544 = (uint)(ADD_UINT64_T_SUFFIX(4096));
  uint _545 = _BFeeder_cycle_temp;
  uint _546 = (uint)(ADD_UINT64_T_SUFFIX(8191));
  uint _547 = _545 & _546;
  bool _548 = _544 <= _547;
  if (_548)
  {
   complex4 __549 = read_channel_intel(_BLoader_channel);
   _BFeeder_in_v_temp = __549;
  } // if _548
  #pragma unroll
  for (int _BFeeder_s0_buf = 0; _BFeeder_s0_buf < 0 + 8; _BFeeder_s0_buf++)
  {
   bool _550 = _BFeeder_s0_buf == 0;
   if (_550)
   {
    complex4 _551 = _BFeeder_in_v_temp;
    _BFeeder_value_shreg = _551;
    (void)_551;
    uint _552 = _BFeeder_cycle_temp;
    _BFeeder_time_stamp_shreg = _552;
    (void)_552;
   } // if _550
   else
   {
    complex4 _554 = _BFeeder_value_shreg;
    _BFeeder_value_shreg = _554;
    (void)_554;
    uint _556 = _BFeeder_time_stamp_shreg;
    _BFeeder_time_stamp_shreg = _556;
    (void)_556;
   } // if _550 else
   complex4 _558 = _BFeeder_value_shreg;
   complex4 _559 = __fpga_reg(__fpga_reg(_558));
   _BFeeder_value_shreg = _559;
   (void)_559;
   uint _561 = _BFeeder_time_stamp_shreg;
   uint _562 = __fpga_reg(__fpga_reg(_561));
   _BFeeder_time_stamp_shreg = _562;
   (void)_562;
   uint _563 = (uint)(ADD_UINT64_T_SUFFIX(4096));
   uint _565 = _BFeeder_time_stamp_shreg;
   uint _566 = (uint)(ADD_UINT64_T_SUFFIX(8191));
   uint _567 = _565 & _566;
   bool _568 = _563 <= _567;
   if (_568)
   {
    uint _570 = _BFeeder_time_stamp_shreg;
    uint _571 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _572 = _570 & _571;
    uint _573 = (uint)(ADD_UINT64_T_SUFFIX(4096));
    uint _574 = _572 - _573;
    uint _575 = (uint)(ADD_UINT64_T_SUFFIX(7));
    uint _576 = _574 & _575;
    int _577 = (int)(_576);
    bool _578 = _BFeeder_s0_buf == _577;
    if (_578)
    {
     complex4 _580 = _BFeeder_value_shreg;
     uint _582 = _BFeeder_time_stamp_shreg;
     uint _583 = (uint)(ADD_UINT64_T_SUFFIX(13));
     uint _584 = _582 >> _583;
     uint _585 = (uint)(ADD_UINT64_T_SUFFIX(1));
     uint _586 = _584 & _585;
     bool _587 = (bool)(_586);
     uint _589 = (uint)(ADD_UINT64_T_SUFFIX(8191));
     uint _590 = _582 & _589;
     uint _591 = (uint)(ADD_UINT64_T_SUFFIX(4096));
     uint _592 = _590 - _591;
     int _593 = (int)(_592);
     int _594 = _593 >> 7;
     int _596 = _593 >> 3;
     int _597 = _596 & 15;
     _BFeeder_DB_0_ibuffer[_587][_594][_597][_BFeeder_s0_buf] = _580;
    } // if _578
   } // if _568
   uint _598 = (uint)(ADD_UINT64_T_SUFFIX(0));
   uint _600 = _BFeeder_time_stamp_shreg;
   uint _601 = (uint)(ADD_UINT64_T_SUFFIX(13));
   uint _602 = _600 >> _601;
   bool _603 = _598 < _602;
   if (_603)
   {
    uint _605 = _BFeeder_time_stamp_shreg;
    uint _606 = (uint)(ADD_UINT64_T_SUFFIX(13));
    uint _607 = _605 >> _606;
    uint _608 = (uint)(ADD_UINT64_T_SUFFIX(1));
    uint _609 = _607 & _608;
    bool _610 = (bool)(_609);
    bool _611 = !(_610);
    uint _613 = (uint)(ADD_UINT64_T_SUFFIX(8191));
    uint _614 = _605 & _613;
    int _615 = (int)(_614);
    int _616 = _615 >> 8;
    int _618 = _615 & 15;
    complex4 _619 = _BFeeder_DB_0_ibuffer[_611][_616][_618][_BFeeder_s0_buf];
    _BFeeder_channel_array.s[_BFeeder_s0_buf] = _619;
    (void)_BFeeder_s0_buf;
   } // if _603
  } // for _BFeeder_s0_buf
  uint _620 = (uint)(ADD_UINT64_T_SUFFIX(0));
  uint _622 = _BFeeder_time_stamp_shreg;
  uint _623 = (uint)(ADD_UINT64_T_SUFFIX(13));
  uint _624 = _622 >> _623;
  bool _625 = _620 < _624;
  if (_625)
  {
   write_channel_intel(_BFeeder_channel, _BFeeder_channel_array);
   (void)_BFeeder_channel_array;
  } // if _625
  uint _626 = _BFeeder_cycle_temp;
  uint _627 = (uint)(ADD_UINT64_T_SUFFIX(1));
  uint _628 = _626 + _627;
  _BFeeder_cycle_temp = _628;
 } // while _BFeeder_s0_outermost_loop_infinite
} // kernel kernel_BFeeder_1
// Address spaces for kernel_Out_1
__kernel void kernel_Out_1(
 const int _A_extent_0,
 const int _A_extent_1,
 const int _B_extent_0)
{
 _BFeeder_channel_array_t _BFeeder_channel_array;
 _AFeeder_channel_array_t _AFeeder_channel_array;
 // produce Z
 complex _Z_shreg[256][8][8];
 complex _Z_pipe_shreg[8][1793];
 // produce Y
 complex4 _Y_shreg[8];
 complex _Z_temp[8][8];
 // produce X
 complex4 _X_shreg[8];
 complex _Z_shreg_temp;
 int _Z_pipe_iter_temp;
 int _Z_pipe_base_temp;
 _Z_pipe_iter_temp = 2048;
 _Z_pipe_base_temp = 0;
 int _629 = _A_extent_1 >> 7;
 int _630 = _B_extent_0 >> 7;
 int _628 = (2 * _630 - _629 + 1) * _629 / 2;
 int _631 = _628 + 1;
 for (int _X_s0_i_j = 0; _X_s0_i_j < 0 + _631; _X_s0_i_j++)
 {
   int _634 = _A_extent_0 >> 7;
   for (int _X_s0_k = 0; _X_s0_k < 0 + _634; _X_s0_k++)
   {
    for (int _X_s0_kk_ii_jj = 0; _X_s0_kk_ii_jj < 0 + 8192; _X_s0_kk_ii_jj++)
    {
     #pragma unroll
     for (int _dummy__1_s0_iii = 0; _dummy__1_s0_iii < 0 + 8; _dummy__1_s0_iii++)
     {
      #pragma unroll
      for (int _dummy_s0_jjj = 0; _dummy_s0_jjj < 0 + 8; _dummy_s0_jjj++)
      {
       complex _636 = _Z_shreg[255][_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii] = _636;
       #pragma unroll
       for (int _dummy__2_s0_l1 = 0; _dummy__2_s0_l1 < 0 + 255; _dummy__2_s0_l1++)
       {
        int _637 = 255 - _dummy__2_s0_l1;
        int _638 = 254 - _dummy__2_s0_l1;
        complex _640 = _Z_shreg[_638][_dummy_s0_jjj][_dummy__1_s0_iii];
        _Z_shreg[_637][_dummy_s0_jjj][_dummy__1_s0_iii] = _640;
        (void)_640;
       } // for _dummy__2_s0_l1
       complex _641 = _Z_temp[_dummy_s0_jjj][_dummy__1_s0_iii];
       _Z_shreg[0][_dummy_s0_jjj][_dummy__1_s0_iii] = _641;
       (void)_641;
      } // for _dummy_s0_jjj
     } // for _dummy__1_s0_iii
     bool _643 = _X_s0_i_j < _628;
     if (_643)
     {
      _BFeeder_channel_array_t __644 = read_channel_intel(_BFeeder_channel);
      _BFeeder_channel_array = __644;
      (void)__644;
      _AFeeder_channel_array_t __645 = read_channel_intel(_AFeeder_channel);
      _AFeeder_channel_array = __645;
      (void)__645;
     } // if _643
     #pragma unroll
     for (int _X_s0_iii = 0; _X_s0_iii < 0 + 8; _X_s0_iii++)
     {
      #pragma unroll
      for (int _X_s0_jjj = 0; _X_s0_jjj < 0 + 8; _X_s0_jjj++)
      {
       complex4 _646;
       bool _647 = _X_s0_jjj == 0;
       if (_647)
       {
        complex4 __648 = _AFeeder_channel_array.s[_X_s0_iii];
        _646 = __648;
       } // if _647
       else
       {
        complex4 _650 = _X_shreg[_X_s0_iii];
        _646 = _650;
       } // if _647 else
       complex4 _651 = _646;
       _X_shreg[_X_s0_iii] = _651;
       (void)_651;
       complex4 _653 = _X_shreg[_X_s0_iii];
       complex4 _654 = __fpga_reg(__fpga_reg(_653));
       _X_shreg[_X_s0_iii] = _654;
       (void)_654;
       complex4 _655;
       bool _656 = _X_s0_iii == 0;
       if (_656)
       {
        complex4 __657 = _BFeeder_channel_array.s[_X_s0_jjj];
        _655 = __657;
       } // if _656
       else
       {
        complex4 _659 = _Y_shreg[_X_s0_jjj];
        _655 = _659;
       } // if _656 else
       complex4 _660 = _655;
       _Y_shreg[_X_s0_jjj] = _660;
       (void)_660;
       complex4 _662 = _Y_shreg[_X_s0_jjj];
       complex4 _663 = __fpga_reg(__fpga_reg(_662));
       _Y_shreg[_X_s0_jjj] = _663;
       (void)_663;
       complex _664;
       bool _665 = _X_s0_k == 0;
       int _666 = _X_s0_kk_ii_jj >> 8;
       bool _667 = _666 == 0;
       bool _668 = _665 && _667;
       if (_668)
       {
        complex _669 = (complex)(0.000000f, 0.000000f);
        _664 = _669;
       } // if _668
       else
       {
        complex _671 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
        complex _672 = __fpga_reg(_671);
        _664 = _672;
       } // if _668 else
       complex _673 = _664;
       _Z_shreg_temp = _673;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 4; _X_s0_kkk++)
       {
        complex _674 = _Z_shreg_temp;
        complex _676 = _X_shreg[_X_s0_iii].s[_X_s0_kkk];
        complex _678 = _Y_shreg[_X_s0_jjj].s[_X_s0_kkk];
        complex _679 = (float2)(_676.s0 * _678.s0 - _676.s1 * _678.s1, _676.s0 * _678.s1 + _676.s1 * _678.s0);
        complex _680 = _674 + _679;
        _Z_shreg_temp = _680;
        bool _681 = _X_s0_kkk == 3;
        if (_681)
        {
         complex _682 = _Z_shreg_temp;
         complex _683 = __fpga_reg(_682);
         _Z_shreg_temp = _683;
        } // if _681
       } // for _X_s0_kkk
       complex _684 = _Z_shreg_temp;
       _Z_shreg[0][_X_s0_jjj][_X_s0_iii] = _684;
       (void)_684;
       #pragma unroll
       for (int _X_s0_kkk = 0; _X_s0_kkk < 0 + 4; _X_s0_kkk++)
       {
        bool _685 = _X_s0_kkk == 3;
        int _686 = _X_s0_kk_ii_jj >> 8;
        bool _687 = _686 == 31;
        bool _688 = _685 && _687;
        int _689 = _A_extent_0 >> 7;
        int _690 = _689 + -1;
        bool _691 = _X_s0_k == _690;
        bool _692 = _688 && _691;
        if (_692)
        {
         int _693 = _X_s0_iii * 256;
         complex _695 = _Z_shreg[0][_X_s0_jjj][_X_s0_iii];
         _Z_pipe_shreg[_X_s0_jjj][_693] = _695;
         (void)_695;
        } // if _692
       } // for _X_s0_kkk
      } // for _X_s0_jjj
     } // for _X_s0_iii
     int _696 = _X_s0_kk_ii_jj & 15;
     bool _697 = _696 == 0;
     int _698 = _X_s0_kk_ii_jj & 255;
     int _699 = _698 >> 4;
     bool _700 = _699 == 0;
     bool _701 = _697 && _700;
     int _702 = _A_extent_0 >> 7;
     int _703 = _702 + -1;
     bool _704 = _X_s0_k == _703;
     bool _705 = _701 && _704;
     int _706 = _X_s0_kk_ii_jj >> 8;
     bool _707 = _706 == 31;
     bool _708 = _705 && _707;
     bool _710 = _X_s0_i_j < _628;
     bool _711 = _708 && _710;
     if (_711)
     {
      int _712 = _Z_pipe_iter_temp;
      _Z_pipe_base_temp = _712;
     } // if _711
     complex8 _Out_channel_temp;
     #pragma unroll
     for (int _Z_pipe_b__62 = 0; _Z_pipe_b__62 < 0 + 8; _Z_pipe_b__62++)
     {
      complex _714 = _Z_pipe_shreg[_Z_pipe_b__62][0];
      _Out_channel_temp.s[_Z_pipe_b__62] = _714;
      #pragma unroll
      for (int _Z_pipe_b__62_dummy = 0; _Z_pipe_b__62_dummy < 0 + 8; _Z_pipe_b__62_dummy++)
      {
       complex _715 = _Out_channel_temp.s[_Z_pipe_b__62_dummy];
       complex _716 = __fpga_reg(__fpga_reg(_715));
       _Out_channel_temp.s[_Z_pipe_b__62_dummy] = _716;
      } // for _Z_pipe_b__62_dummy
     } // for _Z_pipe_b__62
     int _717 = _Z_pipe_iter_temp;
     int _718 = _Z_pipe_base_temp;
     int _719 = _718 + 2048;
     bool _720 = _717 < _719;
     if (_720)
     {
      complex8 _721 = _Out_channel_temp;
      write_channel_intel(_Out_channel, _721);
      (void)_721;
     } // if _720
     #pragma unroll
     for (int _Z_pipe_b__63 = 0; _Z_pipe_b__63 < 0 + 8; _Z_pipe_b__63++)
     {
      #pragma unroll
      for (int _Z_pipe_p__31 = 0; _Z_pipe_p__31 < 0 + 7; _Z_pipe_p__31++)
      {
       #pragma unroll
       for (int _Z_pipe_l__31 = 0; _Z_pipe_l__31 < 0 + 255; _Z_pipe_l__31++)
       {
        int _722 = _Z_pipe_p__31 * 256;
        int _723 = _722 + _Z_pipe_l__31;
        int _724 = _723 + 1;
        complex _726 = _Z_pipe_shreg[_Z_pipe_b__63][_724];
        _Z_pipe_shreg[_Z_pipe_b__63][_723] = _726;
        (void)_726;
       } // for _Z_pipe_l__31
       int _727 = _Z_pipe_p__31 * 256;
       int _728 = _727 + 255;
       int _729 = _727 + 256;
       complex _731 = _Z_pipe_shreg[_Z_pipe_b__63][_729];
       complex _732 = __fpga_reg(__fpga_reg(_731));
       _Z_pipe_shreg[_Z_pipe_b__63][_728] = _732;
       (void)_732;
      } // for _Z_pipe_p__31
     } // for _Z_pipe_b__63
     int _733 = _Z_pipe_iter_temp;
     int _734 = _733 + 1;
     _Z_pipe_iter_temp = _734;
    } // for _X_s0_kk_ii_jj
   } // for _X_s0_k
 } // for _X_s0_i_j
} // kernel kernel_Out_1
// Address spaces for kernel_unloader_1
#define __address_space__unloader_mem_channel __global
__kernel void kernel_unloader_1(
 const int _A_extent_1,
 const int _B_extent_0,
 __address_space__unloader_mem_channel complex *restrict _unloader_mem_channel)
{
 int _addr_temp;
 _addr_temp = 0;
 int _735 = _A_extent_1 >> 7;
 for (int _unloader_s0_i = 0; _unloader_s0_i < 0 + _735; _unloader_s0_i++)
 {
  int _736 = _B_extent_0 >> 7;
  for (int _unloader_s0_j = _unloader_s0_i; _unloader_s0_j < 0 + _736; _unloader_s0_j++)
  {
   for (int _unloader_s0_iii_ii_jj = 0; _unloader_s0_iii_ii_jj < 0 + 2048; _unloader_s0_iii_ii_jj++)
   {
    complex8 __737 = read_channel_intel(_Out_channel);
    int _738 = _addr_temp;
    int _739 = _738 * 8;
    vstore16(__737.t, 0, (__address_space__unloader_mem_channel float*)(_unloader_mem_channel + _739));
    int _740 = _addr_temp;
    int _741 = _740 + 1;
    _addr_temp = _741;
   } // for _unloader_s0_iii_ii_jj
  } // for _unloader_s0_j
 } // for _unloader_s0_i
} // kernel kernel_unloader_1
#undef __address_space__unloader_mem_channel

