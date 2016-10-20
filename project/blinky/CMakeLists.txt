cmake_minimum_required(VERSION 3.5.1)

### The name of the project
set(PRJ_NAME blinky_prj)

### Application name
set(APP_NAME blinky_app)

### Create project
project(PRJ_NAME )

################################################################################################
### Project paths
### Root directory of the project
get_filename_component(BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../.." ABSOLUTE)
### Dirirecotry for building the projects.
### The project subdirectory will be created in this dir
set(BUILD_DIR ${BASE_DIR}/build)

### The directory for executable
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}/${PRJ_NAME}/exe)

### The liker script will be generated here and used to link the executable
set(LINKER_SCRIPT ${BUILD_DIR}/${PRJ_NAME}/ld/link.ld)

### Source files for the targets which do not have source.
set(GLOBAL_BLANK_C ${CMAKE_CURRENT_SOURCE_DIR}/blank.c)

### The name of the file to write the libraries list
set(LINK_LIBRARIES_LIST_FILE ${BASE_DIR}/build/${PRJ_NAME}/libs_list.txt)

### The name of the file to write the modules names
set(LINK_MODULES_LIST_FILE ${BASE_DIR}/build/${PRJ_NAME}/modules_list.txt)
################################################################################################
### Toolchain settings
set(TOOLCHAIN_DIR "usr/arm-none-eabi/bin")
set(TOOLCHAIN_PREF arm-none-eabi-)

include (CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER  (${TOOLCHAIN_PREF}gcc GNU)
CMAKE_FORCE_CXX_COMPILER(${TOOLCHAIN_PREF}g++ GNU)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREF}gcc)
enable_language(ASM)

### Preprocessor definitions
#set(USE_STD_PERIPH_GPIO YES)
#set(USE_STD_PERIPH_RCC YES)

### Preprocessor definitions
add_definitions( -DUSE_STDPERIPH_DRIVER 
                 -DUSE_STD_PERIPH_GPIO
                 -DUSE_STD_PERIPH_RCC
               )

set(TARGET_ARCH cortex-m3)
set(TARGET_FPU softvfp)

### Compiler options
set(CMAKE_C_FLAGS_GLOBAL "-g -O0 -Wall -mcpu=${TARGET_ARCH} -mthumb -ffunction-sections -fdata-sections -nostdlib")
### Linker options
set(CMAKE_C_LINK_FLAGS_GLOBAL "-Wl,--print-memory-usage,--gc-sections")
### Libraries to link. Besides the libraries of the modules. e.g. -lgcc
set(CMAKE_LINK_LIBRARIES_GLOBAL "")

################################################################################################
### The list of the application dependencies
set(MODULES
    app/blinky
    kernel/FreeRTOS
    platform/stm32/STM32L1xx/STM32L152
    drivers/STM32L1xx_Std_Periph
   )

################################################################################################
### Include macros definitions

include("${BASE_DIR}/cmake/macro.cmake")

################################################################################################
### All the work is done in cmake/macro.cmake file

MAKE_PROJECT()
