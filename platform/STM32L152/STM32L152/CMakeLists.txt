cmake_minimum_required(VERSION 3.5.1)


GET_BIN_DIR_PATH(app/blinky BIN_DIR)
add_subdirectory(${BASE_DIR}/app/blinky ${BIN_DIR})

