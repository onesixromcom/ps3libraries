#
# CMake platform file for PS3 PPC processor
#

cmake_minimum_required(VERSION 3.0...3.12)

if(DEFINED ENV{PS3DEV})
    set(PS3DEV $ENV{PS3DEV})
else()
    message(FATAL_ERROR "The environment variable PS3DEV needs to be defined.")
endif()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR powerpc64)

set(CMAKE_C_COMPILER powerpc64-ps3-elf-gcc)
set(CMAKE_CXX_COMPILER powerpc64-ps3-elf-g++)

set(LIBPSL1GHT_INC "-I${PS3DEV}/ppu/include -I${PS3DEV}/ppu/include/simdmath")
set(LIBPSL1GHT_LIB "-L${PS3DEV}/ppu/lib -L${PS3DEV}/ppu/ppu/lib")
set(PORTLIBS "${PS3DEV}/portlibs/ppu")

set(PPC_MACHDEP "-mhard-float -fmodulo-sched -ffunction-sections -fdata-sections")
set(PPC_CFLAGS "-O2 -Wall -mcpu=cell ${PPC_MACHDEP} ${LIBPSL1GHT_INC}" )
set(PPC_LDFLAGS "${LIBPSL1GHT_INC} -Wl,-zmax-page-size=128 -Wl,--gc-sections")
set(PPC_LIBS "-lgcm_sys -lrsx -lsysutil -lio -lcairo -lm -lfreetype -lz -lpixman-1 -lrt -llv2")

set(CMAKE_C_FLAGS_INIT ${PPC_CFLAGS})
set(CMAKE_CXX_FLAGS_INIT ${PPC_CFLAGS})
set(CMAKE_EXE_LINKER_FLAGS_INIT ${PPC_LDFLAGS})
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${PPC_LIBS}")

set(CMAKE_PREFIX_PATH ${PORTLIBS})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS TRUE)

add_compile_definitions(PS3 __PS3__)
set(PS3 1)

# Build PS3 SELF file
function(ps3_build_self target)
    set(ELF_FILE $<TARGET_FILE:${target}>)
    set(STRIPPED_ELF ${ELF_FILE}.stripped.elf)
    set(SELF_FILE ${ELF_FILE}.self)
    set(FSELF_FILE ${ELF_FILE}.fake.self)

    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND echo "Running PS3 post-build steps..."

        # 1. Fix OPD relocations FIRST, before anything else
        COMMAND ${PS3DEV}/bin/sprxlinker ${ELF_FILE}

        # 2. Strip AFTER sprxlinker, preserve OPD with -R flag
        COMMAND ${PS3DEV}/ppu/bin/powerpc64-ps3-elf-strip
            --strip-debug
            ${ELF_FILE}
            -o ${STRIPPED_ELF}

        # 3. Package the STRIPPED elf into SELF
        COMMAND ${PS3DEV}/bin/make_self ${STRIPPED_ELF} ${SELF_FILE}
        COMMAND ${PS3DEV}/bin/fself ${STRIPPED_ELF} ${FSELF_FILE}

        COMMAND echo "Done: ${SELF_FILE}"
    )
endfunction()
