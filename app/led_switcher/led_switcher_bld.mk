##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############

include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk
include $(PROJECT_DIRECTORY)/kernel/FreeRTOS/FreeRTOS_inc.mk
include $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/led_driver/led_driver_inc.mk

##########   Files and dirs              ############


LED_SWITCHER_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
LED_SWITCHER_LOCAL_C_VIS_FLAG := -fvisibility=hidden
endif

LED_SWITCHER_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/led_switcher

LED_SWITCHER_LOCAL_INCLUDE_DIRS := $(LED_SWITCHER_INCLUDE_DIRS)
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(FreeRTOS_INCLUDE_DIRS)
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(STM32L1xx_STD_PERIPH_INCLUDE_DIRS)
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(LED_DRIVER_INCLUDE_DIRS)

LED_SWITCHER_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/app/led_switcher/*.h)
LED_SWITCHER_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/app/led_switcher/*.c)
LED_SWITCHER_LOCAL_OBJ := $(notdir $(LED_SWITCHER_LOCAL_SRC:.c=.o))

# The target to build application library
led_switcher_bld.mk: $(PROJECT_LIB_DIR)/$(led_switcher_LIB_NAME) $(LED_SWITCHER_LOCAL_SRC) $(LED_SWITCHER_HEADERS)
	$(NOECHO) echo "Success!"

$(PROJECT_LIB_DIR)/$(led_switcher_LIB_NAME): $(LED_SWITCHER_LOCAL_SRC) $(LED_SWITCHER_HEADERS)
	$(NOECHO) echo "Building application $(led_switcher_LIB_NAME) ..."
	$(NOECHO) -mkdir $(LED_SWITCHER_BUILD_DIR) -p
	$(NOECHO) cd $(LED_SWITCHER_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_APP) files $(notdir $(LED_SWITCHER_LOCAL_SRC)) ..." && \
	          $(CC) -c $(LED_SWITCHER_LOCAL_C_FLAGS) $(LED_SWITCHER_LOCAL_C_VIS_FLAG) $(LED_SWITCHER_LOCAL_SRC) $(addprefix -I,$(LED_SWITCHER_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_APP)_OBJ.o $(LED_SWITCHER_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_APP)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_APP)_OBJ.o && \
	          echo "Archiving the library $(led_switcher_LIB_NAME) ..." && \
	          $(AR) rcs -o $(led_switcher_LIB_NAME) $(PROJECT_APP)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(led_switcher_LIB_NAME) $(PROJECT_LIB_DIR)

