cmake_minimum_required(VERSION 3.5.1)

set(CURRENT_MODULE_DEPENDENCIES
    kernel/FreeRTOS
    platform/stm32/STM32L1xx/STM32L152
    drivers/STM32L1xx_Std_Periph
   )

set(CURRENT_MODULE_INC
    ${CMAKE_CURRENT_SOURCE_DIR}
   )

set(CURRENT_MODULE_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/main.c
   )


####################################################################################
# Create module
CREATE_FULL_MODULE()
