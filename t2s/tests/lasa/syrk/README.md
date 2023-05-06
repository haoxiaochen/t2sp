# SYRK

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks             | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | ---------------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 237 MHz   | 938 GFLOPS | 194,341 / 427,200 ( 45 % ) | 1,043 / 1,518 ( 69 % ) | 1,007 / 2,713 ( 37 % ) | A (4K, 4K) * B (4K, 4K) | aoc 19.4.0 (on s001-n137) |
