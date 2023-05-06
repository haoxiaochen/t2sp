# HEMM

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks             | RAM blocks             | Matrix and vector Size   | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ---------------------- | ---------------------- | ------------------------ | ------------------------- |
| Intel Arria 10 GX 1150 | 219 MHz   | 560 GFLOPS | 174,642 / 427,200 ( 41 % ) | 1,299 / 1,518 ( 86 % ) | 1,781 / 2,713 ( 66 % ) | A (10K, 8K) * B (8K, 4K) | aoc 19.4.0 (on s001-n137) |
