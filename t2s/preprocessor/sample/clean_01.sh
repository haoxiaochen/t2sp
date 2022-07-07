# Change to clang include directory
CWD="$PWD"
cd ./sample_01/
echo "CWD: $PWD"

# Run
echo "cleaning..."
rm -rf a.out;
rm -rf test.fpga_emu;
rm -rf post.*;
rm -rf gemm.generated_oneapi_header.h;

# Return back to the directory
cd ${CWD}
echo "CWD: $PWD"

