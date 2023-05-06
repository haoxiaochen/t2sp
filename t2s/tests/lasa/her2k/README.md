# HER2K

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks             | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | ---------------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 246 MHz   | 925 GFLOPS | 191,530 / 427,200 ( 45 % ) | 1,069 / 1,518 ( 70 % ) | 1,471 / 2,713 ( 54 % ) | A (8K, 4K) * B (4K, 8K) | aoc 19.4.0 (on s001-n137) |
