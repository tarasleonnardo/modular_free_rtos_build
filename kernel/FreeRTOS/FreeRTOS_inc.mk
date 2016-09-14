##############################################################
#   Describes include directories and files of the module    #
##############################################################



FreeRTOS_INCLUDE_DIRS := -I$(PROJECT_DIRECTORY)/kernel/FreeRTOS \
                         -I$(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include \
                         -I$(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)

FreeRTOS_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)*.h)
                         
FreeRTOS_SRC := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/*.c)
FreeRTOS_SRC += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(TARGET_ARCH)/*.c)
FreeRTOS_SRC += $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/MemMang/heap_2.c
