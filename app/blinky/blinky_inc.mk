##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   FreeRTOS files and dirs              ############
blinky_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/app/$(BLINKY_LOCAL_APP_NAME)

blinky_LIB_NAME := blinky.a

PROJECT_DEP_LIBS += $(blinky_LIB_NAME)