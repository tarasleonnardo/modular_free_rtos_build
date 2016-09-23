##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############

include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk

##########   Files and dirs              ############

STM32L152_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
STM32L152_LOCAL_C_VIS_FLAG := -fvisibility=hidden
endif

STM32L152_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/STM32L152

STM32L152_LOCAL_INCLUDE_DIRS := $(STM32L152_INCLUDE_DIRS)
STM32L152_LOCAL_INCLUDE_DIRS += $(ARM_CM3_INCLUDE_DIRS)

STM32L152_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/inc/*.h)
STM32L152_SRC := $(wildcard $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/src/*.c)
STM32L152_OBJ_C := $(notdir $(STM32L152_SRC))
STM32L152_OBJ := $(STM32L152_OBJ_C:.c=.o)
STM32L152_SRC_ASM := $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/startup_stm32l1xx_md.s.txt
STM32L152_SRC_ASM_O := startup_stm32l1xx_md.sO


# The target to build application library
STM32L152_bld.mk: $(PROJECT_LIB_DIR)/$(STM32L152_LIB_NAME) $(STM32L152_SRC) $(STM32L152_HEADERS)
	$(NOECHO) echo "Success!"

$(PROJECT_LIB_DIR)/$(STM32L152_LIB_NAME):
	$(NOECHO) echo "Building platrorm support $(STM32L152_LIB_NAME) ..."
	$(NOECHO) -mkdir $(STM32L152_BUILD_DIR) -p
	$(NOECHO) cd $(STM32L152_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_APP) files $(notdir $(STM32L152_SRC)) ..." && \
	          $(CC) -c $(STM32L152_LOCAL_C_FLAGS) $(STM32L152_LOCAL_C_VIS_FLAG) $(STM32L152_SRC) $(addprefix -I,$(STM32L152_LOCAL_INCLUDE_DIRS)) && \
	          $(CC) -c $(STM32L152_LOCAL_C_FLAGS) $(A_FLAGS) -o $(STM32L152_SRC_ASM_O) $(STM32L152_SRC_ASM) && \
	          $(LD) -r -o $(PROJECT_SUB_PLATFORM)_OBJ.o $(STM32L152_OBJ) $(STM32L152_SRC_ASM_O) && \
	          echo "Hiding private symbols in $(PROJECT_SUB_PLATFORM)_OBJ.o ..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_SUB_PLATFORM)_OBJ.o && \
	          echo "Archiving the library $(STM32L152_LIB_NAME) ..." && \
	          $(AR) rcs -o $(STM32L152_LIB_NAME) $(PROJECT_SUB_PLATFORM)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(STM32L152_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)






