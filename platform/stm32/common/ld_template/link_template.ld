ENTRY(Reset_Handler)

/* Memory areas */
MEMORY
{
    FLASH (rx) : ORIGIN = @FLASH_ORIGIN@,  LENGTH = @FLASH_LENGTH@
    RAM (xrw)  : ORIGIN = @RAM_ORIGIN@,    LENGTH = @RAM_LENGTH@
    CCM (xrw)  : ORIGIN = @CCM_ORIGIN@,    LENGTH = @CCM_LENGTH@
    EEPROM(rw) : ORIGIN = @EEPROM_ORIGIN@, LENGTH = @EEPROM_LENGTH@
}

/* The top of the stack */
_estack = 0x20007FFF; /* ORIGIN(RAM) + LENGTH(RAM); */

SECTIONS
{
    /* Interrupt vectors -> Flash */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } > FLASH

    /* Code -> Flash */
    .text :
    {
        . = ALIGN(4);

        *(.text)
        *(.text*)
        KEEP(*(.init))
        KEEP(*(.fini))

        . = ALIGN(4);

        /* The end of the code */
        _etext = .;
    } > FLASH

    /* Read only data -> flash */    
    .rodata :
    {
        . = ALIGN(4);

        *(.rodata)
        *(.rodata*)

        . = ALIGN(4);
    } > FLASH

    . = ALIGN(4);
    /* Start of data to initialize at startup */
    _sidata = LOADADDR(.data);

    /* Initialized data */
    .data :
    {
        . = ALIGN(4);
        /* Start of the data */
        _sdata = .;

        *(.data);
        *(.data*);

        . = ALIGN(4);
        /* The end of the data */
        _edata = .;
    } > RAM AT > FLASH
    
    /* Uninitialized data */
    .bss :
    {
        . = ALIGN(4);

        _sbss = .;
        *(.bss)
        *(.bss*)
        *(COMMON)

        . = ALIGN(4);
        _ebss = .;
    } > RAM


    /* Remove information from the standard libraries */
    /DISCARD/ :
    {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }
}
