##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############

##########   FreeRTOS files and dirs              ############

FreeRTOS_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/kernel/FreeRTOS \
                         $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include

ifdef PROJECT_ARCH
FreeRTOS_INCLUDE_DIRS += $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(PROJECT_ARCH)
endif

FreeRTOS_LIB_NAME := FreeRTOS.a
