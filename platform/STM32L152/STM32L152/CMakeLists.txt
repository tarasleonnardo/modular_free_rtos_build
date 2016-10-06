cmake_minimum_required(VERSION 3.5.1)

set(CURRENT_MODULE_NAME platform_STM32L152_STM32L152)
set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CURRENT_MODULE_COMPILE_FLAGS ${CMAKE_C_FLAGS_GLOBAL})
set(CURRENT_MODULE_COMPILE_FLAGS_AS "-x assembler")

set(CURRENT_MODULE_DEPENDENCIES
    arch/ARM_CM3
   )

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}/inc
   )

set(CURRENT_MODULE_SRC
    ${CURRENT_DIR}/src/system_stm32l1xx.c
   )

set(CURRENT_MODULE_ASM
    ${CURRENT_DIR}/startup_stm32l1xx_md.s.txt
   )

# message("${CURRENT_MODULE_NAME} dependencies: ${CURRENT_MODULE_DEPENDENCIES}")
message("************** Start ${CURRENT_MODULE_NAME}")
####################################################################################
# Create library
CREATE_MODULE_LIB_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_SRC})

# Set include directories for the target
target_include_directories(${CURRENT_MODULE_NAME} PUBLIC ${CURRENT_MODULE_INC})

# Set compile flags for the target
set_target_properties( ${CURRENT_MODULE_NAME} PROPERTIES COMPILE_FLAGS
                      "${CMAKE_C_FLAGS_GLOBAL} ${CURRENT_MODULE_COMPILE_FLAGS}")

# set_source_files_properties(${CURRENT_MODULE_ASM} PROPERTIES LANGUAGE ASM)
# add_library(startup_stm32l1xx ${CURRENT_MODULE_ASM})
# SET_TARGET_PROPERTIES(startup_stm32l1xx PROPERTIES LINKER_LANGUAGE ASM)
set(CMAKE_ASM_COMPILE_OBJECT "${CMAKE_ASM_COMPILER}
                              ${CURRENT_MODULE_COMPILE_FLAGS}
                              ${CURRENT_MODULE_COMPILE_FLAGS_AS}
                              -o startup_stm32l1xx.o ${CURRENT_MODULE_ASM}")

# set_target_properties( startup_stm32l1xx PROPERTIES COMPILE_FLAGS
#                      "${CMAKE_C_FLAGS_GLOBAL} ${CURRENT_MODULE_COMPILE_FLAGS_AS}")

# Add dependencies if exist
if(CURRENT_MODULE_DEPENDENCIES)
ADD_TARGET_DEPS_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_DEPENDENCIES})
endif(CURRENT_MODULE_DEPENDENCIES)

link_libraries(${CURRENT_MODULE_NAME}.a startup_stm32l1xx.o)

message("************** The end ${CURRENT_MODULE_NAME}")

