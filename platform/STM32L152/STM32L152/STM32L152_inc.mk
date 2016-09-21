##############################################################
#   Describes include directories and files of the module    #
##############################################################

# Include dependencies

STM32L152_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/inc \
                          $($(STM32L152_DEP_ARCH)_INCLUDE_DIRS)

STM32L152_LD_SCRIPT = ld/STM32L152XE_FLASH.ld

STM32L152_LIB_NAME := STM32L152.a