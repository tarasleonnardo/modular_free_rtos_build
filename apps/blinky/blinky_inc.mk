##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
BLINKY_ARCH := 
BLINKY_PLATFORM := STM32L152
BLINKY_SUB_PLATFORM := STM32L152
BLINKY_KERNEL := FreeRTOS
##########   FreeRTOS files and dirs              ############

blinky_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/apps/blinky

ifdef BLINKY_ARCH
include $(PROJECT_DIRECTORY)/arch/$(BLINKY_ARCH)/$(BLINKY_ARCH)_inc.mk
blinky_INCLUDE_DIRS += $($(BLINKY_ARCH)_INCLUDE_DIRS)
endif

ifdef BLINKY_PLATFORM
  ifdef BLINKY_SUB_PLATFORM
    include $(PROJECT_DIRECTORY)/platform/$(BLINKY_PLATFORM)/$(BLINKY_SUB_PLATFORM)/$(BLINKY_SUB_PLATFORM)_inc.mk
    blinky_INCLUDE_DIRS += $($(BLINKY_SUB_PLATFORM)_INCLUDE_DIRS)
  endif
endif

ifdef BLINKY_KERNEL
include $(PROJECT_DIRECTORY)/kernel/$(BLINKY_KERNEL)/$(BLINKY_KERNEL)_inc.mk
blinky_INCLUDE_DIRS += $($(BLINKY_KERNEL)_INCLUDE_DIRS)
endif


##############################################################
blinky_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/apps/blinky/*.h)

blinky_SRC := $(wildcard $(PROJECT_DIRECTORY)/apps/blinky/*.c)

blinky_SRC_C := $(notdir $(blinky_SRC))
blinky_OBJ := $(blinky_SRC_C:.c=.o)

blinky_LIB_NAME := blinky.a
