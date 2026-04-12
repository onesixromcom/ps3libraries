#
# CMake platform file for PS3 PPC processor
#

cmake_minimum_required(VERSION 3.0...3.12)

INCLUDE(CMakeForceCompiler)

if(DEFINED ENV{PS3DEV})
    SET(PS3DEV $ENV{PS3DEV})
else()
    message(FATAL_ERROR "The environment variable PS3DEV needs to be defined.")
endif()

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_SYSTEM_PROCESSOR powerpc64)

SET(CMAKE_C_COMPILER powerpc64-ps3-elf-gcc)
SET(CMAKE_CXX_COMPILER powerpc64-ps3-elf-g++)

SET(CMAKE_C_FLAGS "-I$ENV{PS3DEV}/ppu/include -I$ENV{PS3DEV}/ppu/include/simdmath \
    -O2 -Wall -Wno-unused-function \
    -mcpu=cell -mhard-float \
    -ffunction-sections -fdata-sections \
    -DPS3 -D__PS3__" 
    CACHE STRING "" FORCE)

SET(PPC_LDFLAGS "-L$ENV{PS3DEV}/ppu/lib -L$ENV{PS3DEV}/ppu/ppu/lib -Wl,-zmax-page-size=128")

SET(CMAKE_PREFIX_PATH $ENV{PS3DEV}/portlibs/ppu/)

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET_PROPERTY(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS TRUE)

SET(CMAKE_C_FLAGS_INIT ${PPC_CFLAGS})
SET(CMAKE_CXX_FLAGS_INIT ${PPC_CFLAGS})
SET(CMAKE_EXE_LINKER_FLAGS_INIT ${PPC_LDFLAGS})

SET(C_FLAGS ${CMAKE_C_FLAGS} ${PPC_CFLAGS})

SET(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" FORCE)

SET(CMAKE_EXE_LINKER_FLAGS 
    "-L$ENV{PS3DEV}/ppu/lib \
     -Wl,-q \
     -Wl,--gc-sections \
     -Wl,-zmax-page-size=128"
    CACHE STRING "" FORCE)

add_compile_definitions(PS3 __PS3__)

SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-nostartfiles -Wl,-r -Wl,-d")
SET(PS3 1)
SET(PLATFORM_PS3 1)
