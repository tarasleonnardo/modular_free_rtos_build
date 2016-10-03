cmake_minimum_required(VERSION 3.5.1)

# Toolchain settings
include (CMakeForceCompiler)

set(TOOLCHAIN_DIR "usr/arm-none-eabi/bin")
set(TOOLCHAIN_PREF arm-none-eabi-)

CMAKE_FORCE_C_COMPILER  (${TOOLCHAIN_PREF}gcc GNU)
CMAKE_FORCE_CXX_COMPILER(${TOOLCHAIN_PREF}g++ GNU)

set(CMAKE_C_FLAGS "-std=c99 -g -O0 -Wall -mthumb -mcpu=cortex-m3 -ffunction-sections -fdata-sections")
set(CMAKE_C_LINK_FLAGS "-Wl,--print-memory-usage,--gc-sections,-nostdlib -T ${LINKER_SCRIPT}")


# Project settings
set(PRJ_NAME blinky_prj)

project(PRJ_NAME)

# Check application name
if(NOT DEFINED APP_NAME)
    set(APP_NAME blinky_app)
endif()

# The base directory

set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../..)

include("${BASE_DIR}/cmake/macro.cmake")

# Modules list
set(MODULES
    app/blinky
    kernel/FreeRTOS
    platform/STM32L152/STM32L152
   )

# Add the blank executable
add_executable(${APP_NAME} blank.c)

# Add the dependencies
ADD_TARGET_DEPS_MACRO(${APP_NAME} ${MODULES})
