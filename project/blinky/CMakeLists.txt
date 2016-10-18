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
set(LINKER_SCRIPT ${BUILD_DIR}/ld/link.ld)

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
add_definitions(-DUSE_STDPERIPH_DRIVER)

set(TARGET_ARCH cortex-m3)

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
    drivers/STM32L1xx_STD_PERIPH/STM32L1xx_Std_Periph
   )

################################################################################################
### Include macros definitions

include("${BASE_DIR}/cmake/macro.cmake")

################################################################################################
### All the work is done below

### Remove the files containing modules and deps lists
file(REMOVE ${LINK_LIBRARIES_LIST_FILE})
file(REMOVE ${LINK_MODULES_LIST_FILE})

### Configure the linker script
#configure_file(${LINKER_SCRIPT_TEMPLATE} ${LINKER_SCRIPT})
#include(${BASE_DIR}/platform/stm32/common/ldconf.cmake)

set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS_GLOBAL})
set(CMAKE_C_LINK_FLAGS ${CMAKE_LINK_FLAGS_GLOBAL})

### Add the blank executable
add_executable(${APP_NAME}.elf ${GLOBAL_BLANK_C})

### Add the dependencies
ADD_TARGET_DEPS_MACRO(${APP_NAME}.elf ${MODULES})

### Add linker script to the linker flags
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${CMAKE_LINK_LIBRARIES_GLOBAL} -T${LINKER_SCRIPT}")
message("--- Linker script: ${LINKER_SCRIPT}")

set_target_properties( ${CURRENT_MODULE_NAME} PROPERTIES
                       COMPILE_FLAGS ${CMAKE_C_FLAGS_GLOBAL})


################################################################################################
### Make the project dependent on the modules
file(READ ${LINK_MODULES_LIST_FILE} TMP_VAR)

list(REMOVE_DUPLICATES TMP_VAR)
message("*** Modules:")

foreach(module ${TMP_VAR})

    add_dependencies(${APP_NAME}.elf ${module})
    message("* ${module}")

endforeach(module ${MODULES})

################################################################################################
### Create the list of the modules libraries
file(READ ${LINK_LIBRARIES_LIST_FILE} TMP_VAR)

list(REMOVE_DUPLICATES TMP_VAR)
set(LIBS_LIST "-Wl,--start-group")

message("*** Link libraries:")
foreach(module ${TMP_VAR})

    set(LIBS_LIST " ${LIBS_LIST} ${module}")
    get_filename_component(TMP_FILENAME ${module} NAME)
    message("* ${TMP_FILENAME}")

endforeach(module ${MODULES})

set(LIBS_LIST " ${LIBS_LIST} -Wl,--end-group")

set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${LIBS_LIST}")
