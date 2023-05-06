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
typedef struct { complex8 s[10]; } cga;
typedef struct { complex8 s[4]; } cga_1;
channel complex8 aLoader_aFeeder_channel __attribute__((depth(256))) ;
channel cga aFeeder_X_channel __attribute__((depth(256))) ;
channel complex8 bLoader_bFeeder_channel __attribute__((depth(256))) ;
channel cga_1 bFeeder_Y_channel __attribute__((depth(256))) ;
channel complex4 Out_unloader_channel __attribute__((depth(256))) ;

#define __address_space_A_serializer_mem_channel __global
__kernel void kernel_aLoader(
 const int A_extent_0,
 const int A_extent_1,
 const int B_extent_0,
 __address_space_A_serializer_mem_channel const complex *restrict A_serializer_mem_channel) {
 int addr;
 addr = 0;
 for (int i = 0; i < A_extent_1 / 320 + 1; i++)  {
  for (int j = 0; j < B_extent_0 >> 7; j++)   {
   for (int k = 0; k < A_extent_0 >> 8; k++)    {
    for (int kk_ii_iii = 0; kk_ii_iii < 10240; kk_ii_iii++)     {
     if (j == 0 && k == 0 || i < A_extent_1 / 320)      {
      write_channel_intel(aLoader_aFeeder_channel, i < A_extent_1 / 320 ? (complex8){vload16(0, (__address_space_A_serializer_mem_channel float*)(A_serializer_mem_channel + (addr / ((B_extent_0 >> 7) * (A_extent_0 >> 8) * 10240) * (A_extent_0 >> 8) * 10240 + addr % ((A_extent_0 >> 8) * 10240)) * 8))} : (complex8)(float16){(complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0))});
     }
     addr = addr + 1;
    }
   }
  }
 }
}
#undef __address_space_A_serializer_mem_channel

__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_aFeeder(
) {
 cga aFeeder_X_channel_array;
 complex8 aFeeder_value_shreg;
 uint aFeeder_time_stamp_shreg;
 complex8 aFeeder_in_v;
 uint aFeeder_cycle;
 complex8 __attribute__((memory, numbanks(16), singlepump)) DB[2][32][32][16];
 #pragma unroll
 for (int jjj_init = 0; jjj_init < 4; jjj_init++)  {
  if (jjj_init == 0)   {
   aFeeder_cycle = (uint)(ADD_UINT64_T_SUFFIX(22528));
  }
 }
 while(1)  {
  if ((uint)(ADD_UINT64_T_SUFFIX(22528)) <= aFeeder_cycle % (uint)(ADD_UINT64_T_SUFFIX(32768)))   {
   aFeeder_in_v = read_channel_intel(aLoader_aFeeder_channel);
  }
  #pragma unroll
  for (int buf = 0; buf < 10; buf++)   {
   if (buf == 0)    {
    aFeeder_value_shreg = aFeeder_in_v;
    aFeeder_time_stamp_shreg = aFeeder_cycle;
   }
   else    {
    aFeeder_value_shreg = aFeeder_value_shreg;
    aFeeder_time_stamp_shreg = aFeeder_time_stamp_shreg;
   }
   aFeeder_value_shreg = __fpga_reg(__fpga_reg(aFeeder_value_shreg));
   aFeeder_time_stamp_shreg = __fpga_reg(__fpga_reg(aFeeder_time_stamp_shreg));
   if ((uint)(ADD_UINT64_T_SUFFIX(22528)) <= aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)))    {
    if (buf == (int)((aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(22528))) % (uint)(ADD_UINT64_T_SUFFIX(10))))     {
     DB[(bool)(aFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)) % (uint)(ADD_UINT64_T_SUFFIX(2)))][(int)(aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(22528))) / 320][(int)(aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(22528))) / 10 % 32][buf] = aFeeder_value_shreg;
    }
   }
   if ((uint)(ADD_UINT64_T_SUFFIX(0)) < aFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)))    {
    aFeeder_X_channel_array.s[buf] = DB[!(bool)(aFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)) % (uint)(ADD_UINT64_T_SUFFIX(2)))][(int)(aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768))) / 1024][(int)(aFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768))) / 32 % 32][buf];
   }
  }
  if ((uint)(ADD_UINT64_T_SUFFIX(0)) < aFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)))   {
   write_channel_intel(aFeeder_X_channel, aFeeder_X_channel_array);
  }
  aFeeder_cycle = aFeeder_cycle + (uint)(ADD_UINT64_T_SUFFIX(1));
 }
}

#define __address_space_B_serializer_mem_channel __global
__kernel void kernel_bLoader(
 const int A_extent_0,
 const int A_extent_1,
 const int B_extent_0,
 __address_space_B_serializer_mem_channel const complex *restrict B_serializer_mem_channel) {
 int addr;
 addr = 0;
 for (int i = 0; i < A_extent_1 / 320 + 1; i++)  {
  for (int j = 0; j < B_extent_0 >> 7; j++)   {
   for (int k = 0; k < A_extent_0 >> 8; k++)    {
    for (int kk_jj_jjj = 0; kk_jj_jjj < 4096; kk_jj_jjj++)     {
     if (j == 0 && k == 0 || i < A_extent_1 / 320)      {
      write_channel_intel(bLoader_bFeeder_channel, i < A_extent_1 / 320 ? (complex8){vload16(0, (__address_space_B_serializer_mem_channel float*)(B_serializer_mem_channel + addr % ((B_extent_0 >> 7) * (A_extent_0 >> 8) * 4096) * 8))} : (complex8)(float16){(complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0)), (complex)(ADD_UINT64_T_SUFFIX(0))});
     }
     addr = addr + 1;
    }
   }
  }
 }
}
#undef __address_space_B_serializer_mem_channel

__attribute__((max_global_work_dim(0)))
__attribute__((autorun))
__kernel void kernel_bFeeder(
) {
 cga_1 bFeeder_Y_channel_array;
 complex8 bFeeder_value_shreg;
 uint bFeeder_time_stamp_shreg;
 complex8 bFeeder_in_v;
 uint bFeeder_cycle;
 complex8 __attribute__((memory, numbanks(4), singlepump)) DB[2][32][32][4];
 #pragma unroll
 for (int iii_init = 0; iii_init < 10; iii_init++)  {
  if (iii_init == 0)   {
   bFeeder_cycle = (uint)(ADD_UINT64_T_SUFFIX(28672));
  }
 }
 while(1)  {
  if ((uint)(ADD_UINT64_T_SUFFIX(28672)) <= bFeeder_cycle % (uint)(ADD_UINT64_T_SUFFIX(32768)))   {
   bFeeder_in_v = read_channel_intel(bLoader_bFeeder_channel);
  }
  #pragma unroll
  for (int buf = 0; buf < 4; buf++)   {
   if (buf == 0)    {
    bFeeder_value_shreg = bFeeder_in_v;
    bFeeder_time_stamp_shreg = bFeeder_cycle;
   }
   else    {
    bFeeder_value_shreg = bFeeder_value_shreg;
    bFeeder_time_stamp_shreg = bFeeder_time_stamp_shreg;
   }
   bFeeder_value_shreg = __fpga_reg(__fpga_reg(bFeeder_value_shreg));
   bFeeder_time_stamp_shreg = __fpga_reg(__fpga_reg(bFeeder_time_stamp_shreg));
   if ((uint)(ADD_UINT64_T_SUFFIX(28672)) <= bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)))    {
    if (buf == (int)((bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(28672))) % (uint)(ADD_UINT64_T_SUFFIX(4))))     {
     DB[(bool)(bFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)) % (uint)(ADD_UINT64_T_SUFFIX(2)))][(int)(bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(28672))) / 128][(int)(bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768)) - (uint)(ADD_UINT64_T_SUFFIX(28672))) / 4 % 32][buf] = bFeeder_value_shreg;
    }
   }
   if ((uint)(ADD_UINT64_T_SUFFIX(0)) < bFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)))    {
    bFeeder_Y_channel_array.s[buf] = DB[!(bool)(bFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)) % (uint)(ADD_UINT64_T_SUFFIX(2)))][(int)(bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768))) / 1024][(int)(bFeeder_time_stamp_shreg % (uint)(ADD_UINT64_T_SUFFIX(32768))) % 32][buf];
   }
  }
  if ((uint)(ADD_UINT64_T_SUFFIX(0)) < bFeeder_time_stamp_shreg / (uint)(ADD_UINT64_T_SUFFIX(32768)))   {
   write_channel_intel(bFeeder_Y_channel, bFeeder_Y_channel_array);
  }
  bFeeder_cycle = bFeeder_cycle + (uint)(ADD_UINT64_T_SUFFIX(1));
 }
}

__kernel void kernel_Out(
 const int A_extent_0,
 const int A_extent_1,
 const int B_extent_0) {
  complex Z_shreg[1024][4][10];
 complex Z_pipe_shreg[4][9217];
  complex8 Y_shreg[4];
 complex Z[4][10];
  complex8 X_shreg[10];
 cga_1 bFeeder_Y_channel_array;
 cga aFeeder_X_channel_array;
 complex Z_shreg_;
 int Z_pipe_iter;
 int Z_pipe_base;
 Z_pipe_iter = 10240;
 Z_pipe_base = 0;
 for (int i_j_k = 0; i_j_k < (A_extent_0 >> 8) * (A_extent_1 / 320 * (B_extent_0 >> 7)) + 1; i_j_k++)  {
  for (int kk_ii_jj = 0; kk_ii_jj < 32768; kk_ii_jj++)   {
   #pragma unroll
   for (int iii = 0; iii < 10; iii++)    {
    #pragma unroll
    for (int jjj = 0; jjj < 4; jjj++)     {
     Z[jjj][iii] = Z_shreg[1023][jjj][iii];
     #pragma unroll
     for (int l1 = 0; l1 < 1023; l1++)      {
      Z_shreg[1023 - l1][jjj][iii] = Z_shreg[1022 - l1][jjj][iii];
     }
     Z_shreg[0][jjj][iii] = Z[jjj][iii];
    }
   }
   if (i_j_k < (A_extent_0 >> 8) * (A_extent_1 / 320 * (B_extent_0 >> 7)))    {
    bFeeder_Y_channel_array = read_channel_intel(bFeeder_Y_channel);
    aFeeder_X_channel_array = read_channel_intel(aFeeder_X_channel);
   }
   #pragma unroll
   for (int iii = 0; iii < 10; iii++)    {
    #pragma unroll
    for (int jjj = 0; jjj < 4; jjj++)     {
     X_shreg[iii] = jjj == 0 ? aFeeder_X_channel_array.s[iii] : X_shreg[iii];
     X_shreg[iii] = __fpga_reg(__fpga_reg(X_shreg[iii]));
     Y_shreg[jjj] = iii == 0 ? bFeeder_Y_channel_array.s[jjj] : Y_shreg[jjj];
     Y_shreg[jjj] = __fpga_reg(__fpga_reg(Y_shreg[jjj]));
     Z_shreg_ = i_j_k % (A_extent_0 >> 8) == 0 && kk_ii_jj >> 10 == 0 ? (complex)(ADD_UINT64_T_SUFFIX(0)) : __fpga_reg(Z_shreg[0][jjj][iii]);
     #pragma unroll
     for (int kkk = 0; kkk < 8; kkk++)      {
      Z_shreg_ = Z_shreg_ + (complex) {X_shreg[iii].s[kkk].s0 * Y_shreg[jjj].s[kkk].s0 - X_shreg[iii].s[kkk].s1 * Y_shreg[jjj].s[kkk].s1, X_shreg[iii].s[kkk].s0 * Y_shreg[jjj].s[kkk].s1 + X_shreg[iii].s[kkk].s1 * Y_shreg[jjj].s[kkk].s0};
      if ((kkk & 3) == 3)       {
       Z_shreg_ = __fpga_reg(Z_shreg_);
      }
     }
     Z_shreg[0][jjj][iii] = Z_shreg_;
     #pragma unroll
     for (int kkk = 0; kkk < 8; kkk++)      {
      if (kkk == 7 && kk_ii_jj >> 10 == 31 && i_j_k % (A_extent_0 >> 8) == (A_extent_0 >> 8) - 1)       {
       Z_pipe_shreg[jjj][iii * 1024] = Z_shreg[0][jjj][iii];
      }
     }
    }
   }
   if ((kk_ii_jj & 31) == 0 && (kk_ii_jj & 1023) >> 5 == 0 && i_j_k % (A_extent_0 >> 8) == (A_extent_0 >> 8) - 1 && kk_ii_jj >> 10 == 31)    {
    Z_pipe_base = Z_pipe_iter;
   }
   complex4 Out_unloader_channel_;
   #pragma unroll
   for (int b_6 = 0; b_6 < 4; b_6++)    {
    Out_unloader_channel_.s[b_6] = Z_pipe_shreg[b_6][0];
    #pragma unroll
    for (int b_6_dummy = 0; b_6_dummy < 4; b_6_dummy++)     {
     Out_unloader_channel_.s[b_6_dummy] = __fpga_reg(__fpga_reg(Out_unloader_channel_.s[b_6_dummy]));
    }
   }
   if (Z_pipe_iter < Z_pipe_base + 10240)    {
    write_channel_intel(Out_unloader_channel, Out_unloader_channel_);
   }
   #pragma unroll
   for (int b_7 = 0; b_7 < 4; b_7++)    {
    #pragma unroll
    for (int p_3 = 0; p_3 < 9; p_3++)     {
     #pragma unroll
     for (int l_3 = 0; l_3 < 1023; l_3++)      {
      Z_pipe_shreg[b_7][p_3 * 1024 + l_3] = Z_pipe_shreg[b_7][p_3 * 1024 + l_3 + 1];
     }
     Z_pipe_shreg[b_7][p_3 * 1024 + 1023] = __fpga_reg(__fpga_reg(Z_pipe_shreg[b_7][p_3 * 1024 + 1024]));
    }
   }
   Z_pipe_iter = Z_pipe_iter + 1;
  }
 }
}

#define __address_space_unloader_mem_channel __global
__kernel void kernel_unloader(
 const int A_extent_1,
 const int B_extent_0,
 __address_space_unloader_mem_channel complex *restrict unloader_mem_channel) {
 int addr;
 addr = 0;
 for (int i = 0; i < A_extent_1 / 320; i++)  {
  for (int j = 0; j < B_extent_0 >> 7; j++)   {
   for (int iii_ii_jj = 0; iii_ii_jj < 10240; iii_ii_jj++)    {
    vstore8(read_channel_intel(Out_unloader_channel).t, 0, (__address_space_unloader_mem_channel float*)(unloader_mem_channel + addr * 4));
    addr = addr + 1;
   }
  }
 }
}
#undef __address_space_unloader_mem_channel

