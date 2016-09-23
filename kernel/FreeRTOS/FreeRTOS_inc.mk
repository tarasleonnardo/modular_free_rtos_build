##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############

##########   FreeRTOS files and dirs              ############

FreeRTOS_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/kernel/FreeRTOS \
                         $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include \
                         $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/ARM_CM3

FreeRTOS_LIB_NAME := FreeRTOS.a

PROJECT_DEP_LIBS += $(FreeRTOS_LIB_NAME)

