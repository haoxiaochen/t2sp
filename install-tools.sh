./install-tool.sh m4
./install-tool.sh gmp
./install-tool.sh mpfr
./install-tool.sh mpc
./install-tool.sh cmake
./install-tool.sh gcc
./install-tool.sh llvm-clang 
./install-tool.sh python-packages
./install-tool.sh cm
./install-tool.sh re2c
./install-tool.sh ninja
./install-tool.sh oneapi-esimd
./install-tool.sh oneapi-support

cd Halide
make -j
