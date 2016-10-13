cmake_minimum_required(VERSION 3.5.1)

### Toolchain settings
include (CMakeForceCompiler)

get_filename_component(BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../.." ABSOLUTE) 

set(TOOLCHAIN_DIR "usr/arm-none-eabi/bin")
set(TOOLCHAIN_PREF arm-none-eabi-)

CMAKE_FORCE_C_COMPILER  (${TOOLCHAIN_PREF}gcc GNU)
CMAKE_FORCE_CXX_COMPILER(${TOOLCHAIN_PREF}g++ GNU)

set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREF}gcc)

set(GLOBAL_BLANK_C ${CMAKE_CURRENT_SOURCE_DIR}/blank.c)

enable_language(ASM)

### The name of the project
set(PRJ_NAME blinky_prj)

### Application name
set(APP_NAME blinky_app)

### The name of the file to write the libraries list
set(LINK_LIBRARIES_LIST_FILE ${BASE_DIR}/build/${PRJ_NAME}/libs_list.txt)
file(REMOVE ${LINK_LIBRARIES_LIST_FILE})
### The name of the file to write the modules names
set(LINK_MODULES_LIST_FILE ${BASE_DIR}/build/${PRJ_NAME}/modules_list.txt)
file(REMOVE ${LINK_MODULES_LIST_FILE})

### Preprocessor definitions
add_definitions(-DUSE_STDPERIPH_DRIVER)
set(TARGET_ARCH cortex-m3)


### Compiler options
set(CMAKE_C_FLAGS_GLOBAL "-g -O0 -Wall -mcpu=${TARGET_ARCH} -mthumb -ffunction-sections -fdata-sections -nostdlib")

### Linker options
set(CMAKE_C_LINK_FLAGS_GLOBAL "-Wl,--print-memory-usage,--gc-sections")

### Libraries to link. Besides the libraries of the modules. e.g. -lgcc
set(CMAKE_LINK_LIBRARIES_GLOBAL "")

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

### Create project
project(PRJ_NAME )

set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS_GLOBAL})
set(CMAKE_C_LINK_FLAGS ${CMAKE_LINK_FLAGS_GLOBAL})

### Add the blank executable
add_executable(${APP_NAME}.elf ${GLOBAL_BLANK_C})

### Add the dependencies
ADD_TARGET_DEPS_MACRO(${APP_NAME}.elf ${MODULES})

### Add linker script to the linker flags
get_directory_property(LINKER_SCRIPT DIRECTORY ${BASE_DIR}/platform/stm32/STM32L1xx/STM32L152 DEFINITION LINKER_SCRIPT)

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
