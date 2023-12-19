./install-tools.sh
git checkout -f HEAD

# Compile
PATH+=:$(pwd)/install/bin
cd Halide
make -j
