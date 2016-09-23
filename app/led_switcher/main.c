/* Standard includes. */
#include <stdio.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "string.h"
#include "led_control.h"

/* The priorities assigned to the tasks. */
#define mainLED_TASK_PRIORITY			( tskIDLE_PRIORITY + 1)

/* The LCD task uses printf() so requires more stack than most of the other
tasks. */
#define mainLED_TASK_STACK_SIZE			( configMINIMAL_STACK_SIZE )

volatile int32_t tmp_cnt = 0;
QueueHandle_t queue = 0;

/*
 * The task that handles the uIP stack.  All TCP/IP processing is performed in
 * this task.
 */

static void prvBTNTask( void *pvParameters );
static void prvLEDTask( void *pvParameters );

/*-----------------------------------------------------------*/
int __attribute__((visibility("default")))
main( void )
{


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

/*-----------------------------------------------------------*/
static void prvBTNTask( void *pvParameters )
{
	uint32_t item = 1;

	GPIO_InitPinInPU(GPIO_PortC, GPIO_Pin13);


	  for(;;)
	  {
#if 1
		if(0 == GPIO_ReadPin(GPIO_PortC, GPIO_Pin13))
		{
			xQueueSend(queue, (void *)&item, 0);
			if(++item > 5)
			{
				item = 1;
			}

			vTaskDelay(100);
		}else
		{

		}
#endif
		vTaskDelay(100);
	  }
}

/*-----------------------------------------------------------*/
static void prvLEDTask( void *pvParameters )
{
	uint32_t buf = 0;

	GPIO_InitPinOutPP(GPIO_PortA, GPIO_Pin5);


	  /* Forever loop */
	  for(;;)
	  {
		  if(pdTRUE == xQueueReceive(queue, &buf, portMAX_DELAY))
		  {
			  GPIO_SetPinToggle(GPIO_PortA, GPIO_Pin5);
		  }
	  }
}
