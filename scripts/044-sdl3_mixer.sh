#!/bin/sh -e
# sdl3_mixer.sh by 16rom.com

BUILD_NAME="SDL3_mixer"
BUILD_DIR="build-ppc"

# Download if it's not there.
if [ ! -d "$BUILD_NAME" ]; then
    # Download the source code.
    wget https://github.com/libsdl-org/SDL_mixer/releases/download/release-3.2.0/SDL3_mixer-3.2.0.tar.gz
    # Unpack the source code.
    rm -Rf "$BUILD_NAME"
    mkdir "$BUILD_NAME" && tar --strip-components=1 --directory="$BUILD_NAME" -xvzf SDL3_mixer-3.2.0.tar.gz
fi

# Create the build directory.
cd "$BUILD_NAME"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
echo "Building for PPC..."

#cmake -Wno-dev -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake"  -DCMAKE_INSTALL_PREFIX="$PS3DEV/portlibs/ppu" -DCMAKE_PREFIX_PATH="$PS3DEV/portlibs/ppu" -DBUILD_SHARED_LIBS=OFF -DSDLMIXER_TESTS=OFF -DSDLMIXER_EXAMPLES=OFF -DSDL_STATIC=ON  -DSDLMIXER_OPUS=OFF -DSDLMIXER_VORBIS_VORBISFILE=OFF -DSDLMIXER_WAVPACK=OFF -DSDLMIXER_OGG=OFF -DSDLMIXER_FLAC=OFF -DSDLMIXER_MP3_MPG123=OFF -DSDLMIXER_GME=OFF -DSDLMIXER_MOD_XMP=OFF -DSDLMIXER_MIDI_TIMIDITY=OFF ..
cmake -Wno-dev -DCMAKE_TOOLCHAIN_FILE="../../depends/ps3build.cmake" -DCMAKE_BUILD_TYPE=Release ..
cmake --build . 
cmake --install .
