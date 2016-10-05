cmake_minimum_required(VERSION 3.5.1)

add_library(platform_STM32L152_STM32L152 ${CMAKE_CURRENT_SOURCE_DIR}/src/system_stm32l1xx.c)
message("Hello from the platform CMakeLists.txt")
