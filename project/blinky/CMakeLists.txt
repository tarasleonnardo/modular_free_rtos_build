cmake_minimum_required(VERSION 3.5.1)

# Toolchain settings
include (CMakeForceCompiler)

set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../..)

set(TOOLCHAIN_DIR "usr/arm-none-eabi/bin")
set(TOOLCHAIN_PREF arm-none-eabi-)

CMAKE_FORCE_C_COMPILER  (${TOOLCHAIN_PREF}gcc GNU)
CMAKE_FORCE_CXX_COMPILER(${TOOLCHAIN_PREF}g++ GNU)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREF}as)

set(CMAKE_C_FLAGS_GLOBAL "-g -O0 -Wall -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections")
set(CMAKE_C_LINK_FLAGS_GLOBAL "-Wl,--print-memory-usage,--gc-sections")
set(CMAKE_LINK_LIBRARIES_GLOBAL "-lc")

set(CMAKE_C_LINK_FLAGS ${CMAKE_LINK_FLAGS_GLOBAL})
set(CMAKE_C_FLAGS ${CMAKE_C_LINK_FLAGS_GLOBAL})

# Project settings
set(PRJ_NAME blinky_prj)

project(PRJ_NAME)

# Check application name
if(NOT DEFINED APP_NAME)
    set(APP_NAME blinky_app)
endif()

# The base directory

include("${BASE_DIR}/cmake/macro.cmake")

# Modules list
set(MODULES
    app/blinky
    kernel/FreeRTOS
    platform/STM32L152/STM32L152
   )

# Add linker script to the linker flags
set(LINKER_SCRIPT "${BASE_DIR}/platform/STM32L152/STM32L152/ld/STM32L152XE_FLASH.ld")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${CMAKE_LINK_LIBRARIES_GLOBAL} -T${LINKER_SCRIPT}")

# Add the blank executable
add_executable(${APP_NAME}.elf blank.c)

set_target_properties( ${CURRENT_MODULE_NAME} PROPERTIES COMPILE_FLAGS
                      "${CMAKE_C_FLAGS_GLOBAL}")

message("************** Start ${APP_NAME}.elf")

# Add the dependencies
ADD_TARGET_DEPS_MACRO(${APP_NAME}.elf ${MODULES})


foreach(module ${MODULES})
    string(REPLACE "/" "_" TMP_TARGET ${module})
    message("Linking ${APP_NAME}.elf with ${TMP_TARGET}")
    target_link_libraries(${APP_NAME}.elf ${TMP_TARGET})
endforeach(module ${MODULES})

message("************** The end ${APP_NAME}.elf")

