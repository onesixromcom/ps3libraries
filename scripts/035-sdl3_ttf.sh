#!/usr/bin/env bash
set -eo pipefail
# SDL3_ttf by 16rom.com

SDL3_TTF="SDL3_ttf-3.2.2"
## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_TTF}.tar.gz

## Copy make file.
if [ ! -f "$PS3DEV/share/ps3dev.cmake" ]; then
    mkdir -p "$PS3DEV/share"
    cp ../depends/ps3dev.cmake  "$PS3DEV/share/ps3dev.cmake"
fi

## Unpack the source code.
rm -Rf ${SDL3_TTF}
mkdir ${SDL3_TTF}
echo "Unpacking ${SDL3_TTF}"
extract ../archives/${SDL3_TTF}.tar.gz --strip-components=1 --directory=${SDL3_TTF}
cd ${SDL3_TTF}

## Patch the source code.
echo "Patching ${SDL3_TTF} for compatibility..."
cat ../../patches/SDL3_ttf-1.patch | patch -p1

# Download vendored libs
./external/download.sh

mkdir -p build-ppc
cd build-ppc

cmake -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake" -DCMAKE_BUILD_TYPE=Release  ..
cmake --build . 
cmake --install .
