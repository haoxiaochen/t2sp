# TRSV

## Performance (single precision)

| Device | Frequency | Throughput | Logic utilization | DSP blocks | RAM blocks | Efficiency | Matrix and vector Size | Device compiler |
| ------ | --------- | ---------- | ----------------- | ---------- | ---------- | -----------| ----------- | --------------- |
| Intel Arria 10 GX 1150 | 301 MHz | 15.1 GFLOPS | 76,205 / 427,200 ( 23 % ) | 36 / 1,518 ( 2 % ) | 495 / 2,713 ( 18 % ) | 89 % DDR efficiency | A(16K,16K) * X(16K)  | aoc 19.4.0 (on s001-n137) |

Note: 
- The throughput is measured in the number of MAC operations performed.
