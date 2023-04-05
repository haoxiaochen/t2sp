#include "AOCLUtils/aocl_utils.h"
#include "CL/opencl.h"
#include "CL/cl_ext_intelfpga.h"
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
#define I   128
#define K   128
using namespace aocl_utils;

#define TYPE double

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)

#define DPRINTF(...)     \
    printf(__VA_ARGS__); \
    fflush(stdout);

#define NUM_QUEUES_TO_CREATE    5
#define NUM_KERNELS_TO_CREATE   5

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
    "kernel_aLoader",
    "kernel_xLoader",
    "kernel_xFeeder",
    "kernel_V",
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
    double *A, *B;
    const int TOTAL_I = III * II * I;
    const int TOTAL_K = KKK * KK * K;
    
    if ((A = (double *)acl_aligned_malloc(TOTAL_I*TOTAL_K * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix A");
    }
    if ((B = (double *)acl_aligned_malloc(TOTAL_K * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix A");
    }
    for (size_t i = 0; i < TOTAL_I; i++) {
        for (size_t k = 0; k < TOTAL_K; k++) {
            A[k + i*TOTAL_K] = random();
        }
    }
    for (size_t k = 0; k < TOTAL_K; k++) {
        B[k] = random();
    }

    double *serialized_A_1, *serialized_A_2, *serialized_B;
    if ((serialized_A_1 = (double *)acl_aligned_malloc(TOTAL_I*TOTAL_K/2 * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_A");
    }
    if ((serialized_A_2 = (double *)acl_aligned_malloc(TOTAL_I*TOTAL_K/2 * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_A");
    }
    if ((serialized_B = (double *)acl_aligned_malloc(TOTAL_K*I * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix serialized_A");
    }

    // Serialize A
    long int addr = 0;
    for (int i = 0; i < I; i++)
    for (int k = 0; k < K; k++)
    for (int kk = 0; kk < KK; kk++)
    for (int ii = 0; ii < II; ii++)
    for (int iii = 0; iii < III/2; iii++)
    for (int kkk = 0; kkk < KKK; kkk++) {
        int total_k = kkk + KKK*kk + KKK*KK*k;
        int total_i = iii + III*ii + III*II*i;
        serialized_A_1[addr] = A[total_k + TOTAL_K*total_i];
        serialized_A_2[addr] = A[total_k + TOTAL_K*(total_i+III/2)];
        addr++;
    }
    // Serialize B
    addr = 0;
    for (int i = 0; i < I; i++)
    for (int k = 0; k < K; k++)
    for (int kk = 0; kk < KK; kk++)
    for (int kkk = 0; kkk < KKK; kkk++) {
        int total_k = kkk + KKK*kk + KKK*KK*k;
        serialized_B[addr++] = B[total_k];
    }

    DPRINTF("\n===== Host-CPU setting up the OpenCL platform and device ======\n\n");

    // Use this to check the output of each API call
    cl_int status;

    //----------------------------------------------
    // Discover and initialize the platforms
    //----------------------------------------------
    cl_uint numPlatforms = 0;
    cl_platform_id platform = NULL;

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

    cl_mem input_A_buf_1, input_A_buf_2;
    cl_mem input_B_buf;
    cl_mem output_C_buf;

    DPRINTF("\n===== Host-CPU transferring W and X to the FPGA device global memory (DDR4) via PCIe ======\n\n");
    input_A_buf_1 = clCreateBuffer(
        context,
        CL_MEM_READ_ONLY | CL_CHANNEL_1_INTELFPGA,
        TOTAL_K * TOTAL_I / 2 * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    input_A_buf_2 = clCreateBuffer(
        context,
        CL_MEM_READ_ONLY | CL_CHANNEL_2_INTELFPGA,
        TOTAL_K * TOTAL_I / 2 * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    input_B_buf = clCreateBuffer(
        context,
        CL_MEM_READ_ONLY | CL_CHANNEL_AUTO_INTELFPGA,
        TOTAL_K * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    output_C_buf = clCreateBuffer(
        context,
        CL_MEM_WRITE_ONLY | CL_CHANNEL_AUTO_INTELFPGA,
        TOTAL_I * sizeof(cl_double),
        NULL,
        &status);
    CHECK(status);

    //----------------------------------------------
    // Write host data to device buffers
    //----------------------------------------------

    // blocking writes
    status = clEnqueueWriteBuffer(
        cmdQueue[0],
        input_A_buf_1,
        CL_TRUE,
        0,
        TOTAL_K * TOTAL_I / 2 * sizeof(cl_double),
        serialized_A_1,
        0,
        NULL,
        NULL);
    CHECK(status);

    status = clEnqueueWriteBuffer(
        cmdQueue[0],
        input_A_buf_2,
        CL_TRUE,
        0,
        TOTAL_K * TOTAL_I / 2 * sizeof(cl_double),
        serialized_A_2,
        0,
        NULL,
        NULL);
    CHECK(status);

    status = clEnqueueWriteBuffer(
        cmdQueue[1],
        input_B_buf,
        CL_TRUE,
        0,
        TOTAL_K * sizeof(cl_double),
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
        sizeof(cl_mem),
        (void *)&input_A_buf_1);
    CHECK(status);
    status = clSetKernelArg(
        kernel[0],
        3,
        sizeof(cl_mem),
        (void *)&input_A_buf_2);
    CHECK(status);
    // X_loader
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
        sizeof(cl_mem),
        (void *)&input_B_buf);
    CHECK(status);
    // X_feeder
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
    // kernel_V
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
    // unloader
    status = clSetKernelArg(
        kernel[4],
        0,
        sizeof(int),
        (void *)&TOTAL_I);
    CHECK(status);
    status = clSetKernelArg(
        kernel[4],
        1,
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
    printf("  FPGA GEMM exec time\t\t= %.5f s\n", k_overall_exec_time);

    // multiplied by 1.0e-9 to get G-FLOPs
    printf("\n");

    double num_operations = (double)2.0 * (TOTAL_K) * (double)(TOTAL_I);

    printf("  # operations = %.0f\n", num_operations );
    printf("  Throughput: %.5f GFLOPS\n", (double)1.0e-9 * num_operations / k_overall_exec_time);

    DPRINTF("\n===== Host-CPU transferring result matrix C from the FPGA device global memory (DDR4) via PCIe ======\n\n");

    // Read the results back from the device, blocking read
    double *C;
    if ((C = (double *)acl_aligned_malloc(TOTAL_I * sizeof(double))) == NULL) {
        perror("Failed malloc of matrix C");
    }

    clEnqueueReadBuffer(
        //cmdQueue[KID_DRAIN_MAT_C],
        cmdQueue[NUM_KERNELS_TO_CREATE], // using a special queue for reading buffer C
        output_C_buf,
        CL_TRUE,
        0,
        TOTAL_I * sizeof(cl_double),
        C,
        0,
        NULL,
        NULL);
    CHECK(status);

    bool passed = 1;
    for (size_t i = 0; i < I; i++)
    for (size_t ii = 0; ii < II; ii++)
    for (size_t iii = 0; iii < III; iii++) {
        size_t total_i = iii + III * ii + III * II * i;
        double golden = 0.0;
        for (size_t k = 0; k < TOTAL_K; k++) {
            golden += A[k+TOTAL_K*total_i] * B[k];
        }
        passed &= fabs(golden - C[total_i]) < 0.005*fabs(golden);
        assert(fabs(golden - C[total_i]) < 0.005*fabs(golden));
    }

    if (passed) {
        printf("[PASSED]\n");
    } else {
        printf("[FAILED]\n");
    }
}
