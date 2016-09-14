##############################################################
#   Describes include directories and files of the module    #
##############################################################

ARM_CM3_INCLUDE_DIRS := -I$(PROJECT_DIRECTORY)/arch/ARM_CM3/inc

ARM_CM3_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/arch/ARM_CM3/inc/*.h)

ARM_CM3_SRC := $(wildcard $(PROJECT_DIRECTORY)/arch/ARM_CM3/src/*.c)
