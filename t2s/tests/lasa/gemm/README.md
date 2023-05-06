# GEMM

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks             | Matrix and vector Size   | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | ---------------------- | ------------------------ | ------------------------- |
| Intel Arria 10 GX 1150 | 223 MHz   | 570 GFLOPS | 202,955 / 427,200 ( 48 % ) | 1,289 / 1,518 ( 85 % ) | 2,068 / 2,713 ( 76 % ) | A (10K, 8K) * B (8K, 4K) | aoc 19.4.0 (on s001-n137) |
