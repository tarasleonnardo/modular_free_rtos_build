cmake_minimum_required(VERSION 3.5.1)

set(CURRENT_MODULE_DEPENDENCIES )

set(CURRENT_MODULE_INC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/include
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/GCC/ARM_CM3
   )

set(CURRENT_MODULE_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/tasks.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/timers.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/MemMang/heap_2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/GCC/ARM_CM3/port.c
   )

####################################################################################
# Create module
CREATE_FULL_MODULE()
