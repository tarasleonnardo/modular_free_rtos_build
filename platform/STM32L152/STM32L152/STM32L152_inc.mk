##############################################################
#   Describes include directories and files of the module    #
##############################################################

# Include dependencies

STM32L152_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/inc \
                          $($(STM32L152_DEP_ARCH)_INCLUDE_DIRS)

STM32L152_LIB_NAME := libstm32l152.a

PROJECT_LD_SCRIPT = $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/ld/STM32L152XE_FLASH.ld
PROJECT_DEP_LIBS += $(STM32L152_LIB_NAME)