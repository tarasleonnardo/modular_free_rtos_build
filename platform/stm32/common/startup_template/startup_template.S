
#define FUNCTION(x) .global x; .type x,%function; .thumb_func; x:

.syntax unified
.cpu @TARGET_ARCH@
.fpu @TARGET_FPU@
.thumb


/* start address for the initialization values of the .data section. 
defined in linker script */
.word _sidata
/* start address for the .data section. defined in linker script */
.word _sdata
/* end address for the .data section. defined in linker script */
.word _edata
/* start address for the .bss section. defined in linker script */
.word _sbss
/* end address for the .bss section. defined in linker script */
.word _ebss


.section .isr_vector,"a",%progbits

	.word   _estack
	.word   Reset_Handler

	/* rest of exception table here */
	.word NMI_Handler
	.word HardFault_Handler
	.word MemManage_Handler
	.word BusFault_Handler
	.word UsageFault_Handler
	.word UnhandledFault_Handler
	.word UnhandledFault_Handler
	.word UnhandledFault_Handler
	.word UnhandledFault_Handler
	.word SVC_Handler
	.word DebugMon_Handler
	.word UnhandledFault_Handler
	.word PendSV_Handler
	.word SysTick_Handler

/* The rest of the interrupts table */
#include "@IRQ_TABLE_FILE@"


.section .text

/* Interrupt handlers */
#include "@IRQ_HANDLERS_FILE@"

.section .text
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
	cpsid i

	/* Initialize stack */
	ldr     r0, =_estack
	mov     sp, r0

	/* Call the platform-specific initialization function */
	ldr     r0, =SystemInit
	blx     r0

	ldr     r0, =_sbss
	ldr     r1, =_ebss
	subs    r1, r0
	ble     .Lbss_done

	subs    r2, r2

.Lbss_loop:
	subs    r1, r1, #4
	str     r2, [r0, r1]
	bgt     .Lbss_loop

.Lbss_done:

	ldr     r1,=_sidata
	ldr     r2,=_sdata
	ldr     r3,=_edata

	subs    r3, r2
	ble     .Ldata_done

.Ldata_loop:
	subs    r3, r3, #4
	ldr     r0, [r1, r3]
	str     r0, [r2, r3]
	bgt     .Ldata_loop

.Ldata_done:

	ldr     r0, =main
	bx      r0
	/* The main() should not return, so this should be unreachable */

.bss
.align 3
