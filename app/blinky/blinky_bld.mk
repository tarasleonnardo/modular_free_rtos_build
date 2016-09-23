##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/apps/blinky/blinky_inc.mk
include $(PROJECT_DIRECTORY)/arch/$(PROJECT_ARCH)/$(PROJECT_ARCH)_inc.mk
include $(PROJECT_DIRECTORY)/platform/$(PROJECT_PLATFORM)/$(PROJECT_SUB_PLATFORM)/$(PROJECT_SUB_PLATFORM)_inc.mk

##########   Files and dirs              ############

BLINKY_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
BLINKY_LOCAL_C_VIS_FLAG := -fvisibility=hidden
endif

BLINKY_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/blinky

BLINKY_LOCAL_INCLUDE_DIRS := $(blinky_INCLUDE_DIRS)
BLINKY_LOCAL_INCLUDE_DIRS += $(if PROJECT_KERNEL,$($(PROJECT_KERNEL)_INCLUDE_DIRS))
BLINKY_LOCAL_INCLUDE_DIRS += $(if PROJECT_SUB_PLATFORM,$($(PROJECT_SUB_PLATFORM)_INCLUDE_DIRS))
BLINKY_LOCAL_INCLUDE_DIRS += $(if PROJECT_ARCH,$($(PROJECT_ARCH)_INCLUDE_DIRS))

BLINKY_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/*.h)
BLINKY_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/apps/$(PROJECT_APP)/*.c)
BLINKY_LOCAL_OBJ := $(notdir $(BLINKY_LOCAL_SRC:.c=.o))

# The target to build application library
application: $(BLINKY_BUILD_DIR)/$(blinky_LIB_NAME) $(BLINKY_LOCAL_SRC) $(BLINKY_HEADERS)
	$(NOECHO) echo "Success!"

$(BLINKY_BUILD_DIR)/$(blinky_LIB_NAME):
	$(NOECHO) echo "Building application $(blinky_LIB_NAME) ..."
	$(NOECHO) -mkdir $(BLINKY_BUILD_DIR) -p
	$(NOECHO) cd $(BLINKY_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_APP) files $(notdir $(BLINKY_LOCAL_SRC)) ..." && \
	          $(CC) -c $(BLINKY_LOCAL_C_FLAGS) $(BLINKY_LOCAL_C_VIS_FLAG) $(BLINKY_LOCAL_SRC) $(addprefix -I,$(BLINKY_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_APP)_OBJ.o $(BLINKY_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_APP)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_APP)_OBJ.o && \
	          echo "Archiving the library $(blinky_LIB_NAME) ..." && \
	          $(AR) rcs -o $(blinky_LIB_NAME) $(PROJECT_APP)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(blinky_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)

