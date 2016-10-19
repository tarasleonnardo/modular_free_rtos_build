cmake_minimum_required(VERSION 3.5.1)

### Template linker srcipt file
set(STARTUP_TEMPLATE "${BASE_DIR}/platform/stm32/common/startup_template/startup_template.S")

set(STARTUP_FILE_OUT ${CMAKE_CURRENT_SOURCE_DIR}/startup.S)

configure_file(${STARTUP_TEMPLATE} ${STARTUP_FILE_OUT})
