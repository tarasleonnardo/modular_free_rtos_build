cmake_minimum_required(VERSION 3.5.1)


set(CURRENT_MODULE_NAME app_blinky)
set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CURRENT_MODULE_DEPENDENCIES
    kernel/FreeRTOS
   )

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}
   )

set(CURRENT_MODULE_SRC
    ${CURRENT_DIR}/main.c
   )

####################################################################################
# Create library
CREATE_MODULE_LIB_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_SRC})

message("Application include directory: ${CURRENT_MODULE_INC}")
target_include_directories(${CURRENT_MODULE_NAME} PUBLIC ${CURRENT_MODULE_INC})

# Add dependencies if exist
if(CURRENT_MODULE_DEPENDENCIES)
ADD_TARGET_DEPS_MACRO(${CURRENT_MODULE_NAME} ${CURRENT_MODULE_DEPENDENCIES})
endif(CURRENT_MODULE_DEPENDENCIES)

