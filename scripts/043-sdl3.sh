#!/bin/sh -e
# sdl3.sh by 16rom.com

BUILD_NAME="SDL3"
BUILD_DIR="build-ppc"

# Copy make file.
if [ ! -f "$PS3DEV/share/ps3dev.cmake" ]; then
	mkdir -p "$PS3DEV/share"
	cp ../depends/ps3dev.cmake  "$PS3DEV/share/ps3dev.cmake"
fi

# Download if it's not there.
if [ ! -d "$BUILD_NAME" ]; then
	## Download the source code.
	wget https://github.com/onesixromcom/SDL/tarball/ps3 -O "$BUILD_NAME.tar.gz"
	## Unpack the source code.
	rm -Rf "$BUILD_NAME"
	mkdir "$BUILD_NAME" && tar --strip-components=1 --directory="$BUILD_NAME" -xvzf "$BUILD_NAME".tar.gz
fi

## Create the build directory.
cd "$BUILD_NAME"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
echo "Building for PPC..."

cmake -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake" -DCMAKE_BUILD_TYPE=Release  ..
cmake --build . 
cmake --install .
