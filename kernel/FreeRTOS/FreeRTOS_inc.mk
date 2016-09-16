##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############

##########   FreeRTOS files and dirs              ############

FreeRTOS_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/kernel/FreeRTOS \
                         $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include \
                         $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)

FreeRTOS_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)*.h)
                         
FreeRTOS_SRC := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/*.c)
FreeRTOS_SRC += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)/*.c)
FreeRTOS_SRC += $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/MemMang/heap_2.c

FreeRTOS_SRC_C := $(notdir $(FreeRTOS_SRC))
FreeRTOS_OBJ := $(FreeRTOS_SRC_C:.c=.o)

FreeRTOS_LIB_NAME := FreeRTOS.a
