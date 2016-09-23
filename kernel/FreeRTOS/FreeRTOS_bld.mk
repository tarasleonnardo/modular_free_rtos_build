##############################################################
#   Describes include directories and files of the module    #
##############################################################

FREERTOS_ARCH := ARM_CM3

include $(PROJECT_DIRECTORY)/kernel/FreeRTOS/FreeRTOS_inc.mk

FreeRTOS_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
# Apply this option to freertos files is not allowed
# because the interface functions does not have the visibility attributes
FreeRTOS_LOCAL_C_VIS_FLAG := #-fvisibility=hidden
endif

FreeRTOS_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/include/*.h)
FreeRTOS_HEADERS += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(FREERTOS_ARCH)*.h)
                         
FreeRTOS_SRC := $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/*.c)
FreeRTOS_SRC += $(wildcard $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/GCC/$(FREERTOS_ARCH)/*.c)
FreeRTOS_SRC += $(PROJECT_DIRECTORY)/kernel/FreeRTOS/Source/portable/MemMang/heap_2.c

FreeRTOS_SRC_C := $(notdir $(FreeRTOS_SRC))
FreeRTOS_OBJ := $(FreeRTOS_SRC_C:.c=.o)

FreeRTOS_BLD_DIR := $(PROJECT_BUILD_DIRECTORY)/FreeRTOS

# The target to build kernel library
FreeRTOS_bld.mk: $(PROJECT_LIB_DIR)/$(FreeRTOS_LIB_NAME)
	$(NOECHO) echo "Success!"


$(PROJECT_LIB_DIR)/$(FreeRTOS_LIB_NAME): $(FreeRTOS_SRC) $(FreeRTOS_HEADERS)
	$(NOECHO) echo "Building kernel $(FreeRTOS_LIB_NAME) ..."
	$(NOECHO) -mkdir $(FreeRTOS_BLD_DIR) -p
	$(NOECHO) cd $(FreeRTOS_BLD_DIR) && \
	          echo "Compiling FreeRTOS files $(notdir $(FreeRTOS_SRC)) ..." && \
	          $(CC) -c $(FreeRTOS_LOCAL_C_FLAGS) $(FreeRTOS_SRC) $(addprefix -I,$(FreeRTOS_INCLUDE_DIRS)) && \
	          $(LD) -r -o FreeRTOS_OBJ.o $(FreeRTOS_OBJ) && \
	          echo "Hiding private symbols in FreeRTOS_OBJ.o ..." && \
	          $(OBJCOPY) --localize-hidden FreeRTOS_OBJ.o && \
	          echo "Archiving the library $(FreeRTOS_LIB_NAME) ..." && \
	          $(AR) rcs -o $(FreeRTOS_LIB_NAME) FreeRTOS_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(FreeRTOS_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)
