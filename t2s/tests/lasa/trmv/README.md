# TRMV

## Performance

| Device                 | Frequency | Throughput | Logic utilization          | DSP blocks         | RAM blocks           | Matrix and vector Size | Device compiler           |
| ---------------------- | --------- | ---------- | -------------------------- | ------------------ | -------------------- | ---------------------- | ------------------------- |
| Intel Arria 10 GX 1150 | 242 MHz   | 27 GFLOPS  | 101,968 / 427,200 ( 24 % ) | 39 / 1,518 ( 3 % ) | 590 / 2,713 ( 22 % ) | A (32K, 32K) * X (32K) | aoc 19.4.0 (on s001-n137) |
