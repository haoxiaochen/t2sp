// Copyright (C) 2013-2019 Altera Corporation, San Jose, California, USA. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
// whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// This agreement shall be governed in all respects by the laws of the State of California and
// by the laws of the United States of America.


// This file is modified from /glob/development-tools/versions/fpgasupportstack/a10/1.2.1/intelFPGA_pro/hld/examples_aoc/matrix_mult/host/src/main.cpp

// Currently on DevCloud A10 nodes, Halide OpenCL runtime has issue in clFlush. So we temporarily provide this host file.
// We will no longer need it in future.
//
// compile and run (for example):
//      g++ host.cpp -DLARGE -g -DLINUX -DALTERA_CL -fPIC -Icommon/inc ./common/src/AOCLUtils/opencl.cpp ./common/src/AOCLUtils/options.cpp -I$ALTERAOCLSDKROOT/host/include $AOCL_LIBS -lelf -o host.out
//      Emulation:
//          env CL_CONTEXT_EMULATOR_DEVICE_INTELFPGA=1 BITSTREAM="a.aocx" ./host.out
//      HW: 
//          env BITSTREAM="conv_unsigned.aocx" ./host.out
#include "AOCLUtils/aocl_utils.h"
#include "CL/opencl.h"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <math.h>
#include <sstream>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <sys/time.h>
#include <time.h>

#include "../const-parameters.h"

#ifdef TEST
#define OUTERMOST_I     2
#define OUTERMOST_J     2
#define OUTERMOST_K     2
#else
#define OUTERMOST_I     64
#define OUTERMOST_J     64
#define OUTERMOST_K     64
#endif

using namespace aocl_utils;

#define TYPE double

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)

#define DPRINTF(...)     \
    printf(__VA_ARGS__); \
    fflush(stdout);

#define NUM_QUEUES_TO_CREATE    8
#define NUM_KERNELS_TO_CREATE   8

#define CHECK(status)                                       \
    if (status != CL_SUCCESS) {                             \
        printf("error %d in line %d.\n", status, __LINE__); \
        exit(1);                                            \
    }

#define ACL_ALIGNMENT 64
void *acl_aligned_malloc(size_t size) {
    void *result = NULL;
    posix_memalign(&result, ACL_ALIGNMENT, size);
    return result;
}

const char *kernel_name[] = {
    "kernel_ALoader",
    "kernel_BLoader",
    "kernel_Out",
    "kernel_ALoader_T",
    "kernel_BLoader_T",
    "kernel_Out_T",
    "kernel_E",
    "kernel_unloader"
};

double compute_kernel_execution_time(cl_event &event, double &start_d, double &end_d) {
    cl_ulong start, end;

    clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &end, NULL);
    clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &start, NULL);

    start_d = (double)1.0e-9 * start;
    end_d = (double)1.0e-9 * end;
    //return (double)(end-start);
    return (double)1.0e-9 * (end - start); // nanoseconds to seconds
}


int main() {
    double *A, *B, *C;
    const int TOTAL_I = III * II * OUTERMOST_I;
    const int TOTAL_J = JJJ * JJ * OUTERMOST_J;
    const int TOTAL_K = KKK * KK * OUTERMOST_K;
    
    long int num_elem_A = (long int)TOTAL_I*TOTAL_K*2;
    long int num_elem_B = (long int)TOTAL_K*TOTAL_J*2;
    long int num_elem_C = (long int)TOTAL_I*TOTAL_J*2;
    if ((A = (double *)acl_aligned_malloc(num_elem_A * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix A");
    }
    if ((B = (double *)acl_aligned_malloc(num_elem_B * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix B");
    }
    if ((C = (double *)acl_aligned_malloc(num_elem_C * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix C");
    }
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            A[(k + i*TOTAL_K)*2] = i;
            A[(k + i*TOTAL_K)*2+1] = i;
        }
    }
    for (size_t j = 0; j < TOTAL_J; j++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            B[(j + k*TOTAL_J)*2] = j;
            B[(j + k*TOTAL_J)*2+1] = j;
        }
    }

    double *serialized_A, *serialized_B;
    if ((serialized_A = (double *)acl_aligned_malloc(num_elem_A * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_A");
    }
    if ((serialized_B = (double *)acl_aligned_malloc(num_elem_B * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_A");
    }

    // Serialize A
    long int addr = 0;
    for (int i = 0; i < OUTERMOST_I; i++)
    for (int k = 0; k < OUTERMOST_K; k++)
    for (int kk = 0; kk < KK; kk++)
    for (int ii = 0; ii < II; ii++)
    for (int iii = 0; iii < III; iii++)
    for (int kkk = 0; kkk < KKK; kkk++) {
        int total_k = kkk + KKK*kk + KKK*KK*k;
        int total_i = iii + III*ii + III*II*i;
        serialized_A[addr*2] = A[(total_k + total_i*TOTAL_K)*2];
        serialized_A[addr*2+1] = A[(total_k + total_i*TOTAL_K)*2+1];
        addr++;
    }
    // Serialize B
    addr = 0;
    for (int j = 0; j < OUTERMOST_J; j++)
    for (int k = 0; k < OUTERMOST_K; k++)
    for (int kk = 0; kk < KK; kk++)
    for (int jj = 0; jj < JJ; jj++)
    for (int jjj = 0; jjj < JJJ; jjj++)
    for (int kkk = 0; kkk < KKK; kkk++) {
        int total_k = kkk + KKK*kk + KKK*KK*k;
        int total_j = jjj + JJJ*jj + JJJ*JJ*j;
        serialized_B[addr*2] = B[(total_j + total_k*TOTAL_J)*2];
        serialized_B[addr*2+1] = B[(total_j + total_k*TOTAL_J)*2+1];
        addr++;
    }

    DPRINTF("\n===== Host-CPU setting up the OpenCL platform and device ======\n\n");

    // Use this to check the output of each API call
    cl_int status;

    //----------------------------------------------
    // Discover and initialize the platforms
    //----------------------------------------------
    cl_uint numPlatforms = 0;
    cl_platform_id platform;

    const char *name = getenv("INTEL_FPGA_OCL_PLATFORM_NAME");
    platform = findPlatform(name);
    if(platform == NULL) {
        DPRINTF("ERROR: Unable to find Intel(R) FPGA OpenCL platform\n");
        return -1;
    }

    cl_uint numDevices = 0;
    cl_device_id *devices = NULL;
    // Device info
    char buffer[4096];
    unsigned int buf_uint;
    int device_found = 0;

    printf("Initializing IDs\n");
    status = clGetDeviceIDs(platform,
                    CL_DEVICE_TYPE_ALL,
                    0,
                    NULL,
                    &numDevices);

    if(status == CL_SUCCESS){
        printf("Found IDs\n");
        clGetPlatformInfo(platform,
                        CL_PLATFORM_VENDOR,
                        4096,
                        buffer,
                        NULL);

        if(strstr(buffer, "Intel(R)") != NULL){
                device_found = 1;
        }
        printf("%s\n", buffer);

        if(device_found){
            // Allocate enough space for each device
            devices = (cl_device_id*)
            acl_aligned_malloc (numDevices * sizeof(cl_device_id));

            // Fill in devices with clGetDeviceIDs()
            status = clGetDeviceIDs(platform,
                            CL_DEVICE_TYPE_ALL,
                            numDevices,
                            devices,
                            NULL);
        }
    }

    if (!device_found) {
        DPRINTF("failed to find a OpenCL device\n");
        exit(-1);
    }

    DPRINTF("Total number of devices: %d\n", numDevices);

    //----------------------------------------------
    // Create a context
    //----------------------------------------------

    DPRINTF("\n===== Host-CPU setting up the OpenCL command queues ======\n\n");

    cl_context context = NULL;

    // Create a context using clCreateContext() and
    // associate it with the device

    context = clCreateContext(
        NULL,
        1,
        devices,
        NULL,
        NULL,
        &status);
    CHECK(status);

    //----------------------------------------------
    // Create command queues
    //---------------------------------------------

    cl_command_queue cmdQueue[NUM_QUEUES_TO_CREATE + 1]; // extra queue for reading buffer D

    // Create a command queue using clCreateCommandQueue(),
    // and associate it with the device you want to execute on
    for (int i = 0; i < NUM_QUEUES_TO_CREATE; i++) {
        //fDPRINTF(stdout,"cmdQueue i = %d\n", i);
        cmdQueue[i] = clCreateCommandQueue(
            context,
            devices[0],
            CL_QUEUE_PROFILING_ENABLE,
            &status);
        CHECK(status);
    }

    //fDPRINTF(stdout,"cmdQueue i = %d, a queue for reading the C buffer\n", i);
    cmdQueue[NUM_QUEUES_TO_CREATE] = clCreateCommandQueue(
        context,
        devices[0],
        CL_QUEUE_PROFILING_ENABLE,
        &status);
    CHECK(status);

    //----------------------------------------------
    // Create device buffers
    //----------------------------------------------

    cl_mem input_A_buf;
    cl_mem input_B_buf;
    cl_mem output_C_buf;

    DPRINTF("\n===== Host-CPU transferring W and X to the FPGA device global memory (DDR4) via PCIe ======\n\n");
    input_A_buf = clCreateBuffer(
        context,
        //CL_MEM_READ_ONLY | CL_MEM_BANK_1_ALTERA,
        CL_MEM_READ_ONLY,
        num_elem_A * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    input_B_buf = clCreateBuffer(
        context,
        //CL_MEM_READ_ONLY | CL_MEM_BANK_1_ALTERA,
        CL_MEM_READ_ONLY,
        num_elem_B * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    output_C_buf = clCreateBuffer(
        context,
        //CL_MEM_WRITE_ONLY | CL_MEM_BANK_1_ALTERA,
        CL_MEM_WRITE_ONLY,
        num_elem_C * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    //----------------------------------------------
    // Write host data to device buffers
    //----------------------------------------------

    // blocking writes
    status = clEnqueueWriteBuffer(
        cmdQueue[0],
        input_A_buf,
        CL_TRUE,
        0,
        num_elem_A * sizeof(cl_double),
        serialized_A,
        0,
        NULL,
        NULL);
    CHECK(status);

    status = clEnqueueWriteBuffer(
        cmdQueue[1],
        input_B_buf,
        CL_TRUE,
        0,
        num_elem_B * sizeof(cl_double),
        serialized_B,
        0,
        NULL,
        NULL);
    CHECK(status);

    //----------------------------------------------
    // Create the program from binaries
    //----------------------------------------------
    DPRINTF("\n===== Host-CPU setting up OpenCL program and kernels ======\n\n");

    cl_program program;

    size_t binary_length;
    const unsigned char *binary;

    fflush(stdout);
    // create the program using binary already compiled offline using aoc (i.e. the .aocx file)
    char *aocx_file = getenv("BITSTREAM");
    FILE *fp = fopen(aocx_file, "rb");

    if (fp == NULL) {
        DPRINTF("Failed to open the AOCX file (fopen).\n");
        return -1;
    }

    fseek(fp, 0, SEEK_END);
    binary_length = ftell(fp);
    binary = (unsigned char *)malloc(sizeof(unsigned char) * binary_length);
    assert(binary && "Malloc failed");
    rewind(fp);

    if (fread((void *)binary, binary_length, 1, fp) == 0) {
        DPRINTF("Failed to read from the AOCX file (fread).\n");
        return -1;
    }
    fclose(fp);

    DPRINTF("Create program with binary\n");
    // Create a program using clCreateProgramWithBinary()
    program = clCreateProgramWithBinary(
        context,
        1,
        devices,
        &binary_length,
        (const unsigned char **)&binary,
        &status,
        NULL);
    CHECK(status);

    //----------------------------------------------
    // Create the kernel
    //----------------------------------------------

    status = clBuildProgram(program, 0, NULL, NULL, NULL, NULL);
    if (status != CL_SUCCESS) {
        char log[128 * 1024] = {0};
        clGetProgramBuildInfo(program, devices[0], CL_PROGRAM_BUILD_LOG, 128 * 1024, log, NULL);
        DPRINTF("%s\n", log);
        CHECK(status);
    }

    cl_kernel kernel[NUM_KERNELS_TO_CREATE];

    for (int j = 0; j < NUM_KERNELS_TO_CREATE; j++) {
        DPRINTF("Creating kernel[%d]: %s\n", j, kernel_name[j]);
        kernel[j] = clCreateKernel(program, (const char *)kernel_name[j], &status);
        CHECK(status);
    }
    DPRINTF("All kernels created\n");

    // A_loader
    status = clSetKernelArg(
        kernel[0],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[0],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[0],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    status = clSetKernelArg(
        kernel[0],
        3,
        sizeof(cl_mem),
        (void *)&input_A_buf);
    CHECK(status);
    // B_loader
    status = clSetKernelArg(
        kernel[1],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[1],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[1],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    status = clSetKernelArg(
        kernel[1],
        3,
        sizeof(cl_mem),
        (void *)&input_B_buf);
    CHECK(status);
    // Out
    status = clSetKernelArg(
        kernel[2],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[2],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[2],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);

    // A_loader_T
    status = clSetKernelArg(
        kernel[3],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[3],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[3],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    status = clSetKernelArg(
        kernel[3],
        3,
        sizeof(cl_mem),
        (void *)&input_A_buf);
    CHECK(status);
    // B_loader_T
    status = clSetKernelArg(
        kernel[4],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[4],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[4],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    status = clSetKernelArg(
        kernel[4],
        3,
        sizeof(cl_mem),
        (void *)&input_B_buf);
    CHECK(status);
    // Out
    status = clSetKernelArg(
        kernel[5],
        0,
        sizeof(int),
        (void *)&TOTAL_K);
    CHECK(status);
    status = clSetKernelArg(
        kernel[5],
        1,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[5],
        2,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);

    // E
    status = clSetKernelArg(
        kernel[6],
        0,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[6],
        1,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    // unloader
    status = clSetKernelArg(
        kernel[7],
        0,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[7],
        1,
        sizeof(int),
        (void *)&TOTAL_J);
    CHECK(status);
    status = clSetKernelArg(
        kernel[7],
        2,
        sizeof(cl_mem),
        (void *)&output_C_buf);
    CHECK(status);

    //----------------------------------------------
    // Configure the work-item structure (using only tasks atm)
    //----------------------------------------------

    // Define the number of threads that will be created
    // as well as the number of work groups
    size_t globalWorkSize[1];
    size_t localWorkSize[1];

    //----------------------------------------------
    // Enqueue the kernel for execution
    //----------------------------------------------

    // all kernels are always tasks
    globalWorkSize[0] = 1;
    localWorkSize[0] = 1;

    cl_event kernel_exec_event[NUM_KERNELS_TO_CREATE];

    DPRINTF("\n===== Host-CPU enqeuing the OpenCL kernels to the FPGA device ======\n\n");
    for (int i = 0; i < NUM_KERNELS_TO_CREATE; i++) {
        // Alternatively, can use clEnqueueTaskKernel
        DPRINTF("clEnqueueNDRangeKernel[%d]: %s!\n", i, kernel_name[i]);
        status = clEnqueueNDRangeKernel(
            cmdQueue[i],
            kernel[i],
            1,
            NULL,
            globalWorkSize,
            localWorkSize,
            0,
            NULL,
            &kernel_exec_event[i]);
        CHECK(status);
    }
    DPRINTF(" *** FPGA execution started!\n");

    for (int i = 0; i < NUM_KERNELS_TO_CREATE; i++) {
        status = clFlush(cmdQueue[i]);
        CHECK(status);
    }

    for (int i = 0; i < NUM_QUEUES_TO_CREATE; i++) {
        DPRINTF("cmd queue: %d\n", i);
        fflush(stdout);
        status = clFinish(cmdQueue[i]);
        CHECK(status);
    }
    DPRINTF(" *** FPGA execution finished!\n");
    DPRINTF("\n\n");

    double k_start_time[NUM_KERNELS_TO_CREATE];
    double k_end_time[NUM_KERNELS_TO_CREATE];
    double k_exec_time[NUM_KERNELS_TO_CREATE];
    double max_time = 0;
    for (int i = 0; i < NUM_KERNELS_TO_CREATE; i++) {
        k_exec_time[i] = compute_kernel_execution_time(kernel_exec_event[i], k_start_time[i], k_end_time[i]);
        if (k_exec_time[i] > max_time) {
            max_time = k_exec_time[i];
        }
    }
    DPRINTF("Time taken: %lf sec\n\n", max_time);

    printf("\n===== Reporting measured throughput ======\n\n");
    double k_earliest_start_time = k_start_time[0];
    double k_latest_end_time = k_end_time[0];

    for (int i = 1; i < NUM_KERNELS_TO_CREATE; i++) {
        if (k_start_time[i] < k_earliest_start_time)
            k_earliest_start_time = k_start_time[i];

        if (k_end_time[i] > k_latest_end_time)
            k_latest_end_time = k_end_time[i];
    }

    // IMPORTANT: we care about the finish time of drain_C, once data is drained we are done
    k_latest_end_time = k_end_time[NUM_KERNELS_TO_CREATE - 1];

    for (int i = 0; i < NUM_KERNELS_TO_CREATE; i++) {
        printf("  Kernel execution time on FPGA: %s, \n   \t\t\t\t\t\t\t\t\texec time = %.5f s, start=%.5f s, end=%.5f s\n", kernel_name[i], k_exec_time[i], k_start_time[i], k_end_time[i]);
    }

    double k_overall_exec_time = k_latest_end_time - k_earliest_start_time;

    printf("\n");
    printf("  Loader kernels start time\t\t= %.5f s\n", k_earliest_start_time);
    printf("  Unloader kernels end time\t\t= %.5f s\n", k_latest_end_time);
    printf("  FPGA SYR2K exec time\t\t= %.5f s\n", k_overall_exec_time);

    // multiplied by 1.0e-9 to get G-FLOPs
    printf("\n");

    double num_operations = (double)16.0 * (TOTAL_K) * (double)(TOTAL_I) * (double)(TOTAL_J);

    printf("  # operations = %.0f\n", num_operations );
    printf("  Throughput: %.5f GFLOPS\n", (double)1.0e-9 * num_operations / k_overall_exec_time);

    DPRINTF("\n===== Host-CPU transferring result matrix C from the FPGA device global memory (DDR4) via PCIe ======\n\n");

    // Read the results back from the device, blocking read
    double *serialized_Z;
    if ((serialized_Z = (double *)acl_aligned_malloc(num_elem_C * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_Z");
    }

    clEnqueueReadBuffer(
        //cmdQueue[KID_DRAIN_MAT_C],
        cmdQueue[NUM_KERNELS_TO_CREATE], // using a special queue for reading buffer C
        output_C_buf,
        CL_TRUE,
        0,
        num_elem_C * sizeof(cl_double),
        serialized_Z,
        0,
        NULL,
        NULL);
    CHECK(status);

    // Deserialize Z
    addr = 0;
    for (size_t i = 0; i < OUTERMOST_I; i++)
    for (size_t j = i; j < OUTERMOST_J; j++)
    for (size_t iii = 0; iii < III; iii++) 
    for (size_t ii = 0; ii < II; ii++)
    for (size_t jj = 0; jj < JJ; jj++)
    for (size_t jjj = 0; jjj < JJJ; jjj++) {
        size_t total_i = iii + III * ii + III * II * i;
        size_t total_j = jjj + JJJ * jj + JJJ * JJ * j;
        C[(total_j + total_i*TOTAL_J)*2] = serialized_Z[addr*2];
        C[(total_i + total_j*TOTAL_I)*2] = serialized_Z[addr*2];
        C[(total_j + total_i*TOTAL_J)*2+1] = serialized_Z[addr*2+1];
        C[(total_i + total_j*TOTAL_I)*2+1] = serialized_Z[addr*2+1];
        addr += 1;
    }

    bool passed = 1;
#ifdef TEST
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t j = 0; j < TOTAL_J; j++) {
            double golden_re = 0.0;
            double golden_im = 0.0;
            for (size_t k = 0; k < TOTAL_K; k++) {
                golden_re += A[(k+i*TOTAL_K)*2] * B[(j+k*TOTAL_J)*2] - A[(k+i*TOTAL_K)*2+1] * B[(j+k*TOTAL_J)*2+1];
                golden_re += A[(k+j*TOTAL_I)*2] * B[(i+k*TOTAL_I)*2] - A[(k+j*TOTAL_I)*2+1] * B[(i+k*TOTAL_I)*2+1];
                golden_im += A[(k+i*TOTAL_K)*2] * B[(j+k*TOTAL_J)*2+1] + A[(k+i*TOTAL_K)*2+1] * B[(j+k*TOTAL_J)*2];
                golden_im += A[(k+j*TOTAL_I)*2] * B[(i+k*TOTAL_I)*2+1] + A[(k+j*TOTAL_I)*2+1] * B[(i+k*TOTAL_I)*2];
            }
            passed &= fabs(golden_re - C[(j+i*TOTAL_J)*2]) <= 0.005*fabs(golden_re);
            if (fabs(golden_re - C[(j+i*TOTAL_J)*2]) > 0.005*fabs(golden_re)) {
                printf("%ld %ld: %5.2f, %5.2f\n", i, j, golden_re, C[(j+i*TOTAL_J)*2]);
            }
        }
    }
#endif
    if (passed) {
        printf("[PASSED]\n");
    } else {
        printf("[FAILED]\n");
    }
}

