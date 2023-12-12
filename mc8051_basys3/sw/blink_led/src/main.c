// Blink LED Program for mc8051 IP Core Demo Design 
// Author: Peter Roessler
// Date: 2017-02-08

#include "8052.h"
#include "stdio.h"

void delay(){
  volatile unsigned int j, k;
  for(j=0; j<100; j++)
    for(k=0; k<1000; k++);
}

void main(void)
{
  volatile unsigned int i1;//, i2;

  // blink fast, for ModelSim simulation
  for (i1=0; i1<10; i1++)
  {
    P2 = 0xFF; // set all eight P2 port pins to logic 1  
    P2 = 0x00; // set all eight P2 port pins to logic 0
  }

  // blink slow, for execution on real hardware
  // while(1)
  // {
  //   P2 = 0xFF; // set all eight P2 port pins to logic 1
       
  //   // soft delay
  //   for(i1=0; i1<500; i1++)
  //     for(i2=0; i2<1000; i2++);

  //   P2 = 0x00; // set all eight P2 port pins to logic 0
       
  //   // soft delay
  //   for(i1=0; i1<500; i1++)
  //     for(i2=0; i2<1000; i2++);
  // }

  while(1){
    P2 = 0x01;
    delay();
    P2 = 0x02;
    delay();
    P2 = 0x04;
    delay();
    P2 = 0x08;
    delay();
    P2 = 0x10;
    delay();
    P2 = 0x20;
    delay();
    P2 = 0x40;
    delay();
    P2 = 0x80;
    delay();
  }
}



