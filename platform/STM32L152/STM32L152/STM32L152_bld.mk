##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/kernel/$(TARGET_KERNEL)/$(TARGET_KERNEL)_inc.mk
include $(PROJECT_DIRECTORY)/arch/$(TARGET_ARCH)/$(TARGET_ARCH)_inc.mk
include $(PROJECT_DIRECTORY)/platform/$(TARGET_PLATFORM)/$(TARGET_SUB_PLATFORM)/$(TARGET_SUB_PLATFORM)_inc.mk

##########   Files and dirs              ############
STM32L152_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/STM32L152

STM32L152_LOCAL_INCLUDE_DIRS := $(STM32L152_INCLUDE_DIRS)
STM32L152_LOCAL_INCLUDE_DIRS += $(if TARGET_KERNEL,$($(TARGET_KERNEL)_INCLUDE_DIRS))
STM32L152_LOCAL_INCLUDE_DIRS += $(if TARGET_ARCH,$($(TARGET_ARCH)_INCLUDE_DIRS))


STM32L152_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/inc/*.h)
STM32L152_SRC := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/src/*.c)
STM32L152_OBJ_C := $(notdir $(STM32L152_SRC))
STM32L152_OBJ := $(STM32L152_OBJ_C:.c=.o)
STM32L152_SRC_ASM := $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/startup_stm32l1xx_md.s.txt
STM32L152_SRC_ASM_O := startup_stm32l1xx_md.sO


# The target to build application library
platform: $(STM32L152_BUILD_DIR)/$(STM32L152_LIB_NAME) $(STM32L152_SRC) $(STM32L152_HEADERS)
	$(NOECHO) echo "Success!"

$(STM32L152_BUILD_DIR)/$(STM32L152_LIB_NAME):
	$(NOECHO) echo "Building application $(STM32L152_LIB_NAME) ..."
	$(NOECHO) -mkdir $(STM32L152_BUILD_DIR) -p
	$(NOECHO) cd $(STM32L152_BUILD_DIR) && \
	          echo "Compiling $(TARGET_APP) files $(notdir $(STM32L152_SRC)) ..." && \
	          $(CC) -c $(C_FLAGS) $(STM32L152_SRC) $(addprefix -I,$(STM32L152_LOCAL_INCLUDE_DIRS)) && \
	          $(CC) -c $(C_FLAGS) $(A_FLAGS) -o $(STM32L152_SRC_ASM_O) $(STM32L152_SRC_ASM) && \
	          $(LD) -r -o $(TARGET_SUB_PLATFORM)_OBJ.o $(STM32L152_OBJ) $(STM32L152_SRC_ASM_O) && \
	          echo "Hiding private symbols in $(TARGET_SUB_PLATFORM)_OBJ.o ..." && \
	          $(OBJCOPY) --localize-hidden $(TARGET_SUB_PLATFORM)_OBJ.o && \
	          echo "Archiving the library $(STM32L152_LIB_NAME) ..." && \
	          $(AR) rcs -o $(STM32L152_LIB_NAME) $(TARGET_SUB_PLATFORM)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(TARGET_NAME) -p && \
	          mv $(STM32L152_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(TARGET_NAME)






