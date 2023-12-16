# Matrix Vector Multiply

## Performance (single precision)

| Device | Frequency | Throughput | Logic utilization | DSP blocks | RAM blocks | Efficiency | Matrix and vector Size | Device compiler |
| ------ | --------- | ---------- | ----------------- | ---------- | ---------- | -----------| ----------- | --------------- |
| Intel Arria 10 GX 1150 | 282 MHz | 15.8 GFLOPS (93 % machine peak) | 87,309 / 427,200 ( 20 % ) | 34 / 1,518 ( 2 % ) | 529 / 2,713 ( 19 % ) | 93 % DDR efficiency | A(2K,64K) * X(2K)  | aoc 19.4.0 (on s001-n137) |  
| Intel Stratix 10 SX 2800 | 302 MHz | 35.8 GFLOPS (94 % machine peak) | 252,094 / 933,120 ( 27 % ) | 66 / 5,760 ( 1 % ) | 893 / 11,721 ( 8 % ) | 94 % DDR efficiency | A(2K,128K) * X(2K) | aoc 22.2.0 (on s001-n081) |

Note: 

- GEMV arithmetic intensity is only 1/2, so its machine peak throughput is limited by the DDR bandwidth. The Maximum DDR bandwidth is 34133 MB/s for A10 and 76800 MB/s for S10, respectively, which determines the machine peak throughput as 17 GFLOPS for A10 and 38 GFLOPS for S10, respectively.
- To reproduce the performance:
```
cd bitstream/a10/host-files
g++ host.cpp -DA10 -g -DLINUX -DALTERA_CL -fPIC -Icommon/inc ./common/src/AOCLUtils/opencl.cpp ./common/src/AOCLUtils/options.cpp $(aocl compile-config) $(aocl link-config) -lelf -o host.out
env BITSTREAM=../a.aocx ./host.out
```
Replace `a10` with `s10` if you target S10.
