
#define FUNCTION(x) .global x; .type x,%function; .thumb_func; x:

.text
.syntax unified
.cpu TARGET_CPU
.fpu TARGET_FPU
.thumb

.section .text.boot
.global _platform_init
.weak   _platform_init

.global _start

.section .isr_vector

_extable_start:

_reset:
	.word   __bootstrap_stack_top
	.word   _start

	/* rest of exception table here */
	.word   _UnhandledFault         // 0x08 NMI
	.word   _HardFault              // 0x0c HardFault
	.word   _MemManage              // 0x10 MemManage
	.word   _BusFault               // 0x14 BusFault
	.word   _UsageFault             // 0x18 UsageFault
	.word   _UnhandledFault         // 0x1c Reserved
	.word   _UnhandledFault         // 0x20 Reserved
	.word   _UnhandledFault         // 0x24 Reserved
	.word   _UnhandledFault         // 0x28 Reserved
	.word   _SVCall                 // 0x2c SVCall
	.word   _DebugMon               // 0x30 DebugMon
	.word   _UnhandledFault         // 0x34 Reserved
	.word   _PendSV                 // 0x38 PendSV
	.word   _SysTick                // 0x3c SysTick

	/* platform supplies the rest of the table */
#include "@IRQ_TABLE_FILE@"

.global _extable_end
_extable_end:

.section .text.boot

#include "@IRQ_HANDLERS_FILE@"

FUNCTION(_start)
	cpsid i

	/* Initialize the bootstrap stack */
	ldr     r0, =__bootstrap_stack_top
	mov     sp, r0

	/* Call the platform-specific initialization function */
	ldr     r0, =_platform_init
	blx     r0

	ldr     r0, =__bss_start_ram
	ldr     r1, =__bss_end_ram
	subs    r1, r0
	ble     .Lbss_done

	subs    r2, r2

.Lbss_loop:
	subs    r1, r1, #4
	str     r2, [r0, r1]
	bgt     .Lbss_loop

.Lbss_done:

#ifdef TARGET_NEEDS_DATA_SECTION_COPY
	/* On multi-segment targets the .data section needs to be copied from ROM to
	 * RAM in order to be read/write accessible */

	ldr     r1,=__data_start_rom
	ldr     r2,=__data_start_ram
	ldr     r3,=__data_end_ram

	subs    r3, r2
	ble     .Ldata_done

.Ldata_loop:
	subs    r3, r3, #4
	ldr     r0, [r1, r3]
	str     r0, [r2, r3]
	bgt     .Ldata_loop

.Ldata_done:
#endif

#ifdef TARGET_NEEDS_STACK_PREFILL
	/* Pre-fill the bootstrap stack with pre-defined pattern for debugging if that
	 * requested */

#ifndef TARGET_STACK_PREFILL_MAGIC
#define TARGET_STACK_PREFILL_MAGIC 0xE7E7E7E7
#endif

	mov     r0, sp
	ldr     r1, =TARGET_STACK_PREFILL_MAGIC
	ldr     r2, =__bootstrap_stack_bottom
	sub     r3, r0, r2
	ble     .Lstack_done

.Lstack_loop:
	subs    r3, r3, #4
	str     r1, [r2, r3]
	bgt     .Lstack_loop

.Lstack_done:
#endif

	ldr     r0, =main
	bx      r0
	/* The main() should not return, so this should be unreachable */

FUNCTION(_platform_init)
	bx      lr

.global _k_uos_irq_handler
/*
 * The main kernel IRQ handler entry.
 * Must be here to make weak reference work as necessary
 */
FUNCTION(_k_uos_irq_dispatch)
	mrs     r0, IPSR
	uxtb    r0, r0
	subs    r0, #16
	b       _k_uos_irq_handler

/* Assemble literal pool immediately */
.ltorg

.bss
.align 3

.section .stack
.align 3

#ifdef TARGET_BOOTSTRAP_STACK_SIZE
.equ    StackSize, TARGET_BOOTSTRAP_STACK_SIZE
#else
.equ    StackSize, 0x400
#endif

/* The bootstrap stack MUST be a multiple of 4 bytes and MUST be aligned to 4 bytes boundary. */
	.space StackSize

.section .data
.align 3
