# DOT

## Performance

| Data Type | Device                 | Frequency | Throughput  | Logic utilization          | DSP blocks           | RAM blocks           | Matrix and vector Size | Device compiler           |
| --------- | ---------------------- | --------- | ----------- | -------------------------- | -------------------- | -------------------- | ---------------------- | ------------------------- |
| SDOT      | Intel Arria 10 GX 1150 | 307 MHz   | 6.7 GFLOPS  | 81,170 / 427,200 ( 19 % )  | 82 / 1,518 ( 5 % )   |                      | A (64M) * B (64M)      | aoc 19.4.0 (on s001-n137) |
| DDOT      | Intel Arria 10 GX 1150 | 288 MHz   | 3 GFLOPS    | 113,098 / 427,200 ( 26 % ) | 32 / 1,518 ( 2 % )   | 423 / 2,713 ( 16 % ) | A (64M) * B (64M)      | aoc 19.4.0 (on s001-n137) |
| CDOT      | Intel Arria 10 GX 1150 | 306 MHz   | 12.8 GFLOPS | 85,954 / 427,200 ( 20 % )  | 164 / 1,518 ( 11 % ) | 423 / 2,713 ( 16 % ) | A (64M) * B (64M)      | aoc 19.4.0 (on s001-n137) |
| ZDOT      | Intel Arria 10 GX 1150 | 254 MHz   | 7 GFLOPS    | 148,360 / 427,200 ( 35 % ) | 64 / 1,518 ( 4 % )   | 429 / 2,713 ( 16 % ) | A (64M) * B (64M)      | aoc 19.4.0 (on s001-n137) |
