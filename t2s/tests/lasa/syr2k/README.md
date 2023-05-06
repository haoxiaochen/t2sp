# SYR2K

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks             | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | ---------------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 231 MHz   | 875 GFLOPS | 219,825 / 427,200 ( 51 % ) | 1,069 / 1,518 ( 70 % ) | 1,267 / 2,713 ( 47 % ) | A (4K, 4K) * B (4K, 4K) | aoc 19.4.0 (on s001-n137) |
