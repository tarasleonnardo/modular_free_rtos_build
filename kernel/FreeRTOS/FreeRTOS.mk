#############################################################
#############################################################
#                                                           #
#                FreeRTOS kernel makefile                   #
#                                                           #
#############################################################

# Build library in current folder if build folder was not defined

# Dependencies

FREERTOS_DEP_KERNEL := FreeRTOS


#############################################################
# Include dependencies files
include $(PROJECT_DIRECTORY)/kernel/FreeRTOS/FreeRTOS_inc.mk

#############################################################


 
ifndef TARGET_BUILD_DIRECTORY
TARGET_BUILD_DIRECTORY := build
endif

FREERTOS_BUILD_DIR := $(TARGET_BUILD_DIRECTORY)/FreeRTOS
FREERTOS_LIB_OBJ := $(notdir $(FreeRTOS_SRC:.c=.o))


# Target to build the library
$(FREERTOS_BUILD_DIR)/FreeRTOS.a: $(FreeRTOS_SRC) $($(FREERTOS_DEP_KERNEL)_HEADERS)
	echo "FreeRTOS lib directory: $(FREERTOS_BUILD_DIR)."
	-mkdir $(FREERTOS_BUILD_DIR) -p $(SUPPRESS_ERRORS)
	cd $(FREERTOS_BUILD_DIR) && \
	echo Compiling ... && \
	$(CC) -c $(C_FLAGS) $(FreeRTOS_SRC) $($(FREERTOS_DEP_KERNEL)_INCLUDE_DIRS) && \
	echo "Archiving $(TARGET_KERNEL).a" && \
	$(AR) rcs  $(TARGET_KERNEL).a $(FREERTOS_LIB_OBJ)




