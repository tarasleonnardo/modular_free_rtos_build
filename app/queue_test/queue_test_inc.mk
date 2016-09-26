##############################################################
#   Describes include directories and files of the module    #
##############################################################

##########   FreeRTOS files and dirs              ############
queue_test_INCLUDE_DIRS := $(PROJECT_DIRECTORY)/app/$(QUEUE_TST_LOCAL_APP_NAME)

queue_test_LIB_NAME := q_test.a

PROJECT_DEP_LIBS += $(queue_test_LIB_NAME)