#ifndef _GPIO_H_
#define _GPIO_H_

#include "stdint.h"

#ifdef __cplusplus
extern "C"
{
#endif

typedef enum
{
	GPIO_PortA = 0,
	GPIO_PortB,
	GPIO_PortC,
	GPIO_PortD,
	GPIO_PortE,
	GPIO_PortF,
	GPIO_PortG,
	GPIO_PortsNum
}GPIO_Ports;

typedef enum
{
	GPIO_ModeOutPP = 0,	/* Output push-pull */
	GPIO_ModeOutOD,			/* Output open-drain */
	GPIO_ModeInPD,			/* Input pull-down */
	GPIO_ModeInPU,			/* Input pull-up */
	GPIO_ModeInA,				/* Input analog */
	GPIO_ModeAF					/* Alternative function */
}GPIO_Modes;

typedef enum
{
	GPIO_Pin0,
	GPIO_Pin1,
	GPIO_Pin2,
	GPIO_Pin3,
	GPIO_Pin4,
	GPIO_Pin5,
	GPIO_Pin6,
	GPIO_Pin7,
	GPIO_Pin8,
	GPIO_Pin9,
	GPIO_Pin10,
	GPIO_Pin11,
	GPIO_Pin12,
	GPIO_Pin13,
	GPIO_Pin14,
	GPIO_Pin15,
	GPIO_PinAll,
}GPIO_Pins;

void GPIO_InitPin(GPIO_Ports GPIOx, uint16_t pin, GPIO_Modes mode);
void GPIO_InitPinOutPP(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_InitPinOutOD(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_InitPinInPD(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_InitPinInPU(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_InitPinInA(GPIO_Ports GPIOx, uint16_t pin);
uint8_t GPIO_ReadPin(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_SetPin(GPIO_Ports GPIOx, uint16_t pin, uint8_t state);
void GPIO_SetPinHigh(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_SetPinLow(GPIO_Ports GPIOx, uint16_t pin);
void GPIO_SetPinToggle(GPIO_Ports GPIOx, uint16_t pin);


#ifdef __cplusplus
}
#endif
#endif
