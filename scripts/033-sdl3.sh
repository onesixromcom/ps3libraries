#!/usr/bin/env bash
set -eo pipefail
# SDL3 by 16rom.com

SDL3="SDL3_3.4.14"
## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh sdl3.tar.gz

## Copy make file.
if [ ! -f "$PS3DEV/share/ps3dev.cmake" ]; then
    mkdir -p "$PS3DEV/share"
    cp ../depends/ps3dev.cmake  "$PS3DEV/share/ps3dev.cmake"
fi

## Unpack the source code.
rm -Rf ${SDL3}
mkdir ${SDL3}
echo "Unpacking ${SDL3}"
extract ../archives/sdl3.tar.gz --strip-components=1 --directory=${SDL3}
cd ${SDL3}
mkdir -p build-ppc
cd build-ppc

cmake -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake" -DCMAKE_BUILD_TYPE=Release  ..
cmake --build . 
cmake --install .
