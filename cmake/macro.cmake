cmake_minimum_required(VERSION 3.5.1)

######################################################################################
### Macro to create bin directory path for the target
macro(GET_BIN_DIR_PATH_MACRO _TAR_NAME _NEW_BIN_PATH)

    set(_TAR_NAME ${ARGV0})
    set(_NEW_BIN_PATH ${ARGV})
    list(REMOVE_AT _NEW_BIN_PATH 0)
    
    set(${_NEW_BIN_PATH} "${BASE_DIR}/build/${PRJ_NAME}/${_TAR_NAME}")
endmacro(GET_BIN_DIR_PATH_MACRO _TAR_NAME _NEW_BIN_PATH)

######################################################################################
### Add dependencies of the target
macro(ADD_TARGET_DEPS_MACRO )

    set(_DEPS_LIST ${ARGV})
    set(_BASE_TARGET ${ARGV0})
    list(REMOVE_AT _DEPS_LIST 0)

    ### Build the dependencies
    foreach(module ${_DEPS_LIST})

        ### Generate the name of the library
        string(REPLACE "/" "_" TMP_TARGET ${module})

        ### Add every dependency to the list of libraries for the linker
#        file(APPEND ${LINK_LIBRARIES_LIST_FILE} "${TMP_TARGET};")

        if(NOT TARGET ${TMP_TARGET})
        ### If this target has not been created yet
 
            ### Get the bin directory path
            GET_BIN_DIR_PATH_MACRO(${module} BIN_DIR)
            ### Add target to build the library
            add_subdirectory(${BASE_DIR}/${module} ${BIN_DIR})
            
#            message("Binary directory of ${module} is ${BIN_DIR}")
         
            ### Add every dependency to the list of libraries for the linker
            message("Writing to file ${LINK_MODULES_LIST_FILE}")
            file(APPEND ${LINK_MODULES_LIST_FILE} "${TMP_TARGET};")
            message("Writing to file ${LINK_LIBRARIES_LIST_FILE}")
            file(APPEND ${LINK_LIBRARIES_LIST_FILE} "${BIN_DIR}/lib${TMP_TARGET}.a;")

            message("++ Add target: ${TMP_TARGET}")

        endif(NOT TARGET ${TMP_TARGET})
    
        if(TARGET ${TMP_TARGET})
        ### If target was created successfully - share include
        ### directories with the dependedt target

            get_target_property(TMP_PROP ${TMP_TARGET} INCLUDE_DIRECTORIES)
        
            if(TMP_PROP)
                target_include_directories(${_BASE_TARGET} PUBLIC ${TMP_PROP})
                message("<- Share inc dirs: ${_BASE_TARGET} <- ${TMP_TARGET}")
            endif(TMP_PROP)

        endif(TARGET ${TMP_TARGET})


    endforeach(module ${_DEPS_LIST})

endmacro(ADD_TARGET_DEPS_MACRO)

######################################################################################
### Create library for module if it does not exist
macro(CREATE_MODULE_LIB_MACRO)

    set(_LIB_SRC ${ARGV})
    set(_LIB_NAME ${ARGV0})
    list(REMOVE_AT _LIB_SRC 0)

    if(NOT _LIB_SRC)
    ### If module has no source files create it based on the blank file

        set(_LIB_SRC ${GLOBAL_BLANK_C})

    endif(NOT _LIB_SRC)

    if(NOT TARGET ${_LIB_NAME})
    ### If this target has not been created yet

        add_library(${_LIB_NAME} ${_LIB_SRC})

        ### Set include directories for the target
        target_include_directories(${CURRENT_MODULE_NAME} PUBLIC ${CURRENT_MODULE_INC})

        ### Set compile flags for the target.
        set_target_properties( ${CURRENT_MODULE_NAME} PROPERTIES COMPILE_FLAGS
                              "${CMAKE_C_FLAGS_GLOBAL} ${CURRENT_MODULE_COMPILE_FLAGS}")

    endif(NOT TARGET ${_LIB_NAME})

endmacro(CREATE_MODULE_LIB_MACRO)

######################################################################################
### Get current module name based on the directory name
macro(GET_MODULE_NAME_MACRO)

    set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

    string(REPLACE "${BASE_DIR}/" " " CURRENT_MODULE_NAME ${CURRENT_DIR})

    string(REPLACE "/" "_" CURRENT_MODULE_NAME ${CURRENT_MODULE_NAME})
    string(STRIP ${CURRENT_MODULE_NAME} CURRENT_MODULE_NAME)

endmacro(GET_MODULE_NAME_MACRO)

######################################################################################
### Create the libraru for current module and add all the dependencies
macro(CREATE_FULL_MODULE)

    ### Generate module name and dir
    GET_MODULE_NAME_MACRO(CURRENT_MODULE_NAME)

    set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

    message(******************************************************************************)
    message("Current module name: ${CURRENT_MODULE_NAME}, current dir: ${CURRENT_DIR}")

    ### Create library
    CREATE_MODULE_LIB_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_SRC})

    ### Add dependencies if exist
    if(CURRENT_MODULE_DEPENDENCIES)

        ADD_TARGET_DEPS_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_DEPENDENCIES})
    
    endif(CURRENT_MODULE_DEPENDENCIES)
   
    unset(CURRENT_MODULE_NAME)
    unset(CURRENT_DIR) 
endmacro(CREATE_FULL_MODULE)

######################################################################################
######################################################################################
### Macro for project building
macro(MAKE_PROJECT)

######################################################################################
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

set_target_properties( ${APP_NAME}.elf PROPERTIES
                       COMPILE_FLAGS ${CMAKE_C_FLAGS_GLOBAL})
######################################################################################
### Make the project dependent on the modules
file(READ ${LINK_MODULES_LIST_FILE} TMP_VAR)

list(REMOVE_DUPLICATES TMP_VAR)
message("*** Modules:")

foreach(module ${TMP_VAR})

    add_dependencies(${APP_NAME}.elf ${module})
    message("* ${module}")

endforeach(module ${MODULES})
######################################################################################
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
######################################################################################

endmacro(MAKE_PROJECT)

######################################################################################
