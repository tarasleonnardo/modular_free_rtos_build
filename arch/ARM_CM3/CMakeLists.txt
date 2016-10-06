cmake_minimum_required(VERSION 3.5.1)

set(CURRENT_MODULE_NAME arch_ARM_CM3)
set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CURRENT_MODULE_DEPENDENCIES
    
   )

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}/inc
   )

set(CURRENT_MODULE_SRC
    ${CURRENT_DIR}/blank.c
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


# Add dependencies if exist
if(CURRENT_MODULE_DEPENDENCIES)
ADD_TARGET_DEPS_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_DEPENDENCIES})
endif(CURRENT_MODULE_DEPENDENCIES)

message("************** The end ${CURRENT_MODULE_NAME}")

                                                             

