##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   FreeRTOS files and dirs              ############
led_switcher_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/app/led_switcher/inc

led_switcher_LIB_NAME := libled_switcher.a

PROJECT_DEP_LIBS += $(led_switcher_LIB_NAME)
