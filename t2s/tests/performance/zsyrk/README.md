# SYRK

## Performance

| Device                 | Frequency | Throughput                      | Logic utilization          | DSP blocks             | RAM blocks           | Efficiency      | Matrix and vector Size  | Device compiler |
| ---------------------- | --------- | ------------------------------- | -------------------------- | ---------------------- | -------------------- | --------------- | ----------------------- | --------------- |
| Intel Arria 10 GX 1150 | 242 MHz   | 220 GFLOPS (177 % machine peak) | 261,049 / 427,200 ( 61 % ) | 1,027 / 1,518 ( 68 % ) | 789 / 2,713 ( 29 % ) | 88 % efficiency | A (2K, 2K) * B (2K, 2K) |                 |
