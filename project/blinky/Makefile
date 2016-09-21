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

# Hide local symbols
ifdef VIS_HIDDEN
C_FLAGS += -fvisibility=hidden
endif


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

TARGET_NAME := blinky

TARGET_APP := blinky

TARGET_ARCH := ARM_CM3

TARGET_KERNEL := FreeRTOS

TARGET_PLATFORM := STM32L152

TARGET_SUB_PLATFORM := STM32L152

#############################################################

PROJECT_DIRECTORY := $(shell pwd)/../..
PROJECT_LIB_DIR := $(PROJECT_DIRECTORY)/lib/$(TARGET_NAME)


TARGET_PREREQUISITIES:= $(if TARGET_APP,application)
TARGET_PREREQUISITIES+= $(if TARGET_KERNEL,kernel)
TARGET_PREREQUISITIES+= $(if TARGET_PLATFORM,platform)

#############################################################
#                 Project variables                         #
#############################################################

# Directory for temporal files and executable

PROJECT_BUILD_DIRECTORY := $(PROJECT_DIRECTORY)/build/$(TARGET_NAME)

#############################################################
#            Include dependencies inc                       #
#############################################################

ifdef TARGET_APP
include $(PROJECT_DIRECTORY)/apps/$(TARGET_APP)/$(TARGET_APP)_inc.mk
endif

ifdef TARGET_KERNEL
include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL)_inc.mk
endif

ifdef TARGET_PLATFORM
ifdef TARGET_SUB_PLATFORM
include $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$(TARGET_SUB_PLATFORM)_inc.mk
endif
endif

#############################################################

TARGET_DEP_LIBS := $($(TARGET_APP)_LIB_NAME) $($(TARGET_KERNEL)_LIB_NAME) $($(TARGET_SUB_PLATFORM)_LIB_NAME)
TARGET_LD_SCRIPT := $(if TARGET_SUB_PLATFORM,$(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$($(TARGET_SUB_PLATFORM)_LD_SCRIPT))


all: $(TARGET_PREREQUISITIES)
	$(NOECHO) echo "Lib dir: $(PROJECT_LIB_DIR)"
	$(NOECHO) echo "Libraries $(TARGET_DEP_LIBS)"
	$(NOECHO) echo "Linking the executable $(TARGET_NAME).elf..."
	$(NOECHO) -@mkdir $(PROJECT_BUILD_DIRECTORY) -p $(SUPPRESS_ERRORS)
	$(NOECHO) cd $(PROJECT_BUILD_DIRECTORY) && \
	          $(CC) -Wl,$(L_FLAGS) -T$(TARGET_LD_SCRIPT) -o $(TARGET_NAME).elf -Wl,--start-group $(addprefix $(PROJECT_LIB_DIR)/,$(TARGET_DEP_LIBS)) -lc -Wl,--end-group $(addprefix -L,$(LD_LIB_PATH)) && \
	          echo "Creating $(TARGET_APP).hex ..." && \
	          $(OBJCOPY) -O ihex $(TARGET_APP).elf $(TARGET_APP).hex && \
	          echo Success.

#############################################################

clean:
	$(NOECHO)echo Cleaning build directory...
	$(NOECHO)-rm -r $(PROJECT_BUILD_DIRECTORY)

rebuild: clean all

.PHONY: all clean rebuild $(TARGET_PREREQUISITIES)





#############################################################
#           Include dependencies targets                    #
#############################################################

ifdef TARGET_KERNEL
include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL)_bld.mk
endif

ifdef TARGET_APP
include $(PROJECT_DIRECTORY)/apps/$(TARGET_APP)/$(TARGET_APP)_bld.mk
endif

ifdef TARGET_PLATFORM
ifdef TARGET_SUB_PLATFORM
include $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$(TARGET_SUB_PLATFORM)_bld.mk
endif
endif
