# HERK

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks           | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | -------------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 228 MHz   | 916 GFLOPS | 148,611 / 427,200 ( 35 % ) | 1,027 / 1,518 ( 68 % ) | 997 / 2,713 ( 37 % ) | A (8K, 8K) * B (8K, 8K) | aoc 19.4.0 (on s001-n137) |
