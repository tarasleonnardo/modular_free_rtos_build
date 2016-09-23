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
# -fmem-report

C_FLAGS := -g -O0 -Wall -mthumb -mcpu=cortex-m3 -ffunction-sections -fdata-sections

L_FLAGS:= --gc-sections,--print-memory-usage
LD_LIB_PATH := /usr/arm-none-eabi/lib/thumb
A_FLAGS:= -x assembler

#############################################################
#############################################################

# Suppress printing of the shell commands errors
SUPPRESS_ERRORS ?= # > 2 > /dev/null
NOECHO ?= @

#############################################################
#                  Target dependencies                      # 
#############################################################

PROJECT_NAME := led_switcher

PROJECT_APP := led_switcher

PROJECT_ARCH := ARM_CM3

PROJECT_KERNEL := FreeRTOS

PROJECT_PLATFORM := STM32L152

PROJECT_SUB_PLATFORM := STM32L152

PROJECT_DRIVERS := STM32L1xx_STD_PERIPH

#############################################################

PROJECT_DIRECTORY := $(shell pwd)/../..
PROJECT_LIB_DIR := $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)


PROJECT_PREREQUISITIES:= $(if PROJECT_APP,application)
PROJECT_PREREQUISITIES+= $(if PROJECT_KERNEL,kernel)
PROJECT_PREREQUISITIES+= $(if PROJECT_PLATFORM,platform)
PROJECT_PREREQUISITIES+= $(if PROJECT_DRIVERS,drivers)

#############################################################
#                 Project variables                         #
#############################################################

# Directory for temporal files and executable

PROJECT_BUILD_DIRECTORY := $(PROJECT_DIRECTORY)/build/$(PROJECT_NAME)

#############################################################
#            Include dependencies inc                       #
#############################################################

ifdef PROJECT_APP
include $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/$(PROJECT_APP)_inc.mk
endif

ifdef PROJECT_KERNEL
include $(PROJECT_DIRECTORY)/kernel/$(PROJECT_KERNEL)/$(PROJECT_KERNEL)_inc.mk
endif

ifdef PROJECT_PLATFORM
ifdef PROJECT_SUB_PLATFORM
include $(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$(PROJECT_SUB_PLATFORM)_inc.mk
endif
endif

ifdef PROJECT_DRIVERS
include $(PROJECT_DIRECTORY)/drivers/$(PROJECT_DRIVERS)/$(PROJECT_DRIVERS)_inc.mk
endif

#############################################################

PROJECT_DEP_LIBS := $($(PROJECT_APP)_LIB_NAME) $($(PROJECT_KERNEL)_LIB_NAME) $($(PROJECT_SUB_PLATFORM)_LIB_NAME) $($(PROJECT_DRIVERS)_LIB_NAME)
PROJECT_LD_SCRIPT := $(if PROJECT_SUB_PLATFORM,$(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$($(PROJECT_SUB_PLATFORM)_LD_SCRIPT))


all: $(PROJECT_PREREQUISITIES)
	$(NOECHO) echo "Prerequisities:$(PROJECT_PREREQUISITIES)"
	$(NOECHO) echo "Lib dir: $(PROJECT_LIB_DIR)"
	$(NOECHO) echo "Libraries $(PROJECT_DEP_LIBS)"
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

ifdef PROJECT_KERNEL
include $(PROJECT_DIRECTORY)/kernel/$(PROJECT_KERNEL)/$(PROJECT_KERNEL)_bld.mk
endif

ifdef PROJECT_APP
include $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/$(PROJECT_APP)_bld.mk
endif

ifdef PROJECT_PLATFORM
ifdef PROJECT_SUB_PLATFORM
include $(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$(PROJECT_SUB_PLATFORM)_bld.mk
endif
endif

ifdef PROJECT_DRIVERS
include $(PROJECT_DIRECTORY)/drivers/$(PROJECT_DRIVERS)/$(PROJECT_DRIVERS)_bld.mk
endif
