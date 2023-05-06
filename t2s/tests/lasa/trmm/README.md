# TRMM

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks           | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | -------------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 249 MHz   | 985 GFLOPS | 189,308 / 427,200 ( 44 % ) | 1,047 / 1,518 ( 69 % ) | 999 / 2,713 ( 37 % ) | A (4K, 4K) * B (4K, 4K) | aoc 19.4.0 (on s001-n137) |
