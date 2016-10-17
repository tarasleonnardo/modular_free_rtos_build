cmake_minimum_required(VERSION 3.5.1)

GET_MODULE_NAME_MACRO(CURRENT_MODULE_NAME)

set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CURRENT_MODULE_DEPENDENCIES
    kernel/FreeRTOS
    platform/stm32/STM32L1xx/STM32L152
   )

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}
   )

set(CURRENT_MODULE_SRC
    ${CURRENT_DIR}/main.c
   )


####################################################################################
# Create module
CREATE_FULL_MODULE()
