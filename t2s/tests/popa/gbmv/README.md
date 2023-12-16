# Baned Matrix Vector Multiply

## Performance (single precision)

| Device | Frequency | Throughput | Logic utilization | DSP blocks | RAM blocks | Efficiency | Matrix and vector Size | Device compiler |
| ------ | --------- | ---------- | ----------------- | ---------- | ---------- | -----------| ----------- | --------------- |
| Intel Arria 10 GX 1150 | 277 MHz | 125 GFLOPS (705 % machine peak) | 88,899 / 427,200 ( 21 % ) | 32 / 1,518 ( 2 % ) | 666 / 2,713 ( 25 % ) | 92 % DDR efficiency | A(32K,32K) * X(32K), Ku, Kl = 2047 | aoc 19.4.0 (on s001-n138) |
| Intel Stratix 10 SX 2800 | 292 MHz | 278 GFLOPS (744 % machine peak) | 256,408 / 933,120 ( 27 % ) | 64 / 5,760 ( 1 % ) | 1,027 / 11,721 ( 9 % ) | 92 % DDR efficiency | A(32K,32K) * X(32K), Ku, Kl = 2047 | aoc 22.3.0 (on s001-n142) |

Note: 
- We transform an input matrix into a compact banded storage, so the throughput is determined by the matrix's sparsity.
- The computation is similar to GEMV. GEMV arithmetic intensity is only 1/2, so its machine peak throughput is limited by the DDR bandwidth. The Maximum DDR bandwidth is 34133 MB/s for A10 and 76800 MB/s for S10, respectively, which determines the machine peak throughput as 17 GFLOPS for A10 and 38 GFLOPS for S10, respectively.
- To reproduce the performance:
```
cd bitstream/a10/host-files
g++ host.cpp -DA10 -g -DLINUX -DALTERA_CL -fPIC -Icommon/inc ./common/src/AOCLUtils/opencl.cpp ./common/src/AOCLUtils/options.cpp $(aocl compile-config) $(aocl link-config) -lelf -o host.out
env BITSTREAM=../a.aocx ./host.out
```
Replace `a10` with `s10` if you target S10.
