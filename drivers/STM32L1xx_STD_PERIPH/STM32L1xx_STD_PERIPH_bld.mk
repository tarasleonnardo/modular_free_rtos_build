##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/arch/$(PROJECT_ARCH)/$(PROJECT_ARCH)_inc.mk
include $(PROJECT_DIRECTORY)/kernel/$(PROJECT_KERNEL)/$(PROJECT_KERNEL)_inc.mk
include $(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$(PROJECT_SUB_PLATFORM)_inc.mk
include $(PROJECT_DIRECTORY)/drivers/$(PROJECT_DRIVERS)/$(PROJECT_DRIVERS)_inc.mk

##########   Files and dirs              ############
STM32L1xx_STD_PERIPH_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/STM32L1xx_STD_PERIPH

STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS := $(STM32L1xx_STD_PERIPH_INCLUDE_DIRS)
STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS += $(if PROJECT_KERNEL,$($(PROJECT_KERNEL)_INCLUDE_DIRS))
STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS += $(if PROJECT_SUB_PLATFORM,$($(PROJECT_SUB_PLATFORM)_INCLUDE_DIRS))
STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS += $(if PROJECT_ARCH,$($(PROJECT_ARCH)_INCLUDE_DIRS))


STM32L1xx_STD_PERIPH_HEADERS := $(wildcard $(STM32L1xx_STD_PERIPH_INCLUDE_DIRS)/*.h)

STM32L1xx_STD_PERIPH_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/src/*.c)
STM32L1xx_STD_PERIPH_LOCAL_OBJ := $(notdir $(STM32L1xx_STD_PERIPH_LOCAL_SRC:.c=.o))

# The target to build application library
drivers: $(STM32L1xx_STD_PERIPH_BUILD_DIR)/$(STM32L1xx_STD_PERIPH_LIB_NAME) $(STM32L1xx_STD_PERIPH_LOCAL_SRC) $(STM32L1xx_STD_PERIPH_LOCAL_HEADERS)
	$(NOECHO) echo "Success!"

$(STM32L1xx_STD_PERIPH_BUILD_DIR)/$(STM32L1xx_STD_PERIPH_LIB_NAME):
	$(NOECHO) echo "Building drivers lib $(STM32L1xx_STD_PERIPH_LIB_NAME) ..."
	$(NOECHO) -mkdir $(STM32L1xx_STD_PERIPH_BUILD_DIR) -p
	$(NOECHO) cd $(STM32L1xx_STD_PERIPH_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_DRIVERS) files $(notdir $(STM32L1xx_STD_PERIPH_LOCAL_SRC)) ..." && \
	          $(CC) -c $(C_FLAGS) $(STM32L1xx_STD_PERIPH_LOCAL_SRC) $(addprefix -I,$(STM32L1xx_STD_PERIPH_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_DRIVERS)_OBJ.o $(STM32L1xx_STD_PERIPH_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_DRIVERS)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_DRIVERS)_OBJ.o && \
	          echo "Archiving the library $(STM32L1xx_STD_PERIPH_LIB_NAME) ..." && \
	          $(AR) rcs -o $(STM32L1xx_STD_PERIPH_LIB_NAME) $(PROJECT_DRIVERS)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(blinky_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)

