#include "stdio.h"
#include "stdint.h"
#include "math.h"

#define LEFT  0b00001000
#define UP    0b00000100
#define DOWN  0b00000010
#define RIGHT 0b00000001

#define MOVE        0x0020  //32
#define DELAY       0x0000  //0
#define obj_width   0x0064  //100
#define obj_height  0x0064  //100
#define scr_width   0x0280  //640
#define scr_height  0x01E0  //480
#define x_min       0x0001
#define x_max       scr_width - obj_width - DELAY
#define y_min       0x0000
#define y_max       scr_height - obj_height

#define TIM0_TIME_MS 10

volatile uint8_t ext0_flag = 0;
volatile uint8_t tim0_flag = 0;

volatile uint8_t input = 0;
volatile uint16_t pixel_x = 270;
volatile uint16_t pixel_y = 190;
volatile int8_t v_x = 1;
volatile int8_t v_y = 1;



volatile unsigned int j, k;

volatile uint16_t position_index = 0;

void delay();
void set_xy();
void draw(volatile uint16_t x, volatile uint16_t y);

void move_with_buttons();
void move_rectangle();
void algorithm_1();
void algorithm_2();
void algorithm_3();

void main(void){

  input = UP;

  while(1){

    if(input == LEFT){
        algorithm_1();
    }
    else if(input == UP){
        algorithm_2();
    }
    else if(input == DOWN){
        algorithm_3();
    }
    else if(input == RIGHT){

    }
    else{
    }
  printf("X: %u   Y: %u\r\n", pixel_x, pixel_y);
  delay();
  }
}

void delay(){
  // volatile unsigned int j, k;
  for(j=0; j<10000; j++)
    for(k=0; k<1000; k++);
}


void algorithm_1(){
  position_index++;
  if (position_index > 300)
    position_index = 0;

  pixel_x = position_index;
  pixel_y = position_index;
}

void algorithm_2(){

  if(pixel_x >= x_max)
    v_x *= -1;
  if(pixel_y >= y_max)
    v_y *= -1;
  if(pixel_x <= x_min)
    v_x *= -1;
  if(pixel_y <= y_min)
    v_y *= -1;

  pixel_x += v_x;
  pixel_y += v_y;
}

#define CENTER_X 300
#define CENTER_Y 150
#define RADIUS_X 100
#define RADIUS_Y 100
#define ANGLE_STEP 0.1
// #define M_PI 3.1415

void algorithm_3() {
    static float angle = 0.0;

    // Calculate new position in a circular path without trigonometric functions
    pixel_x = CENTER_X + (uint16_t)(RADIUS_X * cos(angle));
    pixel_y = CENTER_Y + (uint16_t)(RADIUS_Y * cos(angle));

    // Update angle for the next iteration
    angle += ANGLE_STEP;

    // Wrap the angle to stay within the 0 to 2*pi range
    if (angle > 2 * M_PI) {
        angle -= 2 * M_PI;
    }
}