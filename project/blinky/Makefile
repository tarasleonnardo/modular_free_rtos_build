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
LD=$(TOOLCHAIN_PREF)gcc
AS=$(TOOLCHAIN_PREF)gcc
AR=$(TOOLCHAIN_PREF)ar
OBJCOPY=$(TOOLCHAIN_PREF)objcopy

# Add this potion to C_FLAGS to see additional info
# -fmem-report

C_FLAGS:= -g -O0 -Wall -mthumb -mcpu=cortex-m3 -ffunction-sections -fdata-sections

L_FLAGS:= --gc-sections,--print-memory-usage
LD_LIB_PATH := /usr/arm-none-eabi/lib/thumb
A_FLAGS:= -x assembler

#############################################################
#############################################################

# Suppress printing of the shell commands errors
SUPPRESS_ERRORS ?= # > 2 > /dev/null
NOECHO ?= @

TARGET_NAME := blinky

TARGET_APP := blinky

TARGET_ARCH := ARM_CM3

TARGET_KERNEL := FreeRTOS

TARGET_PLATFORM := STM32L152
TARGET_SUB_PLATFORM := STM32L152

#############################################################
#                  Target variables                         # 
#############################################################

# Directory for temporal files and executable
PROJECT_DIRECTORY := $(shell pwd)/../..
TARGET_BUILD_DIRECTORY := $(PROJECT_DIRECTORY)/build/$(TARGET_NAME)


include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL)_inc.mk
include $(PROJECT_DIRECTORY)/arch/$(TARGET_ARCH)/$(TARGET_ARCH)_inc.mk
include $(PROJECT_DIRECTORY)/apps/$(TARGET_APP)/$(TARGET_APP)_inc.mk

TARGET_LIBS := #No libs by default

ifdef $(TARGET_APP)_LIB_NAME
TARGET_LIBS += $(TARGET_BUILD_DIRECTORY)/$(TARGET_APP)/$($(TARGET_APP)_LIB_NAME)
endif

ifdef $(TARGET_KERNEL)_LIB_NAME
TARGET_LIBS += $(TARGET_BUILD_DIRECTORY)/$(TARGET_KERNEL)/$($(TARGET_KERNEL)_LIB_NAME)
endif

ifdef $(TARGET_SUB_PLATFORM)_LIB_NAME
TARGET_LIBS += $(TARGET_BUILD_DIRECTORY)/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$($(TARGET_SUB_PLATFORM)_LIB_NAME)
endif

ifdef $(TARGET_SUB_PLATFORM)_LD_SCRIPT
LD_SCRIPT := $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/ld/$(STM32L152_LD_SCRIPT)
endif

ifdef $(TARGET_ARCH)_LIB_NAME
TARGET_LIBS += $(TARGET_BUILD_DIRECTORY)/$(TARGET_ARCH)/$($(TARGET_ARCH)_LIB_NAME)
endif

TARGET_PREREQUISITIES := TARGET_APP
TARGET_PREREQUISITIES += TARGET_KERNEL
TARGET_PREREQUISITIES += $(if TARGET_PLATFORM, $(if TARGET_SUB_PLATFORM, $(TARGET_SUB_PLATFORM)))
TARGET_PREREQUISITIES += TARGET_ARCH

#############################################################
all: $(TARGET_APP) $(TARGET_ARCH) $(TARGET_KERNEL) $(TARGET_SUB_PLATFORM)
	$(NOECHO) echo "TARGET_LIBS: $(TARGET_LIBS)"
	$(NOECHO) echo "Linking the executable..."
	$(NOECHO) -@mkdir $(TARGET_BUILD_DIRECTORY) -p $(SUPPRESS_ERRORS)
	$(NOECHO) cd $(TARGET_BUILD_DIRECTORY) && \
	          $(LD) -Wl,$(L_FLAGS) -T $(LD_SCRIPT) -o $(TARGET_APP).elf -Wl,--start-group $(TARGET_LIBS) -lc -Wl,--end-group -L $(LD_LIB_PATH) && \
	          echo "Creating $(TARGET_APP).hex ..." && \
	          $(OBJCOPY) -O ihex $(TARGET_APP).elf $(TARGET_APP).hex
	echo Success.
#############################################################
# Build kernel
$(TARGET_KERNEL): $($($(TARGET_KERNEL)_SRC)) $($(TARGET_KERNEL)_HEADERS)
	$(NOECHO) echo Build kernel
	$(NOECHO) mkdir $(TARGET_BUILD_DIRECTORY)/$(TARGET_KERNEL) -p
	$(NOECHO) cd $(TARGET_BUILD_DIRECTORY)/$(TARGET_KERNEL) && \
	          $(CC) -c $(C_FLAGS) $($(TARGET_KERNEL)_SRC) $(addprefix -I,$($(TARGET_KERNEL)_INCLUDE_DIRS)) && \
	          echo "Archiving $(TARGET_KERNEL).a" && \
	          $(AR) rcs $($(TARGET_KERNEL)_LIB_NAME) $($(TARGET_KERNEL)_OBJ)

#############################################################
# Build kernel
$(TARGET_APP): $($(TARGET_KERNEL)_SRC) $($(TARGET_APP)_HEADERS)
	$(NOECHO) echo Build architecture specific module
	$(NOECHO) mkdir $(TARGET_BUILD_DIRECTORY)/$(TARGET_APP) -p
	$(NOECHO) cd $(TARGET_BUILD_DIRECTORY)/$(TARGET_APP) && \
	          $(CC) -c $(C_FLAGS) $($(TARGET_APP)_SRC) $(addprefix -I,$($(TARGET_APP)_INCLUDE_DIRS)) && \
	          echo "Archiving $(TARGET_APP).a OBJ: $($(TARGET_APP)_OBJ)" && \
	          $(AR) rcs $($(TARGET_APP)_LIB_NAME) $($(TARGET_APP)_OBJ)

#############################################################


#############################################################
# Build platform
$(TARGET_SUB_PLATFORM): $($(TARGET_SUB_PLATFORM)_SRC) $($(TARGET_SUB_PLATFORM)_HEADERS)
	$(NOECHO) echo Build architecture specific module
	$(NOECHO) mkdir $(TARGET_BUILD_DIRECTORY)/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM) -p
	$(NOECHO) cd $(TARGET_BUILD_DIRECTORY)/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM) && \
	          $(CC) -c $(C_FLAGS) $($(TARGET_SUB_PLATFORM)_SRC) $(addprefix -I,$($(TARGET_SUB_PLATFORM)_INCLUDE_DIRS)) && \
	          $(CC) -c $(A_FLAGS) $(C_FLAGS) -o $(addsuffix .o, $(notdir $($(TARGET_SUB_PLATFORM)_SRC_ASM))) $($(TARGET_SUB_PLATFORM)_SRC_ASM) && \
	          echo "Archiving $(TARGET_SUB_PLATFORM).a" && \
	          $(AR) rcs $($(TARGET_SUB_PLATFORM)_LIB_NAME) $($(TARGET_SUB_PLATFORM)_OBJ) $(addsuffix .o, $(notdir $($(TARGET_SUB_PLATFORM)_SRC_ASM)))



#############################################################

#############################################################
clean:
	$(NOECHO)echo Cleaning build directory...
	$(NOECHO)-rm -r $(TARGET_BUILD_DIRECTORY)

rebuild: clean all

.PHONY: all clean rebuild $(TARGET_NAME) $(TARGET_APP) $(TARGET_ARCH) $(TARGET_KERNEL) $(TARGET_SUB_PLATFORM)

# Include target modules
#include $(PROJECT_DIRECTORY)/apps/$(TARGET_APP)/$(TARGET_APP).mk
#include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL).mk
#include $(PROJECT_DIRECTORY)/arch/$(TARGET_ARCH)/$(TARGET_ARCH).mk
#include $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$(TARGET_PLATFORM).mk

