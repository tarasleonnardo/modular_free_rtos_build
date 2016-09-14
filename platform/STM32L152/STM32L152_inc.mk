##############################################################
#   Describes include directories and files of the module    #
##############################################################

# Include dependencies
STM32L152_DEP_ARCH := ARM_CM3

include $(PROJECT_DIRECTORY)/arch/$(STM32L152_DEP_ARCH)/$(STM32L152_DEP_ARCH)_inc.mk


STM32L152_INCLUDE_DIRS := -I$(PROJECT_DIRECTORY)/platform/STM32L152/inc \
                           $($(STM32L152_DEP_ARCH)_INCLUDE_DIRS)

STM32L152_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/inc/*.h)
                         
STM32L152_SRC := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/src/*.c)

STM32L152_SRC_ASM :=  $(PROJECT_DIRECTORY)/platform/STM32L152/startup_stm32l1xx_md.s.txt

STM32L152_LD_SCRIPT := $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152XE_FLASH.ld