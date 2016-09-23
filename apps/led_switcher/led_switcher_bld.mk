##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/apps/led_switcher/led_switcher_inc.mk
include $(PROJECT_DIRECTORY)/arch/$(PROJECT_ARCH)/$(PROJECT_ARCH)_inc.mk
include $(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$(PROJECT_SUB_PLATFORM)_inc.mk
include $(PROJECT_DIRECTORY)/drivers/$(PROJECT_DRIVERS)/$(PROJECT_DRIVERS)_inc.mk

##########   Files and dirs              ############

LED_SWITCHER_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
LED_SWITCHER_LOCAL_C_VIS_FLAG := -fvisibility=hidden
endif

LED_SWITCHER_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/led_switcher

LED_SWITCHER_LOCAL_INCLUDE_DIRS := $(LED_SWITCHER_INCLUDE_DIRS)
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(if PROJECT_KERNEL,$($(PROJECT_KERNEL)_INCLUDE_DIRS))
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(if PROJECT_SUB_PLATFORM,$($(PROJECT_SUB_PLATFORM)_INCLUDE_DIRS))
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(if PROJECT_ARCH,$($(PROJECT_ARCH)_INCLUDE_DIRS))
LED_SWITCHER_LOCAL_INCLUDE_DIRS += $(if PROJECT_DRIVERS,$($(PROJECT_DRIVERS)_INCLUDE_DIRS))

LED_SWITCHER_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/*.h)
LED_SWITCHER_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/*.c)
LED_SWITCHER_LOCAL_OBJ := $(notdir $(LED_SWITCHER_LOCAL_SRC:.c=.o))

# The target to build application library
application: $(LED_SWITCHER_BUILD_DIR)/$(led_switcher_LIB_NAME) $(LED_SWITCHER_LOCAL_SRC) $(LED_SWITCHER_HEADERS)
	$(NOECHO) echo "Success!"

$(LED_SWITCHER_BUILD_DIR)/$(led_switcher_LIB_NAME):
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
	          mv $(led_switcher_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)

