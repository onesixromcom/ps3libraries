#
# CMake platform file for PS3 PPC processor
#

cmake_minimum_required(VERSION 3.0...3.12)

include(${CMAKE_CURRENT_LIST_DIR}/ps3dev.cmake)

set(CMAKE_INSTALL_PREFIX ${PORTLIBS} CACHE PATH "install path")

add_definitions(-DPS3)
set(PS3                 TRUE)

set(SDL_TESTS          FALSE)
set(SDL_EXAMPLES       FALSE)
set(SDL_TEST_LIBRARY   FALSE)
set(SDL_STATIC            ON)

set(SDL_GPU              OFF)
set(SDL_CAMERA           OFF)
set(SDL_HAPTIC           OFF)
set(SDL_HIDAPI           OFF)
set(SDL_POWER            OFF)
set(SDL_SENSOR           OFF)
set(SDL_DIALOG           OFF)
set(SDL_DISKAUDIO        OFF)
set(SDL_DUMMYAUDIO       OFF)
set(SDL_DUMMYCAMERA      OFF)
set(SDL_DUMMYVIDEO       OFF)
set(SDL_OFFSCREEN        OFF)
set(SDL_RENDER_GPU       OFF)
set(SDL_TRAY             OFF)
set(SDL_VIRTUAL_JOYSTICK OFF)
