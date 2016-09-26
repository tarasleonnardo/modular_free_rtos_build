##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk
include $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/STM32L152_inc.mk
include $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/led_driver/led_driver_inc.mk
include $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/STM32L1xx_Std_Periph/STM32L1xx_Std_Periph_inc.mk

##########   Files and dirs              ############
LED_DRIVER_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/STM32L1xx_STD_PERIPH

LED_DRIVER_LOCAL_INCLUDE_DIRS := $(LED_DRIVER_INCLUDE_DIRS)
LED_DRIVER_LOCAL_INCLUDE_DIRS += $(STM32L1xx_Std_Periph_INCLUDE_DIRS)
LED_DRIVER_LOCAL_INCLUDE_DIRS += $(ARM_CM3_INCLUDE_DIRS)
LED_DRIVER_LOCAL_INCLUDE_DIRS += $(STM32L152_INCLUDE_DIRS)


LED_DRIVER_HEADERS := $(wildcard $(LED_DRIVER_INCLUDE_DIRS)/*.h)

LED_DRIVER_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/led_driver/src/*.c)
LED_DRIVER_LOCAL_OBJ := $(notdir $(LED_DRIVER_LOCAL_SRC:.c=.o))

# The target to build application library
led_driver_bld.mk: $(PROJECT_LIB_DIR)/$(LED_DRIVER_LIB_NAME) $(LED_DRIVER_LOCAL_SRC) $(LED_DRIVER_LOCAL_HEADERS)
	$(NOECHO) echo "Success!"


$(PROJECT_LIB_DIR)/$(LED_DRIVER_LIB_NAME): $(LED_DRIVER_LOCAL_SRC) $(LED_DRIVER_LOCAL_HEADERS)
	$(NOECHO) echo "Building drivers lib $(LED_DRIVER_LIB_NAME) ..."
	$(NOECHO) -mkdir $(LED_DRIVER_BUILD_DIR) -p
	$(NOECHO) cd $(LED_DRIVER_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_DRIVERS) files $(notdir $(LED_DRIVER_LOCAL_SRC)) ..." && \
	          $(CC) -c $(C_FLAGS) $(LED_DRIVER_LOCAL_SRC) $(addprefix -I,$(LED_DRIVER_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_DRIVERS)_OBJ.o $(LED_DRIVER_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_DRIVERS)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_DRIVERS)_OBJ.o && \
	          echo "Archiving the library $(LED_DRIVER_LIB_NAME) ..." && \
	          $(AR) rcs -o $(LED_DRIVER_LIB_NAME) $(PROJECT_DRIVERS)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(LED_DRIVER_LIB_NAME) $(PROJECT_LIB_DIR)


