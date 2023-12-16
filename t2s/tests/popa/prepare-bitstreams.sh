#!/bin/bash

# BASH_SOURCE is this script
if [ $0 != $BASH_SOURCE ]; then
    echo "Error: The script should be directly run, not sourced"
    return
fi

if [ "$1" != "a10" -a "$1" != "s10" ]; then
    echo "Usage: ./prepare-bitstreams.sh (a10|s10)"
    exit
else
    target=$1
fi

git lfs pull --include="t2s/tests/popa/gemm/bitstream/$target/a.aocx" --exclude=""
git lfs pull --include="t2s/tests/popa/conv/bitstream/$target/a.aocx" --exclude=""
git lfs pull --include="t2s/tests/popa/capsule/bitstream/$target/a.aocx" --exclude=""
git lfs pull --include="t2s/tests/popa/gemv/bitstream/$target/a.aocx" --exclude=""
git lfs pull --include="t2s/tests/popa/gbmv/bitstream/$target/a.aocx" --exclude=""
git lfs pull --include="t2s/tests/popa/pairhmm/bitstream/$target/a.aocx" --exclude=""
