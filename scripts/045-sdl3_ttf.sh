#!/bin/sh -e
# sdl3_ttf.sh by 16rom.com

BUILD_NAME="SDL3_ttf"
BUILD_DIR="build-ppc"

# Download if it's not there.
if [ ! -d "$BUILD_NAME" ]; then
	## Download the source code.
	wget https://github.com/libsdl-org/SDL_ttf/releases/download/release-3.2.2/SDL3_ttf-3.2.2.tar.gz
	## Unpack the source code.
	rm -Rf "$BUILD_NAME"
	mkdir "$BUILD_NAME" && tar --strip-components=1 --directory="$BUILD_NAME" -xvzf SDL3_ttf-3.2.2.tar.gz
	cd "$BUILD_NAME"
	## Patch the source code.
	cat ../../patches/SDL3_ttf-1.patch | patch -p1

	# Download vendored libs
	./external/download.sh
else
	cd "$BUILD_NAME"
fi

# Create the build directory.
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
echo "Building for PPC..."

cmake -Wno-dev -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake"  -DCMAKE_INSTALL_PREFIX="$PS3DEV/portlibs/ppu" -DCMAKE_PREFIX_PATH="$PS3DEV/portlibs/ppu" -DBUILD_SHARED_LIBS=OFF -DSDLTTF_VENDORED=ON -DSDLTTF_HARFBUZZ=OFF -DSDLTTF_SAMPLES=OFF ..
cmake --build . 
cmake --install .
