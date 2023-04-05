# TRMM

## Performance

| Device                 | Frequency | Throughput                      | Logic utilization          | DSP blocks             | RAM blocks           | Efficiency      | Matrix and vector Size  | Device compiler           |
| ---------------------- | --------- | ------------------------------- | -------------------------- | ---------------------- | -------------------- | --------------- | ----------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 239 MHz   | 237 GFLOPS (193 % machine peak) | 268,634 / 427,200 ( 63 % ) | 1,025 / 1,518 ( 68 % ) | 846 / 2,713 ( 31 % ) | 96 % efficiency | A (2K, 2K) * B (2K, 2K) | aoc 19.2.0 (on s001-n137) |


