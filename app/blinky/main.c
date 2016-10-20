/* Standard includes. */
#include <stdio.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#include "stm32l1xx.h"
#include "string.h"

/* Taske priorities */
#define mainLED_TASK_PRIORITY			( tskIDLE_PRIORITY + 1)
#define mainLED_TASK_STACK_SIZE			( configMINIMAL_STACK_SIZE )

/* Control definitions */
#define GET_BTN_STATE() GPIO_ReadInputDataBit(btn_port, btn_pin)
#define SET_LED_STATE(state) GPIO_WriteBit(led_port, led_pin, state)
#define TOGGLE_LED_STATE() GPIO_ToggleBits(led_port, led_pin)
#define LED_ON    1
#define LED_OFF   0

/* Static data */
static volatile int32_t tmp_cnt = 0;
static QueueHandle_t queue = 0;

static GPIO_TypeDef* led_port = GPIOA;
static const uint16_t led_pin = GPIO_Pin_5;
static GPIO_TypeDef* btn_port = GPIOC;
static const uint16_t btn_pin = GPIO_Pin_13;

/* Functions prototypes */
static void prvBTNTask( void *pvParameters );
static void prvLEDTask( void *pvParameters );
static void hwInit(void);

int main( void )
{
	hwInit();

	if(0 == (queue = xQueueCreate(40, sizeof(uint32_t))))
    {
    	for(;;);
    }

	if(pdPASS == xTaskCreate( prvLEDTask, "LED", mainLED_TASK_STACK_SIZE, NULL, mainLED_TASK_PRIORITY, NULL ) &&
	   pdPASS == xTaskCreate( prvBTNTask, "BTN", mainLED_TASK_STACK_SIZE, NULL, mainLED_TASK_PRIORITY, NULL ))
	{
		vTaskStartScheduler();
	}

	for( ;; );
	return 0;
}

/* Button polling task*/
static void prvBTNTask( void *pvParameters )
{
    uint32_t item = 5;

    for(;;)
    {
        if(0 == GET_BTN_STATE())
        {
            xQueueSend(queue, (void *)&item, 0);
            if(++item > 10)
            {
                item = 5;
            }
            vTaskDelay(100);
        }
        vTaskDelay(50);
    }
}

/* Led control task */
static void prvLEDTask( void *pvParameters )
{
    uint32_t buf = 0;

    SET_LED_STATE(LED_ON);
    vTaskDelay(300);
    SET_LED_STATE(LED_OFF);
    /* Forever loop */
    for(;;)
    {
        if(pdTRUE == xQueueReceive(queue, &buf, 0))
        {
            SET_LED_STATE(LED_OFF);
            vTaskDelay(300);

            while(buf--)
            {
                SET_LED_STATE(LED_ON);
                vTaskDelay(50);
                SET_LED_STATE(LED_OFF);
                vTaskDelay(300);
            }
        }else
        {
            TOGGLE_LED_STATE();
            vTaskDelay(50);
        }
    }
}

static void hwInit(void)
{
	GPIO_InitTypeDef gpioInit;

	/* Initialize LED */
	RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, ENABLE);

	gpioInit.GPIO_Mode = GPIO_Mode_OUT;
	gpioInit.GPIO_OType = GPIO_OType_PP;
	gpioInit.GPIO_Pin = led_pin;
	gpioInit.GPIO_PuPd = GPIO_PuPd_NOPULL;
	gpioInit.GPIO_Speed = GPIO_Speed_40MHz;

	GPIO_Init(led_port, &gpioInit);

	/* Initialise the button */
	RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);

	gpioInit.GPIO_Mode = GPIO_Mode_IN;
	gpioInit.GPIO_OType = GPIO_OType_PP;
	gpioInit.GPIO_Pin = btn_pin;
	gpioInit.GPIO_PuPd = GPIO_PuPd_UP;
	gpioInit.GPIO_Speed = GPIO_Speed_400KHz;

	GPIO_Init(btn_port, &gpioInit);
}
