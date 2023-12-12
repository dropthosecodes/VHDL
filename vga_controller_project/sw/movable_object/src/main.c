#include "8052.h"
#include "stdio.h"
#include "stdint.h"

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

volatile uint16_t position_index = 0;
volatile uint16_t pixel_x = 100;
volatile uint16_t pixel_y = 100;
volatile int8_t v_x_1 = 1;
volatile int8_t v_y_1 = 1;
volatile int8_t v_x_2 = 0;
volatile int8_t v_y_2 = 0;

void External0_INIT();
void External0_ISR() __interrupt(0);

void TIM0_INIT();
void TIM0_ISR() __interrupt(1);

void set_xy();
void draw(volatile uint16_t x, volatile uint16_t y);

void move_with_buttons();
void algorithm_1();
void algorithm_2();
void algorithm_3();

void main(void){

  External0_INIT();
  TIM0_INIT();

  while(1){

    //input set to fixed algorithm
    input = UP;

    if(input == LEFT){
      if(tim0_flag == 1){
        tim0_flag = 0;
        algorithm_1();
      }
    }
    else if(input == UP){
      if(tim0_flag == 1){
        tim0_flag = 0;
        algorithm_2();
      }
    }
    else if(input == DOWN){
      if(tim0_flag == 1){
        tim0_flag = 0;
        algorithm_3();
      }
    }
    else if(input == RIGHT){

    }
    else{
    }
  }
}

void External0_INIT(){
  EA = 1;
  EX0 = 1;
  IT0 = 1;
}

void External0_ISR() __interrupt(0) {
  input = P3;
  ext0_flag = 1;
}

void TIM0_INIT(){
  // Set Timer 0 in mode 1 (16-bit mode)
  TMOD |= 0x01;   

  //Counter = 2^16 - ( CLK / (12 * 1/time) )
  // 1ms delay
  TH0 = 0xF7;     // Set the high byte of TH0
  TL0 = 0xDC;     // Set the low byte of TL0

  //Enable global interrupts
  EA = 1;

  //Enable TIM0 interrupt
  ET0 = 1;

  //Start TIM0
  TR0 = 1;
}

void TIM0_ISR() __interrupt(1) {
  static uint16_t counter = 0;

  counter++;

  if(counter == TIM0_TIME_MS){
    counter = 0;
    tim0_flag = 1;
  }

  TH0 = 0xF7;     // Set the high byte of TH0
  TL0 = 0xDC;     // Set the low byte of TL0
}

void set_xy(){
  P1 = pixel_x & 0xFF;
  P2 = pixel_y & 0xFF;
  P0 = (((pixel_x >> 8) & 0b00000011)) |
        ((pixel_y >> 2) & 0b11000000);    
}

void draw(volatile uint16_t x, volatile uint16_t y){
  pixel_x = x;
  pixel_y = y;
  set_xy();
}

void move_with_buttons(){
  if(input == LEFT){
    if(pixel_x <= MOVE)
      pixel_x = x_min;
    else
      pixel_x -= MOVE;
    }
  else if(input == UP){
    if(pixel_y <= MOVE)
      pixel_y = y_min;
    else
      pixel_y -= MOVE;
  }
  else if(input == DOWN){
    if(pixel_y >= (y_max - MOVE))
      pixel_y = y_max;
    else
      pixel_y += MOVE;
  }
  else if(input == RIGHT){
    if(pixel_x >= (x_max - MOVE))
      pixel_x = x_max;
    else
      pixel_x += MOVE;
  }
  else{
    pixel_x = 200;
    pixel_y = 200;
  }

  set_xy();
}

void algorithm_1(){
  position_index++;
  if (position_index > 300)
    position_index = 0;

  pixel_x = position_index;
  pixel_y = position_index;
  set_xy();
}

void algorithm_2(){

  if(pixel_x >= x_max)
    v_x_1 *= -1;
  if(pixel_y >= y_max)
    v_y_1 *= -1;
  if(pixel_x <= x_min)
    v_x_1 *= -1;
  if(pixel_y <= y_min)
    v_y_1 *= -1;

  pixel_x += v_x_1;
  pixel_y += v_y_1;

  set_xy();
}

volatile uint8_t falling = 0;
volatile uint8_t rising = 0;

void algorithm_3(){

  if( (v_x_2 == 0) & (v_y_2 == 0) ){
    pixel_x = x_min;
    pixel_y = y_min;
    v_x_2 = 1;
    v_y_2 = 0;
    falling = 1;
  }

  if(falling == 1){
    v_y_2 += 1;
  }
  else if(rising == 1){
    v_y_2 -= 1;
  }
  
  if(pixel_y >= y_max){
    v_y_2 *= -1;
  }
  if(pixel_y <= y_min){
    v_y_2 *= -1;
    rising = 1;
  }

  if(pixel_x >= x_max){
    pixel_x = x_min;
  }

  pixel_x += v_x_2;
  pixel_y += v_y_2;

  set_xy();
}