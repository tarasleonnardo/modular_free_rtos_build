cmake_minimum_required(VERSION 3.5.1)


GET_MODULE_NAME_MACRO(CURRENT_MODULE_NAME)
set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}
    ${CURRENT_DIR}/Source/include
    ${CURRENT_DIR}/Source/portable/GCC/ARM_CM3
   )

set(CURRENT_MODULE_SRC
    ${CURRENT_DIR}/Source/queue.c
    ${CURRENT_DIR}/Source/tasks.c
    ${CURRENT_DIR}/Source/timers.c
    ${CURRENT_DIR}/Source/list.c
    ${CURRENT_DIR}/Source/portable/MemMang/heap_2.c
    ${CURRENT_DIR}/Source/portable/GCC/ARM_CM3/port.c
   )

####################################################################################
# Create module
CREATE_FULL_MODULE()
