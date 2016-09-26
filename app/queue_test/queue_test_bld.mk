##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   Prerequisities                       ############
include $(PROJECT_DIRECTORY)/app/queue_test/queue_test_inc.mk
include $(PROJECT_DIRECTORY)/arch/ARM_CM3/ARM_CM3_inc.mk
include $(PROJECT_DIRECTORY)/platform/STM32L152/STM32L152/STM32L152_inc.mk
include $(PROJECT_DIRECTORY)/kernel/FreeRTOS/FreeRTOS_inc.mk

##########   Files and dirs              ############

QUEUE_TST_LOCAL_C_FLAGS := $(C_FLAGS)
ifdef VIS_HIDDEN
QUEUE_TST_LOCAL_C_VIS_FLAG := -fvisibility=hidden
endif

QUEUE_TST_BUILD_DIR := $(PROJECT_BUILD_DIRECTORY)/queue_test

QUEUE_TST_LOCAL_INCLUDE_DIRS := $(QUEUE_TST_INCLUDE_DIRS)
QUEUE_TST_LOCAL_INCLUDE_DIRS += $(ARM_CM3_INCLUDE_DIRS)
QUEUE_TST_LOCAL_INCLUDE_DIRS += $(STM32L152_INCLUDE_DIRS)
QUEUE_TST_LOCAL_INCLUDE_DIRS += $(FreeRTOS_INCLUDE_DIRS)

QUEUE_TST_HEADERS := $(wildcard $(PROJECT_DIRECTORY)/app/queue_test/*.h)
QUEUE_TST_LOCAL_SRC := $(wildcard $(PROJECT_DIRECTORY)/app/queue_test/*.c)
QUEUE_TST_LOCAL_OBJ := $(notdir $(QUEUE_TST_LOCAL_SRC:.c=.o))

# The target to build application library
queue_test_bld.mk: $(QUEUE_TST_BUILD_DIR)/$(QUEUE_TST_LIB_NAME) $(QUEUE_TST_LOCAL_SRC) $(QUEUE_TST_HEADERS)
	$(NOECHO) echo "Success!"

$(QUEUE_TST_BUILD_DIR)/$(QUEUE_TST_LIB_NAME):
	$(NOECHO) echo "Building application $(QUEUE_TST_LIB_NAME) ..."
	$(NOECHO) -mkdir $(QUEUE_TST_BUILD_DIR) -p
	$(NOECHO) cd $(QUEUE_TST_BUILD_DIR) && \
	          echo "Compiling $(PROJECT_APP) files $(notdir $(QUEUE_TST_LOCAL_SRC)) ..." && \
	          $(CC) -c $(QUEUE_TST_LOCAL_C_FLAGS) $(QUEUE_TST_LOCAL_C_VIS_FLAG) $(QUEUE_TST_LOCAL_SRC) $(addprefix -I,$(QUEUE_TST_LOCAL_INCLUDE_DIRS)) && \
	          $(LD) -r -o $(PROJECT_NAME)_OBJ.o $(QUEUE_TST_LOCAL_OBJ) && \
	          echo "Hiding private symbols $(PROJECT_NAME)_OBJ.o..." && \
	          $(OBJCOPY) --localize-hidden $(PROJECT_NAME)_OBJ.o && \
	          echo "Archiving the library $(queue_test_LIB_NAME) ..." && \
	          $(AR) rcs -o $(queue_test_LIB_NAME) $(PROJECT_NAME)_OBJ.o && \
	          mkdir $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME) -p && \
	          mv $(queue_test_LIB_NAME) $(PROJECT_DIRECTORY)/lib/$(PROJECT_NAME)

