##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   drivers files and dirs               ############
STM32L1xx_Std_Periph_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/drivers/STM32L1xx_STD_PERIPH/STM32L1xx_Std_Periph/inc

STM32L1xx_Std_Periph_LIB_NAME := stm32f1xx_std_periph.a

PROJECT_DEP_LIBS += $(STM32L1xx_Std_Periph_LIB_NAME)
