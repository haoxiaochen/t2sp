#!/bin/bash

wget -c https://github.com/git-lfs/git-lfs/releases/download/v3.1.4/git-lfs-linux-amd64-v3.1.4.tar.gz
mkdir git-lfs
tar -xvf git-lfs-linux-amd64-v3.1.4.tar.gz -C git-lfs > /dev/null
cd git-lfs
sed -i "4c prefix=$(pwd)" install.sh
sed -i "22c git-lfs install --local" install.sh
./install.sh
cd ..
