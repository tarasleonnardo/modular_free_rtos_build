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
.PHONY: clean rebuild

.SILENT:
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
LD_SCRIPT_FILE:= STM32L152XE_FLASH.ld
LD_LIB_PATH := /usr/arm-none-eabi/lib/thumb
A_FLAGS:= -x assembler
#############################################################

# Suppress printing of the shell commands errors
SUPPRESS_ERRORS1 := > 2 > /dev/null

# The name of the executable. The extentions of .elf and hex
# will be added later
TARGET_NAME := blinky

# The target application from the 'apps' folder
TARGET_APP := blinky

# The target architecture from the 'arch' folder
TARGET_ARCH := ARM_CM3

# The target kernel from the 'kernel' folder
TARGET_KERNEL := FreeRTOS

# The target platform from the 'platform' folder
TARGET_PLATFORM := STM32L152

#############################################################
#                  Target variables                         # 
#############################################################

# The names of the target parts libraries
TARGET_LIBS_NAMES := # no libraries are available at first

# Directory for temporal files and executable
# The path is relative to the project directory
TARGET_DIRECTORY := $(shell pwd)
PROJECT_DIRECTORY := $(TARGET_DIRECTORY)/../..
TARGET_BUILD_DIRECTORY := $(PROJECT_DIRECTORY)/build/blinky

LD_SCRIPT := $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(LD_SCRIPT_FILE)

TARGET_LIBS := $(TARGET_BUILD_DIRECTORY)/$(TARGET_APP)/$(TARGET_APP).a \
               $(TARGET_BUILD_DIRECTORY)/$(TARGET_KERNEL)/$(TARGET_KERNEL).a \
               $(TARGET_BUILD_DIRECTORY)/$(TARGET_PLATFORM)/$(TARGET_PLATFORM).a \
#               $(TARGET_BUILD_DIRECTORY)/$(TARGET_ARCH)/$(TARGET_ARCH).a

#$(TARGET_APP).a $(TARGET_KERNEL).a $(TARGET_ARCH).a $(TARGET_PLATFORM).a
.PHONY: all
all: $(TARGET_LIBS)
	echo "Prerequesities: $(notdir $^)"
	echo "Linker script: $(LD_SCRIPT)"
	echo "Libraries:  $(TARGET_LIBS)"
	echo "Linking the executable..."
	-@mkdir $(TARGET_BUILD_DIRECTORY) -p $(SUPPRESS_ERRORS)
	cd $(TARGET_BUILD_DIRECTORY) && \
	$(LD) -Wl,$(L_FLAGS) -T $(LD_SCRIPT) -o $(TARGET_APP).elf -Wl,--start-group $(TARGET_LIBS) -lc -Wl,--end-group -L $(LD_LIB_PATH) && \
	echo "Creating $(TARGET_APP).hex ..." && \
	$(OBJCOPY) -O ihex $(TARGET_APP).elf $(TARGET_APP).hex
	echo Success.


clean:
	echo Deleting target build files...
	-rm -r $(TARGET_BUILD_DIRECTORY)

rebuild: clean $(TARGET_BUILD_DIRECTORY)/$(TARGET_APP).hex


# Include target modules
include $(PROJECT_DIRECTORY)/apps/$(TARGET_APP)/$(TARGET_APP).mk
include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL).mk
include $(PROJECT_DIRECTORY)/arch/$(TARGET_ARCH)/$(TARGET_ARCH).mk
include $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_PLATFORM).mk


