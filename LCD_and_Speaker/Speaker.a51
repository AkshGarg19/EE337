LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0H
LJMP MAIN

ORG 1BH
LJMP ET1ISR

ORG 50H
ET1ISR: CLR TR1
        CLR TF1
		DEC @R0
        MOV TH1, #3CH
        MOV TL1, #0B0H
        SETB TR1
        RETI

ORG 100H
MAIN:
MOV TMOD, #11H
MOV IE, #88H
ACALL LCD
ACALL SPEAKER
HERE: SJMP HERE

ORG 400H
SPEAKER:
MOV 70H, #30                        // WE USE 25MS DELAY IN T1, SO FOR DIFFERENT ORDERS, DIFFERENT TIMES 25MS DELAY IS HAPPENING
MOV 71H, #30
MOV 72H, #30
MOV 73H, #30
MOV 74H, #40
MOV 75H, #20
MOV 76H, #40
MOV 77H, #40


MOV R0, #70H
MOV TH1, #3CH                       // 25MS
MOV TL1, #0B0H
SETB TR1
LOOP1: ACALL N1
       CJNE @R0, #0, LOOP1
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP2: ACALL N2
       CJNE @R0, #0, LOOP2
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP3: ACALL N3
       CJNE @R0, #0, LOOP3
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP4: ACALL N2
       CJNE @R0, #0, LOOP4
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP5: ACALL N4
       CJNE @R0, #0, LOOP5
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
CLR P0.0
LOOP6: CJNE @R0, #0, LOOP6
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP7: ACALL N4
       CJNE @R0, #0, LOOP7
CLR TR1

INC R0
MOV TH1, #3CH
MOV TL1, #0B0H
SETB TR1
LOOP8: ACALL N5
       CJNE @R0, #0, LOOP8
CLR TR1

LJMP SPEAKER



N1: MOV TH0, #0EEH
    MOV TL0, #3FH
	SETB P0.7
    SETB TR0
    AGAIN: JNB TF0, AGAIN
    CLR TR0
    CLR TF0
	CLR P0.7
	MOV TH0, #0EEH
    MOV TL0, #3FH
    SETB TR0
    AGAIN1: JNB TF0, AGAIN1
    CLR TR0
    CLR TF0
	RET
	
N2: MOV TH0, #0F0H
    MOV TL0, #30H
	SETB P0.7
    SETB TR0
    AGAIN2: JNB TF0, AGAIN2
    CLR TR0
    CLR TF0
	CLR P0.7
	MOV TH0, #0F0H
    MOV TL0, #30H
    SETB TR0
    AGAIN3: JNB TF0, AGAIN3
    CLR TR0
    CLR TF0
	RET
	
N3: MOV TH0, #0F2H
    MOV TL0, #0B7H
	SETB P0.7
    SETB TR0
    AGAIN4: JNB TF0, AGAIN4
    CLR TR0
    CLR TF0
	CLR P0.7
	MOV TH0, #0F2H
    MOV TL0, #0B7H
    SETB TR0
    AGAIN5: JNB TF0, AGAIN5
    CLR TR0
    CLR TF0
	RET
	
N4: MOV TH0, #0F5H
    MOV TL0, #72H
	SETB P0.7
    SETB TR0
    AGAIN6: JNB TF0, AGAIN6
    CLR TR0
    CLR TF0
	CLR P0.7
	MOV TH0, #0F5H
    MOV TL0, #72H
    SETB TR0
    AGAIN7: JNB TF0, AGAIN7
    CLR TR0
    CLR TF0
	RET
	
N5: MOV TH0, #0F4H
    MOV TL0, #2AH
	SETB P0.7
    SETB TR0
    AGAIN8: JNB TF0, AGAIN8
    CLR TR0
    CLR TF0
	CLR P0.7
	MOV TH0, #0F4H
    MOV TL0, #2AH
    SETB TR0
    AGAIN9: JNB TF0, AGAIN9
    CLR TR0
    CLR TF0
	RET

RET


org 200h
LCD:
      mov P2,#00h
      mov P1,#00h
	  ;initial delay for lcd power up

	;here1:setb p1.0
      	  acall delay
	;clr p1.0
	  acall delay
	;sjmp here1


	  acall lcd_init      ;initialise LCD
	
	  acall delay
	  acall delay
	  acall delay
	  mov a, #10000010B		 ;Put cursor on first row,3 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr, #my_string1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay

RET				

;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine

;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	push 0e0h
	lcd_sendstring_loop:
	 	 clr   a                 ;clear Accumulator for any previous data
	         movc  a,@a+dptr         ;load the first character in accumulator
	         jz    exit              ;go to exit if zero
	         acall lcd_senddata      ;send first char
	         inc   dptr              ;increment data pointer
	         sjmp  LCD_sendstring_loop    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop9:	 mov r1,#255
	 loop:	 djnz r1, loop
	 djnz r0, loop9
	 pop 1
	 pop 0 
	 ret


;------------- ROM text strings---------------------------------------------------------------
org 300h
my_string1:
         DB   "ROLLING TIME", 00H

			 

END