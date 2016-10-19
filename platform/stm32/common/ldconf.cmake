cmake_minimum_required(VERSION 3.5.1)

### Configure memory layout not set yet

if( NOT FLASH_ORIGIN )
    set(FLASH_ORIGIN "0x08000000")
endif( NOT FLASH_ORIGIN )

if( NOT FLASH_LENGTH )
    set(FLASH_LENGTH "512K")
endif( NOT FLASH_LENGTH )

if( NOT RAM_ORIGIN )
    set(RAM_ORIGIN "0x20000000")
endif( NOT RAM_ORIGIN )

if( NOT RAM_LENGTH )
    set(RAM_LENGTH "80K")
endif( NOT RAM_LENGTH )

if( NOT CCM_ORIGIN)
    set(CCM_ORIGIN "0x00000000")
endif( NOT CCM_ORIGIN)

if( NOT CCM_LENGTH )
    set(CCM_LENGTH "0K")
endif( NOT CCM_LENGTH )

if( NOT EEPROM_ORIGIN )
set(EEPROM_ORIGIN "0x00000000")
endif( NOT EEPROM_ORIGIN )

if( NOT EEPROM_LENGTH )
    set(EEPROM_LENGTH "0K")
endif( NOT EEPROM_LENGTH )

### Template linker srcipt file
set(LINKER_SCRIPT_TEMPLATE "${BASE_DIR}/platform/stm32/common/ld_template/link_template.ld")

message(***************************************)
message(Memory layout)
message("FLASH_ORIGIN ${FLASH_ORIGIN}")
message("FLASH_LENGTH ${FLASH_LENGTH}")
message("RAM_ORIGIN ${RAM_ORIGIN}")
message("RAM_LENGTH ${RAM_LENGTH}")
message("CCM_ORIGIN ${CCM_ORIGIN}")
message("CCM_LENGTH ${CCM_LENGTH}")
message("EEPROM_ORIGIN ${EEPROM_ORIGIN}")
message("EEPROM_LENGTH ${EEPROM_LENGTH}")
message("LINKER_SCRIPT ${LINKER_SCRIPT}")
message(***************************************)


### Configure the linker script
### LINKER_SCRIPT has to be defined in the main cmake file
configure_file(${LINKER_SCRIPT_TEMPLATE} ${LINKER_SCRIPT})

