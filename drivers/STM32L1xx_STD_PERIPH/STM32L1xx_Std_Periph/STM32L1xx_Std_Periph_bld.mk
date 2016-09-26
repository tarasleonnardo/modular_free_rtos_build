##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk
include $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/STM32L152_inc.mk


##########   Files and dirs              ############
STM32L1xx_STD_PERIPH_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/STM32L1xx_STD_PERIPH

STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS := $(STM32L1xx_Std_Periph_INCLUDE_DIRS)
STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS += $(ARM_CM3_INCLUDE_DIRS)
STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS += $(STM32L152_INCLUDE_DIRS)

STM32L1xx_STD_PERIPH_HEADERS := $(wildcard $(STM32L1xx_Std_Periph_INCLUDE_DIRS)/*.h)

STM32L1xx_STD_PERIPH_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/STM32L1xx_Std_Periph/src/*.c)
STM32L1xx_STD_PERIPH_LOCAL_OBJ := $(notdir $(STM32L1xx_STD_PERIPH_LOCAL_SRC:.c=.o))

# The target to build application library
STM32L1xx_Std_Periph_bld.mk: $(PROJECT_LIB_DIR)/$(STM32L1xx_Std_Periph_LIB_NAME) $(STM32L1xx_STD_PERIPH_LOCAL_SRC) $(STM32L1xx_STD_PERIPH_HEADERS)
	$(NOECHO) echo "Success!"


$(PROJECT_LIB_DIR)/$(STM32L1xx_Std_Periph_LIB_NAME): $(STM32L1xx_STD_PERIPH_LOCAL_SRC) $(STM32L1xx_STD_PERIPH_HEADERS)
	$(NOECHO) echo "Building drivers lib $(STM32L1xx_STD_PERIPH_LIB_NAME) ..."
	$(NOECHO) -mkdir $(STM32L1xx_STD_PERIPH_BUILD_DIR) -p
	$(NOECHO) cd $(STM32L1xx_STD_PERIPH_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_DRIVERS) files $(notdir $(STM32L1xx_STD_PERIPH_LOCAL_SRC)) ..." && \
	          $(CC) -c $(C_FLAGS) $(STM32L1xx_STD_PERIPH_LOCAL_SRC) $(addprefix -I,$(STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_DRIVERS)_OBJ.o $(STM32L1xx_STD_PERIPH_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_DRIVERS)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_DRIVERS)_OBJ.o && \
	          echo "Archiving the library $(STM32L1xx_Std_Periph_LIB_NAME) ..." && \
	          $(AR) rcs -o $(STM32L1xx_Std_Periph_LIB_NAME) $(PROJECT_DRIVERS)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(STM32L1xx_Std_Periph_LIB_NAME) $(PROJECT_LIB_DIR)

