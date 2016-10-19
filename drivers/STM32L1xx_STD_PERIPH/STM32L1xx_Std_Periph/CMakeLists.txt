cmake_minimum_required(VERSION 3.5.1)

set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

####################################################################################
# The dependencies of the current module

set(CURRENT_MODULE_DEPENDENCIES
    arch/ARM_CM3
    platform/stm32/STM32L1xx/STM32L152
   )

####################################################################################
# The source files for this module

set(CURRENT_MODULE_INC
    ${CURRENT_DIR}/inc
   )

set(CURRENT_MODULE_SRC
   )

####################################################################################
if(USE_STD_PERIPH_MISC)
    set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                           ${CURRENT_DIR}/src/stm32l1xx_misc.c)
endif(USE_STD_PERIPH_MISC)
####################################################################################
if(USE_STD_PERIPH_COMP)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_comp.c)
endif(USE_STD_PERIPH_COMP)
####################################################################################
if(USE_STD_PERIPH_CRC)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_crc.c)
endif(USE_STD_PERIPH_CRC)
####################################################################################
if(USE_STD_PERIPH_DAC)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_dac.c)
endif(USE_STD_PERIPH_DAC)
####################################################################################
if(USE_STD_PERIPH_DBGMCU)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_dbgmcu.c)
endif(USE_STD_PERIPH_DBGMCU)
####################################################################################
if(USE_STD_PERIPH_DMA)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_dma.c)
endif(USE_STD_PERIPH_DMA)
####################################################################################
if(USE_STD_PERIPH_EXTI)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_exti.c)
endif(USE_STD_PERIPH_EXTI)
####################################################################################
if(USE_STD_PERIPH_FLASH)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_flash.c
                          ${CURRENT_DIR}/src/stm32l1xx_flash_ramfunc.c)
endif(USE_STD_PERIPH_FLASH)
####################################################################################
if(USE_STD_PERIPH_FSMC)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_fsmc.c)
endif(USE_STD_PERIPH_FSMC)
####################################################################################
if(USE_STD_PERIPH_GPIO)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_gpio.c)
endif(USE_STD_PERIPH_GPIO)
####################################################################################
if(USE_STD_PERIPH_I2C)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_i2c.c)
endif(USE_STD_PERIPH_I2C)
####################################################################################
if(USE_STD_PERIPH_IWDG)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_iwdg.c)
endif(USE_STD_PERIPH_IWDG)
####################################################################################
if(USE_STD_PERIPH_LCD)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_lcd.c)
endif(USE_STD_PERIPH_LCD)
####################################################################################
if(USE_STD_PERIPH_OPAMP)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_opamp.c)
endif(USE_STD_PERIPH_OPAMP)
####################################################################################
if(USE_STD_PERIPH_PWR)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_pwr.c)
endif(USE_STD_PERIPH_PWR)
####################################################################################
if(USE_STD_PERIPH_RCC)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_rcc.c)
endif(USE_STD_PERIPH_RCC)
####################################################################################
if(USE_STD_PERIPH_RTC)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_rtc.c)
endif(USE_STD_PERIPH_RTC)
####################################################################################
if(USE_STD_PERIPH_SDIO)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_sdio.c)
endif(USE_STD_PERIPH_SDIO)
####################################################################################
if(USE_STD_PERIPH_SPI)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_spi.c)
endif(USE_STD_PERIPH_SPI)
####################################################################################
if(USE_STD_PERIPH_SYSCFG)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_syscfg.c)
endif(USE_STD_PERIPH_SYSCFG)
####################################################################################
if(USE_STD_PERIPH_TIM)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_tim.c)
endif(USE_STD_PERIPH_TIM)
####################################################################################
if(USE_STD_PERIPH_USART)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_usart.c)
endif(USE_STD_PERIPH_USART)
####################################################################################
if(USE_STD_PERIPH_WWDG)
   set(CURRENT_MODULE_SRC ${CURRENT_MODULE_SRC}
                          ${CURRENT_DIR}/src/stm32l1xx_wwdg.c)
endif(USE_STD_PERIPH_WWDG)


####################################################################################
# Create the target for the current module and add all of its dependencies
CREATE_FULL_MODULE()
