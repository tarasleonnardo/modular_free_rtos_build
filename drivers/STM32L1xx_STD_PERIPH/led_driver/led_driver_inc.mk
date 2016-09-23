##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   drivers files and dirs               ############
LED_DRIVER_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/led_driver/inc

LED_DRIVER_LIB_NAME := libled_driver.a

PROJECT_DEP_LIBS += $(LED_DRIVER_LIB_NAME)

