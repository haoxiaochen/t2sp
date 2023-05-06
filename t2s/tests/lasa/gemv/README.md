# GEMV

## Performance

| Device                 | Frequency | Throughput  | Logic utilization         | DSP blocks         | RAM blocks           | Matrix and vector Size | Device compiler           |
| ---------------------- | --------- | ----------- | ------------------------- | ------------------ | -------------------- | ---------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 249 MHz   | 10.4 GFLOPS | 91,655 / 427,200 ( 21 % ) | 32 / 1,518 ( 2 % ) | 502 / 2,713 ( 19 % ) | A (32K, 1K) * X (1K)   | aoc 19.4.0 (on s001-n137) |
