#############################################################
#############################################################
#                                                           #
#              Blinky application makefile                  # 
#                                                           #
#############################################################

# Build library in current folder if build folder was not defined

# Dependencies

BLINKY_DEP_KERNEL := FreeRTOS
BLINKY_DEP_PLATFORM := STM32L152


#############################################################
# Include dependencies files
include $(PROJECT_DIRECTORY)/kernel/$(BLINKY_DEP_KERNEL)/$(BLINKY_DEP_KERNEL)_inc.mk
include $(PROJECT_DIRECTORY)/platform/$(BLINKY_DEP_PLATFORM)/$(BLINKY_DEP_PLATFORM)_inc.mk

#############################################################


 
ifndef TARGET_BUILD_DIRECTORY
TARGET_BUILD_DIRECTORY := build
endif

BLINKY_BUILD_DIR := $(TARGET_BUILD_DIRECTORY)/blinky
BLINKY_DIR := $(PROJECT_DIRECTORY)/apps/blinky
BLINKY_LIB_SRC := $(wildcard $(BLINKY_DIR)/*.c)
BLINKY_LIB_OBJ := $(notdir $(BLINKY_LIB_SRC:.c=.o))


# Target to build the library
$(BLINKY_BUILD_DIR)/blinky.a: $(BLINKY_LIB_SRC) $($(BLINKY_DEP_KERNEL)_HEADERS) $($(BLINKY_DEP_PLATFORM)_HEADERS)
	echo "Application lib directory $(BLINKY_BUILD_DIR)."
	-mkdir $(BLINKY_BUILD_DIR) -p $(SUPPRESS_ERRORS)
	cd $(BLINKY_BUILD_DIR) && \
	echo Compiling ... && \
	$(CC) -c $(C_FLAGS) $(BLINKY_LIB_SRC) $($(BLINKY_DEP_KERNEL)_INCLUDE_DIRS) $($(BLINKY_DEP_PLATFORM)_INCLUDE_DIRS) && \
	echo "Archiving $(TARGET_APP).a" && \
	$(AR) rcs  $(TARGET_APP).a $(BLINKY_LIB_OBJ)




