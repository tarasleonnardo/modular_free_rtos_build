#include "led_control.h"
#include "stm32l1xx_rcc.h"
#include "stm32l1xx_gpio.h"
#include "stdint.h"
#include "stdio.h"

static uint16_t const GPIO_PinsArr[GPIO_PinAll + 1] =
{
	GPIO_Pin_0, GPIO_Pin_1, GPIO_Pin_2, GPIO_Pin_3, GPIO_Pin_5,
	GPIO_Pin_5, GPIO_Pin_6, GPIO_Pin_7, GPIO_Pin_8, GPIO_Pin_9,
	GPIO_Pin_10, GPIO_Pin_11, GPIO_Pin_12, GPIO_Pin_13, GPIO_Pin_14,
	GPIO_Pin_15, GPIO_Pin_All
};

#define GPIO_PIN(x) (((uint16_t)(x) <= (GPIO_PinAll)) ? GPIO_PinsArr[x] : 0xF0)

static GPIO_TypeDef* const GPIO_PortsPtrsArr[GPIO_PortsNum] =
{
	GPIOA,
	GPIOB,
	GPIOC,
	GPIOD,
	GPIOE,
	GPIOF,
	GPIOG
};

#define GPIO_PORT(x) (((x) < GPIO_PortsNum) ? GPIO_PortsPtrsArr[x] : NULL)

static void GPIO_RccEnable(GPIO_Ports GPIOx);

void GPIO_InitPin(GPIO_Ports GPIOx, uint16_t pin, GPIO_Modes mode)
{
	GPIO_InitTypeDef pin_init;

	pin_init.GPIO_Pin = GPIO_PIN(pin);
	pin_init.GPIO_Speed = GPIO_Speed_40MHz;

	switch(mode)
	{
		case GPIO_ModeOutPP:
			pin_init.GPIO_Mode = GPIO_Mode_OUT;
			pin_init.GPIO_OType = GPIO_OType_PP;
			break;
		case GPIO_ModeOutOD:
			pin_init.GPIO_Mode = GPIO_Mode_OUT;
			pin_init.GPIO_OType = GPIO_OType_OD;
			break;
		case GPIO_ModeInPD:
			pin_init.GPIO_Mode = GPIO_Mode_IN;
			pin_init.GPIO_PuPd = GPIO_PuPd_DOWN;
			break;
		case GPIO_ModeInPU:
			pin_init.GPIO_Mode = GPIO_Mode_IN;
			pin_init.GPIO_PuPd = GPIO_PuPd_UP;
			break;
		case GPIO_ModeInA:
			pin_init.GPIO_Mode = GPIO_Mode_AN;
			break;
		case GPIO_ModeAF:
			pin_init.GPIO_Mode = GPIO_Mode_AF;
			break;
		default:
			pin_init.GPIO_Mode = GPIO_Mode_IN;
			pin_init.GPIO_PuPd = GPIO_PuPd_DOWN;
	}

	GPIO_RccEnable(GPIOx);
	/* Initialize the port */
	GPIO_Init(GPIO_PORT(GPIOx), &pin_init);
}

void GPIO_InitPinOutPP(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_InitPin(GPIOx, pin, GPIO_ModeOutPP);
}

void GPIO_InitPinOutOD(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_InitPin(GPIOx, pin, GPIO_ModeOutOD);
}

void GPIO_InitPinInPD(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_InitPin(GPIOx, pin, GPIO_ModeInPD);
}

void GPIO_InitPinInPU(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_InitPin(GPIOx, pin, GPIO_ModeInPU);
}

void GPIO_InitPinInA(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_InitPin(GPIOx, pin, GPIO_ModeInA);
}

uint8_t GPIO_ReadPin(GPIO_Ports GPIOx, uint16_t pin)
{
	return GPIO_ReadInputDataBit(GPIO_PORT(GPIOx), GPIO_PIN(pin));
}

void GPIO_SetPin(GPIO_Ports GPIOx, uint16_t pin, uint8_t state)
{
	GPIO_WriteBit(GPIO_PORT(GPIOx), GPIO_PIN(pin), (BitAction)state);
}

void GPIO_SetPinHigh(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_SetBits(GPIO_PORT(GPIOx), GPIO_PIN(pin));
}

void GPIO_SetPinLow(GPIO_Ports GPIOx, uint16_t pin)
{
	GPIO_ResetBits(GPIO_PORT(GPIOx), GPIO_PIN(pin));
}

void GPIO_SetPinToggle(GPIO_Ports GPIOx, uint16_t pin)
{
	if(0 == GPIO_ReadInputDataBit(GPIO_PORT(GPIOx), GPIO_PIN(pin)))
	{
		GPIO_SetBits(GPIO_PORT(GPIOx), GPIO_PIN(pin));
	}else
	{
		GPIO_ResetBits(GPIO_PORT(GPIOx), GPIO_PIN(pin));
	}

}

/********************************************/
/*            Static functions              */
/********************************************/
static void GPIO_RccEnable(GPIO_Ports GPIOx)
{
	/* Enable corresponding port */
	switch(GPIOx)
	{
		case GPIO_PortA:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, ENABLE);
		break;
		case GPIO_PortB:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
		break;
		case GPIO_PortC:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
		break;
		case GPIO_PortD:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOD, ENABLE);
		break;
		case GPIO_PortE:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOE, ENABLE);
		break;
		case GPIO_PortF:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOF, ENABLE);
		break;
		case GPIO_PortG:
			RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOG, ENABLE);
		break;
		case GPIO_PortsNum:
		default:
			break;
	}
}
