# TRSM

## Performance (single precision)

| Device | Frequency | Throughput | Logic utilization | DSP blocks | RAM blocks | Efficiency | Matrix and vector Size | Device compiler |
| ------ | --------- | ---------- | ----------------- | ---------- | ---------- | -----------| ----------- | --------------- |
| Intel Arria 10 GX 1150 | 239 MHz | 402 GFLOPS | 217,998 / 427,200 ( 51 % ) | 1,092 / 1,518 ( 72 % ) | 1,929 / 2,713 ( 71 % ) | 94 % efficiency | A(8K,8K) * X(8K,224)  | aoc 19.4.0 (on s001-n137) |
Note: 

- The throughput is measured in the number of MAC operations performed.
- The peak throughput is defined by the number of DSPs used for MAC (16*56=896 in this design) * frequency * 2, which is 428 GFlops
