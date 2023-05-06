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
bool __attribute__ ((aligned(16))) s[16];
struct {bool s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7,  s8,  s9,  sa,  sb,  sc,  sd,  se,  sf;};
} bool16;
typedef struct { float s; } cga;
channel float16 xLoader_uX_channel __attribute__((depth(256))) ;
channel float16 yLoader_uY_channel __attribute__((depth(256))) ;
channel float Z_uZ_2_channel[64] __attribute__((depth(0))) ;
channel cga Out_unloader_channel __attribute__((depth(256))) ;

#define __address_space_X_serializer_mem_channel __global
__kernel void kernel_xLoader(
 const int X_extent_0,
 __address_space_X_serializer_mem_channel const float *restrict X_serializer_mem_channel) {
 int addr;
 addr = 0;
 for (int k = 0; k < X_extent_0 >> 10; k++)  {
  for (int kk = 0; kk < 64; kk++)   {
   write_channel_intel(xLoader_uX_channel, vload16(0, (__address_space_X_serializer_mem_channel float*)X_serializer_mem_channel + addr * 16));
   addr = addr + 1;
  }
 }
}
#undef __address_space_X_serializer_mem_channel

#define __address_space_Y_serializer_mem_channel __global
__kernel void kernel_yLoader(
 const int X_extent_0,
 __address_space_Y_serializer_mem_channel const float *restrict Y_serializer_mem_channel) {
 int addr;
 addr = 0;
 for (int k = 0; k < X_extent_0 >> 10; k++)  {
  for (int kk = 0; kk < 64; kk++)   {
   write_channel_intel(yLoader_uY_channel, vload16(0, (__address_space_Y_serializer_mem_channel float*)Y_serializer_mem_channel + addr * 16));
   addr = addr + 1;
  }
 }
}
#undef __address_space_Y_serializer_mem_channel

__kernel void kernel_Out(
 const int X_extent_0) {
  float uZ_2_shreg[64];
 cga Out_unloader_channel_array;
 float uZ_1;
 float uZ_1_shreg[64];
 float16 uY_shreg;
 int addr;
 addr = 0;
 float16 uX_shreg;
 float uZ_1_shreg_;
 for (int k = 0; k < X_extent_0 >> 10; k++)  {
  for (int kk = 0; kk < 64; kk++)   {
   uZ_1 = uZ_1_shreg[63];
   #pragma unroll
   for (int l1 = 0; l1 < 63; l1++)    {
    uZ_1_shreg[63 - l1] = uZ_1_shreg[62 - l1];
   }
   uZ_1_shreg[0] = uZ_1;
   uX_shreg = read_channel_intel(xLoader_uX_channel);
   uY_shreg = read_channel_intel(yLoader_uY_channel);
   uZ_1_shreg_ = k == 0 ? float_from_bits(0) : __fpga_reg(uZ_1_shreg[0]);
   #pragma unroll
   for (int kkk = 0; kkk < 16; kkk++)    {
    uZ_1_shreg_ = uZ_1_shreg_ + uX_shreg[kkk] * uY_shreg[kkk];
    if ((kkk & 3) == 3)     {
     uZ_1_shreg_ = __fpga_reg(uZ_1_shreg_);
    }
   }
   uZ_1_shreg[0] = uZ_1_shreg_;
   #pragma unroll
   for (int kkk = 0; kkk < 16; kkk++)    {
    if (k == (X_extent_0 >> 10) - 1 && kkk == 15)     {
    }
   }
  }
 }
 addr = 0;
 #pragma unroll
 for (int kk = 0; kk < 64; kk++)  {
  uZ_2_shreg[kk] = uZ_1_shreg[addr] + (kk == 0 ? float_from_bits(0) : uZ_2_shreg[kk + -1]);
  if (kk == 63)   {
   Out_unloader_channel_array.s = uZ_2_shreg[63];
  }
  addr = addr + 1;
 }
 write_channel_intel(Out_unloader_channel, Out_unloader_channel_array);
}

#define __address_space_unloader_mem_channel __global
__kernel void kernel_unloader(
 __address_space_unloader_mem_channel float *restrict unloader_mem_channel) {
 cga Out_unloader_channel_array;
 Out_unloader_channel_array = read_channel_intel(Out_unloader_channel);
 int addr;
 addr = 0;
 unloader_mem_channel[addr] = Out_unloader_channel_array.s;
 addr = addr + 1;
}
#undef __address_space_unloader_mem_channel

