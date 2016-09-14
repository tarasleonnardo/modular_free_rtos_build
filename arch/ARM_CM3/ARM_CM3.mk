#############################################################
#############################################################
#                                                           #
#           Architecture specific files makefile            #
#                                                           #
#############################################################

# Build library in current folder if build folder was not defined

# Dependencies

#############################################################
# Include dependencies files

#############################################################

include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk

ifndef TARGET_BUILD_DIRECTORY
TARGET_BUILD_DIRECTORY := build
endif

ARCH_BUILD_DIR := $(TARGET_BUILD_DIRECTORY)/ARM_CM3
ARCH_DIR := $(PROJECT_DIRECTORY)/arch/ARM_CM3
ARCH_LIB_SRC := $(ARM_CM3_SRC)
ARCH_LIB_OBJ := $(notdir $(ARCH_LIB_SRC:.c=.o))


# Target to build the library
$(ARCH_BUILD_DIR)/ARM_CM3.a: $(ARCH_LIB_SRC) $($(ARCH_DEP_KERNEL)_HEADERS) $($(ARCH_DEP_PLATFORM)_HEADERS)
	echo "Make architecture specific if needed files lib in $(ARCH_BUILD_DIR)"
#	-mkdir $(ARCH_BUILD_DIR) -p $(SUPPRESS_ERRORS)
#	cd $(ARCH_BUILD_DIR) && \
#	echo Compiling ... && \
#	$(CC) -c $(C_FLAGS) $(ARCH_LIB_SRC) $(ARM_CM3_INCLUDE_DIRS) && \
#	echo "Archiving $(TARGET_ARCH).a" && \
#	$(AR) rcs  $(TARGET_ARCH).a $(ARCH_LIB_OBJ)