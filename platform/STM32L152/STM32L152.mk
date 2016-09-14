#############################################################
#############################################################
#                                                           #
#           Architecture specific files makefile            #
#                                                           #
#############################################################

# Build library in current folder if build folder was not defined

# Dependencies

PLATFORM_DEP_KERNEL := FreeRTOS


#############################################################
# Include dependencies files

#############################################################

 
ifndef TARGET_BUILD_DIRECTORY
TARGET_BUILD_DIRECTORY := build
endif

PLATFORM_BUILD_DIR := $(TARGET_BUILD_DIRECTORY)/STM32L152
PLATFORM_DIR := $(PROJECT_DIRECTORY)/platform/STM32L152
PLATFORM_LIB_SRC := $(STM32L152_SRC)
PLATFORM_LIB_OBJ := $(notdir $(PLATFORM_LIB_SRC:.c=.o))

PLATFORM_STARTUP_ASM := startup_stm32l1xx_md.s.txt
PLATFORM_STARTUP_O := startup_stm32l1xx_md.sO



# Target to build the library
$(PLATFORM_BUILD_DIR)/STM32L152.a: $(PLATFORM_LIB_SRC) $($(PLATFORM_DEP_KERNEL)_HEADERS) $($(PLATFORM_DEP_PLATFORM)_HEADERS) $(PLATFORM_BUILD_DIR)/$(PLATFORM_STARTUP_O)
	echo "Make platform specific files lib in $(PLATFORM_BUILD_DIR)"
	-mkdir $(PLATFORM_BUILD_DIR) -p $(SUPPRESS_ERRORS)
	cd $(PLATFORM_BUILD_DIR) && \
	echo Compiling ... && \
	$(CC) -c $(C_FLAGS) $(PLATFORM_LIB_SRC) $($(PLATFORM_DEP_KERNEL)_INCLUDE_DIRS) $(STM32L152_INCLUDE_DIRS) && \
	echo "Archiving $(TARGET_APP).a" && \
	$(AR) rcs  $(TARGET_PLATFORM).a $(PLATFORM_LIB_OBJ) $(PLATFORM_STARTUP_O)


$(PLATFORM_BUILD_DIR)/$(PLATFORM_STARTUP_O): $(PLATFORM_DIR)/$(PLATFORM_STARTUP_ASM)
	echo "Compilling startup file: $(PLATFORM_DIR)/$(PLATFORM_STARTUP_ASM)"
	-mkdir $(PLATFORM_BUILD_DIR) -p $(SUPPRESS_ERRORS)
	cd $(PLATFORM_BUILD_DIR) && \
	echo Compiling ... && \
	$(CC) -c $(A_FLAGS) $(C_FLAGS) -o $(PLATFORM_STARTUP_O) $(PLATFORM_DIR)/$(PLATFORM_STARTUP_ASM)
