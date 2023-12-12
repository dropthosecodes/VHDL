;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _TF2
	.globl _EXF2
	.globl _RCLK
	.globl _TCLK
	.globl _EXEN2
	.globl _TR2
	.globl _C_T2
	.globl _CP_RL2
	.globl _T2CON_7
	.globl _T2CON_6
	.globl _T2CON_5
	.globl _T2CON_4
	.globl _T2CON_3
	.globl _T2CON_2
	.globl _T2CON_1
	.globl _T2CON_0
	.globl _PT2
	.globl _ET2
	.globl _CY
	.globl _AC
	.globl _F0
	.globl _RS1
	.globl _RS0
	.globl _OV
	.globl _F1
	.globl _P
	.globl _PS
	.globl _PT1
	.globl _PX1
	.globl _PT0
	.globl _PX0
	.globl _RD
	.globl _WR
	.globl _T1
	.globl _T0
	.globl _INT1
	.globl _INT0
	.globl _TXD
	.globl _RXD
	.globl _P3_7
	.globl _P3_6
	.globl _P3_5
	.globl _P3_4
	.globl _P3_3
	.globl _P3_2
	.globl _P3_1
	.globl _P3_0
	.globl _EA
	.globl _ES
	.globl _ET1
	.globl _EX1
	.globl _ET0
	.globl _EX0
	.globl _P2_7
	.globl _P2_6
	.globl _P2_5
	.globl _P2_4
	.globl _P2_3
	.globl _P2_2
	.globl _P2_1
	.globl _P2_0
	.globl _SM0
	.globl _SM1
	.globl _SM2
	.globl _REN
	.globl _TB8
	.globl _RB8
	.globl _TI
	.globl _RI
	.globl _P1_7
	.globl _P1_6
	.globl _P1_5
	.globl _P1_4
	.globl _P1_3
	.globl _P1_2
	.globl _P1_1
	.globl _P1_0
	.globl _TF1
	.globl _TR1
	.globl _TF0
	.globl _TR0
	.globl _IE1
	.globl _IT1
	.globl _IE0
	.globl _IT0
	.globl _P0_7
	.globl _P0_6
	.globl _P0_5
	.globl _P0_4
	.globl _P0_3
	.globl _P0_2
	.globl _P0_1
	.globl _P0_0
	.globl _TH2
	.globl _TL2
	.globl _RCAP2H
	.globl _RCAP2L
	.globl _T2CON
	.globl _B
	.globl _ACC
	.globl _PSW
	.globl _IP
	.globl _P3
	.globl _IE
	.globl _P2
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
	.globl _rising
	.globl _falling
	.globl _draw_PARM_2
	.globl _v_y_2
	.globl _v_x_2
	.globl _v_y_1
	.globl _v_x_1
	.globl _pixel_y
	.globl _pixel_x
	.globl _position_index
	.globl _input
	.globl _tim0_flag
	.globl _ext0_flag
	.globl _External0_INIT
	.globl _External0_ISR
	.globl _TIM0_INIT
	.globl _TIM0_ISR
	.globl _set_xy
	.globl _draw
	.globl _move_with_buttons
	.globl _algorithm_1
	.globl _algorithm_2
	.globl _algorithm_3
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_B	=	0x00f0
_T2CON	=	0x00c8
_RCAP2L	=	0x00ca
_RCAP2H	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
_ET2	=	0x00ad
_PT2	=	0x00bd
_T2CON_0	=	0x00c8
_T2CON_1	=	0x00c9
_T2CON_2	=	0x00ca
_T2CON_3	=	0x00cb
_T2CON_4	=	0x00cc
_T2CON_5	=	0x00cd
_T2CON_6	=	0x00ce
_T2CON_7	=	0x00cf
_CP_RL2	=	0x00c8
_C_T2	=	0x00c9
_TR2	=	0x00ca
_EXEN2	=	0x00cb
_TCLK	=	0x00cc
_RCLK	=	0x00cd
_EXF2	=	0x00ce
_TF2	=	0x00cf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_ext0_flag::
	.ds 1
_tim0_flag::
	.ds 1
_input::
	.ds 1
_position_index::
	.ds 2
_pixel_x::
	.ds 2
_pixel_y::
	.ds 2
_v_x_1::
	.ds 1
_v_y_1::
	.ds 1
_v_x_2::
	.ds 1
_v_y_2::
	.ds 1
_TIM0_ISR_counter_1_29:
	.ds 2
_draw_PARM_2:
	.ds 2
_draw_x_1_32:
	.ds 2
_falling::
	.ds 1
_rising::
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
_algorithm_3_sloc0_1_0:
	.ds 1
_algorithm_3_sloc1_1_0:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	ljmp	_External0_ISR
	.ds	5
	ljmp	_TIM0_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
;------------------------------------------------------------
;Allocation info for local variables in function 'TIM0_ISR'
;------------------------------------------------------------
;counter                   Allocated with name '_TIM0_ISR_counter_1_29'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:117: static uint16_t counter = 0;
	clr	a
	mov	_TIM0_ISR_counter_1_29,a
	mov	(_TIM0_ISR_counter_1_29 + 1),a
;	../../sw/movable_object/src/main.c:23: volatile uint8_t ext0_flag = 0;
	mov	_ext0_flag,#0x00
;	../../sw/movable_object/src/main.c:24: volatile uint8_t tim0_flag = 0;
	mov	_tim0_flag,#0x00
;	../../sw/movable_object/src/main.c:26: volatile uint8_t input = 0;
	mov	_input,#0x00
;	../../sw/movable_object/src/main.c:28: volatile uint16_t position_index = 0;
	clr	a
	mov	_position_index,a
	mov	(_position_index + 1),a
;	../../sw/movable_object/src/main.c:29: volatile uint16_t pixel_x = 100;
	mov	_pixel_x,#0x64
;	1-genFromRTrack replaced	mov	(_pixel_x + 1),#0x00
	mov	(_pixel_x + 1),a
;	../../sw/movable_object/src/main.c:30: volatile uint16_t pixel_y = 100;
	mov	_pixel_y,#0x64
;	1-genFromRTrack replaced	mov	(_pixel_y + 1),#0x00
	mov	(_pixel_y + 1),a
;	../../sw/movable_object/src/main.c:31: volatile int8_t v_x_1 = 1;
	mov	_v_x_1,#0x01
;	../../sw/movable_object/src/main.c:32: volatile int8_t v_y_1 = 1;
	mov	_v_y_1,#0x01
;	../../sw/movable_object/src/main.c:33: volatile int8_t v_x_2 = 0;
;	1-genFromRTrack replaced	mov	_v_x_2,#0x00
	mov	_v_x_2,a
;	../../sw/movable_object/src/main.c:34: volatile int8_t v_y_2 = 0;
;	1-genFromRTrack replaced	mov	_v_y_2,#0x00
	mov	_v_y_2,a
;	../../sw/movable_object/src/main.c:203: volatile uint8_t falling = 0;
;	1-genFromRTrack replaced	mov	_falling,#0x00
	mov	_falling,a
;	../../sw/movable_object/src/main.c:204: volatile uint8_t rising = 0;
;	1-genFromRTrack replaced	mov	_rising,#0x00
	mov	_rising,a
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	ljmp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:50: void main(void){
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
;	../../sw/movable_object/src/main.c:52: External0_INIT();
	lcall	_External0_INIT
;	../../sw/movable_object/src/main.c:53: TIM0_INIT();
	lcall	_TIM0_INIT
;	../../sw/movable_object/src/main.c:55: while(1){
00117$:
;	../../sw/movable_object/src/main.c:58: input = UP;
	mov	_input,#0x04
;	../../sw/movable_object/src/main.c:60: if(input == LEFT){
	mov	a,#0x08
	cjne	a,_input,00114$
;	../../sw/movable_object/src/main.c:61: if(tim0_flag == 1){
	mov	a,#0x01
	cjne	a,_tim0_flag,00117$
;	../../sw/movable_object/src/main.c:62: tim0_flag = 0;
	mov	_tim0_flag,#0x00
;	../../sw/movable_object/src/main.c:63: algorithm_1();
	lcall	_algorithm_1
	sjmp	00117$
00114$:
;	../../sw/movable_object/src/main.c:66: else if(input == UP){
	mov	a,#0x04
	cjne	a,_input,00111$
;	../../sw/movable_object/src/main.c:67: if(tim0_flag == 1){
	mov	a,#0x01
	cjne	a,_tim0_flag,00117$
;	../../sw/movable_object/src/main.c:68: tim0_flag = 0;
	mov	_tim0_flag,#0x00
;	../../sw/movable_object/src/main.c:69: algorithm_2();
	lcall	_algorithm_2
	sjmp	00117$
00111$:
;	../../sw/movable_object/src/main.c:72: else if(input == DOWN){
	mov	a,#0x02
	cjne	a,_input,00108$
;	../../sw/movable_object/src/main.c:73: if(tim0_flag == 1){
	mov	a,#0x01
	cjne	a,_tim0_flag,00117$
;	../../sw/movable_object/src/main.c:74: tim0_flag = 0;
	mov	_tim0_flag,#0x00
;	../../sw/movable_object/src/main.c:75: algorithm_3();
	lcall	_algorithm_3
	sjmp	00117$
00108$:
;	../../sw/movable_object/src/main.c:78: else if(input == RIGHT){
	mov	a,_input
	sjmp	00117$
;------------------------------------------------------------
;Allocation info for local variables in function 'External0_INIT'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:86: void External0_INIT(){
;	-----------------------------------------
;	 function External0_INIT
;	-----------------------------------------
_External0_INIT:
;	../../sw/movable_object/src/main.c:87: EA = 1;
	setb	_EA
;	../../sw/movable_object/src/main.c:88: EX0 = 1;
	setb	_EX0
;	../../sw/movable_object/src/main.c:89: IT0 = 1;
	setb	_IT0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'External0_ISR'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:92: void External0_ISR() __interrupt(0) {
;	-----------------------------------------
;	 function External0_ISR
;	-----------------------------------------
_External0_ISR:
;	../../sw/movable_object/src/main.c:93: input = P3;
	mov	_input,_P3
;	../../sw/movable_object/src/main.c:94: ext0_flag = 1;
	mov	_ext0_flag,#0x01
	reti
;	eliminated unneeded mov psw,# (no regs used in bank)
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'TIM0_INIT'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:97: void TIM0_INIT(){
;	-----------------------------------------
;	 function TIM0_INIT
;	-----------------------------------------
_TIM0_INIT:
;	../../sw/movable_object/src/main.c:99: TMOD |= 0x01;   
	orl	_TMOD,#0x01
;	../../sw/movable_object/src/main.c:103: TH0 = 0xF7;     // Set the high byte of TH0
	mov	_TH0,#0xf7
;	../../sw/movable_object/src/main.c:104: TL0 = 0xDC;     // Set the low byte of TL0
	mov	_TL0,#0xdc
;	../../sw/movable_object/src/main.c:107: EA = 1;
	setb	_EA
;	../../sw/movable_object/src/main.c:110: ET0 = 1;
	setb	_ET0
;	../../sw/movable_object/src/main.c:113: TR0 = 1;
	setb	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'TIM0_ISR'
;------------------------------------------------------------
;counter                   Allocated with name '_TIM0_ISR_counter_1_29'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:116: void TIM0_ISR() __interrupt(1) {
;	-----------------------------------------
;	 function TIM0_ISR
;	-----------------------------------------
_TIM0_ISR:
	push	acc
	push	psw
;	../../sw/movable_object/src/main.c:119: counter++;
	inc	_TIM0_ISR_counter_1_29
	clr	a
	cjne	a,_TIM0_ISR_counter_1_29,00108$
	inc	(_TIM0_ISR_counter_1_29 + 1)
00108$:
;	../../sw/movable_object/src/main.c:121: if(counter == TIM0_TIME_MS){
	mov	a,#0x0a
	cjne	a,_TIM0_ISR_counter_1_29,00109$
	clr	a
	cjne	a,(_TIM0_ISR_counter_1_29 + 1),00109$
	sjmp	00110$
00109$:
	sjmp	00102$
00110$:
;	../../sw/movable_object/src/main.c:122: counter = 0;
	clr	a
	mov	_TIM0_ISR_counter_1_29,a
	mov	(_TIM0_ISR_counter_1_29 + 1),a
;	../../sw/movable_object/src/main.c:123: tim0_flag = 1;
	mov	_tim0_flag,#0x01
00102$:
;	../../sw/movable_object/src/main.c:126: TH0 = 0xF7;     // Set the high byte of TH0
	mov	_TH0,#0xf7
;	../../sw/movable_object/src/main.c:127: TL0 = 0xDC;     // Set the low byte of TL0
	mov	_TL0,#0xdc
	pop	psw
	pop	acc
	reti
;	eliminated unneeded mov psw,# (no regs used in bank)
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'set_xy'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:130: void set_xy(){
;	-----------------------------------------
;	 function set_xy
;	-----------------------------------------
_set_xy:
;	../../sw/movable_object/src/main.c:131: P1 = pixel_x & 0xFF;
	mov	r6,_pixel_x
	mov	a,(_pixel_x + 1)
	mov	_P1,r6
;	../../sw/movable_object/src/main.c:132: P2 = pixel_y & 0xFF;
	mov	r6,_pixel_y
	mov	a,(_pixel_y + 1)
	mov	_P2,r6
;	../../sw/movable_object/src/main.c:133: P0 = (((pixel_x >> 8) & 0b00000011)) |
	mov	r7,(_pixel_x + 1)
	anl	ar7,#0x03
;	../../sw/movable_object/src/main.c:134: ((pixel_y >> 2) & 0b11000000);    
	mov	r5,_pixel_y
	mov	a,(_pixel_y + 1)
	clr	c
	rrc	a
	xch	a,r5
	rrc	a
	xch	a,r5
	clr	c
	rrc	a
	xch	a,r5
	rrc	a
	xch	a,r5
	anl	ar5,#0xc0
	mov	r6,#0x00
	mov	a,r7
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,r7
	orl	ar5,a
	mov	a,r4
	orl	ar6,a
	mov	_P0,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'draw'
;------------------------------------------------------------
;y                         Allocated with name '_draw_PARM_2'
;x                         Allocated with name '_draw_x_1_32'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:137: void draw(volatile uint16_t x, volatile uint16_t y){
;	-----------------------------------------
;	 function draw
;	-----------------------------------------
_draw:
	mov	_draw_x_1_32,dpl
	mov	(_draw_x_1_32 + 1),dph
;	../../sw/movable_object/src/main.c:138: pixel_x = x;
	mov	_pixel_x,_draw_x_1_32
	mov	(_pixel_x + 1),(_draw_x_1_32 + 1)
;	../../sw/movable_object/src/main.c:139: pixel_y = y;
	mov	_pixel_y,_draw_PARM_2
	mov	(_pixel_y + 1),(_draw_PARM_2 + 1)
;	../../sw/movable_object/src/main.c:140: set_xy();
	ljmp	_set_xy
;------------------------------------------------------------
;Allocation info for local variables in function 'move_with_buttons'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:143: void move_with_buttons(){
;	-----------------------------------------
;	 function move_with_buttons
;	-----------------------------------------
_move_with_buttons:
;	../../sw/movable_object/src/main.c:144: if(input == LEFT){
	mov	a,#0x08
	cjne	a,_input,00123$
;	../../sw/movable_object/src/main.c:145: if(pixel_x <= MOVE)
	clr	c
	mov	a,#0x20
	subb	a,_pixel_x
	clr	a
	subb	a,(_pixel_x + 1)
	jc	00102$
;	../../sw/movable_object/src/main.c:146: pixel_x = x_min;
	mov	_pixel_x,#0x01
	mov	(_pixel_x + 1),#0x00
	ljmp	00124$
00102$:
;	../../sw/movable_object/src/main.c:148: pixel_x -= MOVE;
	mov	a,_pixel_x
	add	a,#0xe0
	mov	_pixel_x,a
	mov	a,(_pixel_x + 1)
	addc	a,#0xff
	mov	(_pixel_x + 1),a
	ljmp	00124$
00123$:
;	../../sw/movable_object/src/main.c:150: else if(input == UP){
	mov	a,#0x04
	cjne	a,_input,00120$
;	../../sw/movable_object/src/main.c:151: if(pixel_y <= MOVE)
	clr	c
	mov	a,#0x20
	subb	a,_pixel_y
	clr	a
	subb	a,(_pixel_y + 1)
	jc	00105$
;	../../sw/movable_object/src/main.c:152: pixel_y = y_min;
	clr	a
	mov	_pixel_y,a
	mov	(_pixel_y + 1),a
	sjmp	00124$
00105$:
;	../../sw/movable_object/src/main.c:154: pixel_y -= MOVE;
	mov	a,_pixel_y
	add	a,#0xe0
	mov	_pixel_y,a
	mov	a,(_pixel_y + 1)
	addc	a,#0xff
	mov	(_pixel_y + 1),a
	sjmp	00124$
00120$:
;	../../sw/movable_object/src/main.c:156: else if(input == DOWN){
	mov	a,#0x02
	cjne	a,_input,00117$
;	../../sw/movable_object/src/main.c:157: if(pixel_y >= (y_max - MOVE))
	clr	c
	mov	a,_pixel_y
	subb	a,#0x5c
	mov	a,(_pixel_y + 1)
	subb	a,#0x01
	jc	00108$
;	../../sw/movable_object/src/main.c:158: pixel_y = y_max;
	mov	_pixel_y,#0x7c
	mov	(_pixel_y + 1),#0x01
	sjmp	00124$
00108$:
;	../../sw/movable_object/src/main.c:160: pixel_y += MOVE;
	mov	a,#0x20
	add	a,_pixel_y
	mov	_pixel_y,a
	clr	a
	addc	a,(_pixel_y + 1)
	mov	(_pixel_y + 1),a
	sjmp	00124$
00117$:
;	../../sw/movable_object/src/main.c:162: else if(input == RIGHT){
	mov	a,#0x01
	cjne	a,_input,00114$
;	../../sw/movable_object/src/main.c:163: if(pixel_x >= (x_max - MOVE))
	clr	c
	mov	a,_pixel_x
	subb	a,#0xfc
	mov	a,(_pixel_x + 1)
	subb	a,#0x01
	jc	00111$
;	../../sw/movable_object/src/main.c:164: pixel_x = x_max;
	mov	_pixel_x,#0x1c
	mov	(_pixel_x + 1),#0x02
	sjmp	00124$
00111$:
;	../../sw/movable_object/src/main.c:166: pixel_x += MOVE;
	mov	a,#0x20
	add	a,_pixel_x
	mov	_pixel_x,a
	clr	a
	addc	a,(_pixel_x + 1)
	mov	(_pixel_x + 1),a
	sjmp	00124$
00114$:
;	../../sw/movable_object/src/main.c:169: pixel_x = 200;
	mov	_pixel_x,#0xc8
	mov	(_pixel_x + 1),#0x00
;	../../sw/movable_object/src/main.c:170: pixel_y = 200;
	mov	_pixel_y,#0xc8
	mov	(_pixel_y + 1),#0x00
00124$:
;	../../sw/movable_object/src/main.c:173: set_xy();
	ljmp	_set_xy
;------------------------------------------------------------
;Allocation info for local variables in function 'algorithm_1'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:176: void algorithm_1(){
;	-----------------------------------------
;	 function algorithm_1
;	-----------------------------------------
_algorithm_1:
;	../../sw/movable_object/src/main.c:177: position_index++;
	mov	a,#0x01
	add	a,_position_index
	mov	_position_index,a
	clr	a
	addc	a,(_position_index + 1)
	mov	(_position_index + 1),a
;	../../sw/movable_object/src/main.c:178: if (position_index > 300)
	clr	c
	mov	a,#0x2c
	subb	a,_position_index
	mov	a,#0x01
	subb	a,(_position_index + 1)
	jnc	00102$
;	../../sw/movable_object/src/main.c:179: position_index = 0;
	clr	a
	mov	_position_index,a
	mov	(_position_index + 1),a
00102$:
;	../../sw/movable_object/src/main.c:181: pixel_x = position_index;
	mov	_pixel_x,_position_index
	mov	(_pixel_x + 1),(_position_index + 1)
;	../../sw/movable_object/src/main.c:182: pixel_y = position_index;
	mov	_pixel_y,_position_index
	mov	(_pixel_y + 1),(_position_index + 1)
;	../../sw/movable_object/src/main.c:183: set_xy();
	ljmp	_set_xy
;------------------------------------------------------------
;Allocation info for local variables in function 'algorithm_2'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:186: void algorithm_2(){
;	-----------------------------------------
;	 function algorithm_2
;	-----------------------------------------
_algorithm_2:
;	../../sw/movable_object/src/main.c:188: if(pixel_x >= x_max)
	clr	c
	mov	a,_pixel_x
	subb	a,#0x1c
	mov	a,(_pixel_x + 1)
	subb	a,#0x02
;	../../sw/movable_object/src/main.c:189: v_x_1 *= -1;
	jc	00102$
	clr	a
	subb	a,_v_x_1
	mov	_v_x_1,a
00102$:
;	../../sw/movable_object/src/main.c:190: if(pixel_y >= y_max)
	clr	c
	mov	a,_pixel_y
	subb	a,#0x7c
	mov	a,(_pixel_y + 1)
	subb	a,#0x01
;	../../sw/movable_object/src/main.c:191: v_y_1 *= -1;
	jc	00104$
	clr	a
	subb	a,_v_y_1
	mov	_v_y_1,a
00104$:
;	../../sw/movable_object/src/main.c:192: if(pixel_x <= x_min)
	clr	c
	mov	a,#0x01
	subb	a,_pixel_x
	clr	a
	subb	a,(_pixel_x + 1)
;	../../sw/movable_object/src/main.c:193: v_x_1 *= -1;
	jc	00106$
	clr	a
	subb	a,_v_x_1
	mov	_v_x_1,a
00106$:
;	../../sw/movable_object/src/main.c:194: if(pixel_y <= y_min)
	mov	a,_pixel_y
	orl	a,(_pixel_y + 1)
	jnz	00108$
;	../../sw/movable_object/src/main.c:195: v_y_1 *= -1;
	clr	c
	clr	a
	subb	a,_v_y_1
	mov	_v_y_1,a
00108$:
;	../../sw/movable_object/src/main.c:197: pixel_x += v_x_1;
	mov	r6,_v_x_1
	mov	a,_v_x_1
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,_pixel_x
	mov	_pixel_x,a
	mov	a,r7
	addc	a,(_pixel_x + 1)
	mov	(_pixel_x + 1),a
;	../../sw/movable_object/src/main.c:198: pixel_y += v_y_1;
	mov	r6,_v_y_1
	mov	a,_v_y_1
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,_pixel_y
	mov	_pixel_y,a
	mov	a,r7
	addc	a,(_pixel_y + 1)
	mov	(_pixel_y + 1),a
;	../../sw/movable_object/src/main.c:200: set_xy();
	ljmp	_set_xy
;------------------------------------------------------------
;Allocation info for local variables in function 'algorithm_3'
;------------------------------------------------------------
;	../../sw/movable_object/src/main.c:206: void algorithm_3(){
;	-----------------------------------------
;	 function algorithm_3
;	-----------------------------------------
_algorithm_3:
;	../../sw/movable_object/src/main.c:208: if( (v_x_2 == 0) & (v_y_2 == 0) ){
	mov	a,_v_x_2
	cjne	a,#0x01,00134$
00134$:
	mov	_algorithm_3_sloc0_1_0,c
	mov	a,_v_y_2
	cjne	a,#0x01,00135$
00135$:
	mov	_algorithm_3_sloc1_1_0,c
	mov	c,_algorithm_3_sloc0_1_0
	anl	c,_algorithm_3_sloc1_1_0
	jnc	00102$
;	../../sw/movable_object/src/main.c:209: pixel_x = x_min;
	mov	_pixel_x,#0x01
;	../../sw/movable_object/src/main.c:210: pixel_y = y_min;
	clr	a
	mov	(_pixel_x + 1),a
	mov	_pixel_y,a
	mov	(_pixel_y + 1),a
;	../../sw/movable_object/src/main.c:211: v_x_2 = 1;
	mov	_v_x_2,#0x01
;	../../sw/movable_object/src/main.c:212: v_y_2 = 0;
;	1-genFromRTrack replaced	mov	_v_y_2,#0x00
	mov	_v_y_2,a
;	../../sw/movable_object/src/main.c:213: falling = 1;
	mov	_falling,#0x01
00102$:
;	../../sw/movable_object/src/main.c:216: if(falling == 1){
	mov	a,#0x01
	cjne	a,_falling,00106$
;	../../sw/movable_object/src/main.c:217: v_y_2 += 1;
	inc	_v_y_2
	sjmp	00107$
00106$:
;	../../sw/movable_object/src/main.c:219: else if(rising == 1){
	mov	a,#0x01
	cjne	a,_rising,00107$
;	../../sw/movable_object/src/main.c:220: v_y_2 -= 1;
	dec	_v_y_2
00107$:
;	../../sw/movable_object/src/main.c:223: if(pixel_y >= y_max){
	clr	c
	mov	a,_pixel_y
	subb	a,#0x7c
	mov	a,(_pixel_y + 1)
	subb	a,#0x01
;	../../sw/movable_object/src/main.c:224: v_y_2 *= -1;
	jc	00109$
	clr	a
	subb	a,_v_y_2
	mov	_v_y_2,a
00109$:
;	../../sw/movable_object/src/main.c:226: if(pixel_y <= y_min){
	mov	a,_pixel_y
	orl	a,(_pixel_y + 1)
	jnz	00111$
;	../../sw/movable_object/src/main.c:227: v_y_2 *= -1;
	clr	c
	clr	a
	subb	a,_v_y_2
	mov	_v_y_2,a
;	../../sw/movable_object/src/main.c:228: rising = 1;
	mov	_rising,#0x01
00111$:
;	../../sw/movable_object/src/main.c:231: if(pixel_x >= x_max){
	clr	c
	mov	a,_pixel_x
	subb	a,#0x1c
	mov	a,(_pixel_x + 1)
	subb	a,#0x02
	jc	00113$
;	../../sw/movable_object/src/main.c:232: pixel_x = x_min;
	mov	_pixel_x,#0x01
	mov	(_pixel_x + 1),#0x00
00113$:
;	../../sw/movable_object/src/main.c:235: pixel_x += v_x_2;
	mov	r6,_v_x_2
	mov	a,_v_x_2
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,_pixel_x
	mov	_pixel_x,a
	mov	a,r7
	addc	a,(_pixel_x + 1)
	mov	(_pixel_x + 1),a
;	../../sw/movable_object/src/main.c:236: pixel_y += v_y_2;
	mov	r6,_v_y_2
	mov	a,_v_y_2
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,_pixel_y
	mov	_pixel_y,a
	mov	a,r7
	addc	a,(_pixel_y + 1)
	mov	(_pixel_y + 1),a
;	../../sw/movable_object/src/main.c:238: set_xy();
	ljmp	_set_xy
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
