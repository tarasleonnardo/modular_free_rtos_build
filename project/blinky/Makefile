#############################################################
#############################################################
#                                                           #
#                  Target makefile                          #
#                                                           #
#############################################################
#############################################################
#                                                           #
#      The perposes of this fiel are:                       #
#       -define necessary options                           #
#       -include the makefiles of all modules               #
#       -link the target                                    #
#                                                           #
#############################################################
#############################################################

#############################################################
#############################################################
# Common toolchain settings

TOOLCHAIN_PREF = arm-none-eabi-

CC=$(TOOLCHAIN_PREF)gcc
LD=$(TOOLCHAIN_PREF)ld
AS=$(TOOLCHAIN_PREF)gcc
AR=$(TOOLCHAIN_PREF)ar
OBJCOPY=$(TOOLCHAIN_PREF)objcopy

# Add this potion to C_FLAGS to see additional info

C_FLAGS := -g -O0 -Wall -mthumb -mcpu=cortex-m3 -ffunction-sections -fdata-sections

L_FLAGS:= --gc-sections,--print-memory-usage
LD_LIB_PATH := /usr/arm-none-eabi/lib/thumb
A_FLAGS:= -x assembler

#############################################################
#                 Project variables                         #
#############################################################
NOECHO ?= @

PROJECT_NAME := led_switcher
PROJECT_DIRECTORY := $(shell pwd)/../..
PROJECT_LIB_DIR := $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)
PROJECT_BUILD_DIRECTORY := $(PROJECT_DIRECTORY)/build/$(PROJECT_NAME)

# This variable will be assigned in the included makefile
PROJECT_DEP_LIBS :=
# This variable will be assigned in the included makefile
PROJECT_LD_SCRIPT :=
#############################################################
#                  Target dependencies                      #
#############################################################

PROJECT_APP_INC := app/led_switcher/led_switcher_inc.mk
PROJECT_ARCH_INC := arch/ARM_CM3/ARM_CM3_inc.mk
PROJECT_KERNEL_INC := kernel/FreeRTOS/FreeRTOS_inc.mk
PROJECT_DRIVERS_INC := drivers/STM32L1xx_STD_PERIPH/led_driver/led_driver_inc.mk
PROJECT_PLATFORM_INC := platform/STM32L152/STM32L152/STM32L152_inc.mk

PROJECT_APP_BLD := app/led_switcher/led_switcher_bld.mk
PROJECT_ARCH_BLD := arch/ARM_CM3/ARM_CM3_bld.mk
PROJECT_KERNEL_BLD := kernel/FreeRTOS/FreeRTOS_bld.mk
PROJECT_PLATFORM_BLD := platform/STM32L152/STM32L152/STM32L152_bld.mk
PROJECT_DRIVERS_BLD := drivers/STM32L1xx_STD_PERIPH/led_driver/led_driver_bld.mk

#############################################################

PROJECT_PREREQUISITIES:= $(notdir $(PROJECT_APP_BLD))
PROJECT_PREREQUISITIES+= $(notdir $(PROJECT_ARCH_BLD))
PROJECT_PREREQUISITIES+= $(notdir $(PROJECT_KERNEL_BLD))
PROJECT_PREREQUISITIES+= $(notdir $(PROJECT_PLATFORM_BLD))
PROJECT_PREREQUISITIES+= $(notdir $(PROJECT_DRIVERS_BLD))

#############################################################
#            Include dependencies inc                       #
#############################################################

include $(PROJECT_DIRECTORY)/$(PROJECT_APP_INC)
include $(PROJECT_DIRECTORY)/$(PROJECT_ARCH_INC)
include $(PROJECT_DIRECTORY)/$(PROJECT_KERNEL_INC)
include $(PROJECT_DIRECTORY)/$(PROJECT_PLATFORM_INC)
include $(PROJECT_DIRECTORY)/$(PROJECT_DRIVERS_INC)

#############################################################

all:$(PROJECT_PREREQUISITIES)
	$(NOECHO) echo "Prerequisities: $(PROJECT_PREREQUISITIES)"
	$(NOECHO) echo "Libs: $(PROJECT_DEP_LIBS)"
	$(NOECHO) echo "LD script $(PROJECT_LD_SCRIPT)"
	$(NOECHO) echo "Linking the executable $(PROJECT_NAME).elf..."
	$(NOECHO) -@mkdir $(PROJECT_BUILD_DIRECTORY) -p $(SUPPRESS_ERRORS)
	$(NOECHO) cd $(PROJECT_BUILD_DIRECTORY) && \
	          $(CC) -Wl,$(L_FLAGS) -T$(PROJECT_LD_SCRIPT) -o $(PROJECT_NAME).elf -Wl,--start-group $(addprefix $(PROJECT_LIB_DIR)/,$(PROJECT_DEP_LIBS)) -lc -Wl,--end-group $(addprefix -L,$(LD_LIB_PATH)) && \
	          echo "Creating $(PROJECT_APP).hex ..." && \
	          $(OBJCOPY) -O ihex $(PROJECT_APP).elf $(PROJECT_APP).hex && \
	          echo Success.

#############################################################

clean:
	$(NOECHO)echo Cleaning build directory...
	$(NOECHO)-rm -r $(PROJECT_BUILD_DIRECTORY)

rebuild: clean all

.PHONY: all clean rebuild $(PROJECT_PREREQUISITIES)

#############################################################
#           Include dependencies targets                    #
#############################################################

include $(PROJECT_DIRECTORY)/$(PROJECT_APP_BLD)
#include $(PROJECT_DIRECTORY)/$(PROJECT_ARCH_BLD)
include $(PROJECT_DIRECTORY)/$(PROJECT_KERNEL_BLD)
include $(PROJECT_DIRECTORY)/$(PROJECT_PLATFORM_BLD)
include $(PROJECT_DIRECTORY)/$(PROJECT_DRIVERS_BLD)
