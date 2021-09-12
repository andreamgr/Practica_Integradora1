#include <xc.inc>

; CONFIG1L
  CONFIG  PLLDIV = 5            ; PLL Prescaler Selection bits (Divide by 6 (24 MHz oscillator input))
  CONFIG  CPUDIV = OSC3_PLL4    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /3][96 MHz PLL Src: /4])
  CONFIG  USBDIV = 2            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = HSPLL_HS          ; Oscillator Selection bits (XT oscillator (XT))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
;  CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = OFF          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RB3)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)


;*****Definicion de variables***********
PSECT udata
INPUT:
	DS 1
TEMP:
	DS 1
V1:
	DS 1
V2:
	DS 1
V3:
	DS 1
V4:
	DS 1
V5:
	DS 1
AUX:
	DS 1
AUX2:
	DS 1
AUX3:
	DS 1
IMP:
	DS 1
INIT_VALUE:
	DS 1
RESULT:
	DS 1
MIN:
	DS 1
SEGD:
	DS 1
SEGU:
	DS 1
;
;PSECT text,class = CODE


;*****Programa principal *****************
	PSECT   code;barfunc,local,class=CODE,delta=2 ; PIC10/12/16
	
			ORG     0x00             	;reset vector
  			GOTO    MAIN              	;go to the main routine
 
INICIALIZACION:
		    
			MOVLW 0x0F			;todas entradas digitales
			MOVWF ADCON1,c			
			SETF	LATB,c			;PORTB como entrada
			CLRF	LATD,c			;PORTD como salida
			CLRF	LATA,c			;PORTA como salida
			CLRF	LATC,c			;PORTE como salida
			CLRF	LATE,c			;PORTC como salida
			SETF	TRISB,c			;PORTB como entrada
			CLRF	TRISD,c			;PORTD como salida
			CLRF	TRISA,c			;PORTA como salida
			CLRF	TRISE,c			;PORTE como salida
			CLRF	TRISC,c			;PORTE como salida

			MOVLW 180
			MOVWF INIT_VALUE
			MOVLW 0x00
			MOVWF RESULT
			MOVLW 0x00
			MOVWF AUX3
			
			MOVLW 0x00
			MOVWF MIN
			MOVLW 0x00
			MOVWF SEGD
			MOVLW 0x00
			MOVWF SEGU
			RETURN

MAIN:
		CALL 	INICIALIZACION

			
LOOP:
			MOVLW 0
			MOVWF MIN
			MOVWF SEGU
			MOVWF SEGD
			MOVWF RESULT
			
			MOVLW	0xB5		    
			SUBWF	INIT_VALUE,	0,1	    
			BZ	MAXIMO		     
			
			BTFSC PORTB,0
			CALL  PAUSA
			BTFSC PORTB,1
			CALL  PLAY
			BTFSC PORTB,2
			CALL  PRECARGA
		        MOVFF INIT_VALUE, RESULT
			CALL OP
			GOTO LOOP
			
			
			
PRECARGA:
    
		       CALL   DELAY_1DS
		       BTFSC   PORTB,2  
		       GOTO   PRECARGA
		       MOVLW  0
		       CPFSEQ INIT_VALUE		    ;bandera de alto si ya es igual al limite
		       DECF   INIT_VALUE, 1
		       MOVFF INIT_VALUE, RESULT
		       CALL OP
		       RETURN
MAXIMO:
		       MOVLW 0
		       MOVWF INIT_VALUE
		       RETURN
		       
PAUSA:
			MOVLW 0
			MOVWF MIN
			MOVWF SEGU
			MOVWF SEGD
			BTFSC PORTB,1
			GOTO  PLAY
			BTFSC PORTB,2
			GOTO  PRECARGA
		        CALL OP
			GOTO PAUSA
RETURN       
		  
		       
	       
PLAY:
		    
		    MOVF INIT_VALUE, W		;movemos el limite al contador
		    MOVFF INIT_VALUE, RESULT
		    CONTINUAR:
			MOVLW 0
			MOVWF MIN
			MOVWF SEGU
			MOVWF SEGD
			BTFSC PORTB,0
			GOTO  PAUSA
			BTFSC PORTB,1
			GOTO  PLAY
			BTFSC PORTB,2
			GOTO  PRECARGA
		    CALL DELAY
		    DECF	RESULT, 1
		    MOVLW	0
		    CPFSEQ	RESULT
		    GOTO CONTINUAR
		    MOVLW 0
		    MOVWF INIT_VALUE
		    CALL OP
		    RETURN
		    
DELAY:
		    CALL OP
		    CALL DELAY_1S
		   
		    RETURN		    
		    
OP:
			MOVFF  RESULT, IMP
			MOVF   IMP, W
			SUBLW  60
			BN     SET_MINUTOS
			BZ     SET_MINUTOS
		SD:	MOVF   IMP, W
			SUBLW  9		    ;9-impresion 
			BN    SET_SEGUNDOSD	    ;aun es mayor a 9 
		MI:				   
			GOTO  SET_SEGUNDOSU	    ;ponemos segundos unitarios
		
			RETURN
			
SET_MINUTOS:
			MOVLW 60
			SUBWF IMP , 1	    ;el numero que dimos -60
			INCF  MIN, 1	;incrementamos 1 minuto
			MOVLW 59	
			CPFSGT IMP	;impresion sigue siendo mayor que 60?
			GOTO SD		;no
			GOTO  SET_MINUTOS		 ;si; repetir proceso
			
			
SET_SEGUNDOSD:
			MOVLW 10
			SUBWF IMP , 1	    ;el numero que dimos -10
			INCF  SEGD, 1	;incrementamos 1 decimas de segundo
			MOVLW 9	
			CPFSGT IMP	;impresion sigue siendo mayor que 10?
			GOTO MI		    ;no
			GOTO  SET_SEGUNDOSD		 ;si; repetir proceso
			
SET_SEGUNDOSU:

			MOVFF   IMP, SEGU
			
			
			MOVLW	0x00		    ;mover 0 al acumulador
			SUBWF	SEGU,	0,1	    ;restar 0 a la entrada
			BZ	CERO1		    ;caso 0 
			
			MOVLW	0x01		    ;mover 1 al acumulador
			SUBWF	SEGU,	0,1	    ;restar 1 a la entrada
			BZ	UNO1	    ;caso 1 
			
			MOVLW	0x02		    ;mover 2 al acumulador
			SUBWF	SEGU,	W	    ;restar 2 a la entrada
			BZ	DOS1		    ;caso 2 
			
			MOVLW	0x03		    ;mover 3 al acumulador
			SUBWF	SEGU,	W	    ;restar 3 a la entrada
			BZ	TRES1		    ;caso 3 
			
			MOVLW	0x04		    ;mover 4 al acumulador
			SUBWF	SEGU,	W	    ;restar 4 a la entrada
			BZ	CUATRO1		    ;caso 4 
			
			MOVLW	0x05		    ;mover 5 al acumulador
			SUBWF	SEGU,	W	    ;restar 5 a la entrada
			BZ	CINCO1		    ;caso 5 
			
			MOVLW	0x06		    ;mover 6 al acumulador
			SUBWF	SEGU,	W	    ;restar 6 a la entrada
			BZ	SEIS1		    ;caso 6
			
			MOVLW	0x07		    ;mover 7 al acumulador
			SUBWF	SEGU,	W	    ;restar 7 a la entrada
			BZ	SIETE1		    ;caso 7 
			
			MOVLW	0x08		    ;mover 8 al acumulador
			SUBWF	SEGU,	W	    ;restar 8 a la entrada
			BZ	OCHO1		    ;caso 8 
			
			MOVLW	0x09		    ;mover 8 al acumulador
			SUBWF	SEGU,	W	    ;restar 8 a la entrada
			BZ	NUEVE1		    ;caso 8 
			
			
	DECS:				
			
			MOVLW	0x00		    ;mover 0 al acumulador
			SUBWF	SEGD,	0,1	    ;restar 0 a la entrada
			BZ	CERO2		    ;caso 0 
			
			MOVLW	0x01		    ;mover 1 al acumulador
			SUBWF	SEGD,	0,1	    ;restar 1 a la entrada
			BZ	UNO2	    ;caso 1 
			
			MOVLW	0x02		    ;mover 2 al acumulador
			SUBWF	SEGD,	W	    ;restar 2 a la entrada
			BZ	DOS2		    ;caso 2 
			
			MOVLW	0x03		    ;mover 3 al acumulador
			SUBWF	SEGD,	W	    ;restar 3 a la entrada
			BZ	TRES2		    ;caso 3 
			
			MOVLW	0x04		    ;mover 4 al acumulador
			SUBWF	SEGD,	W	    ;restar 4 a la entrada
			BZ	CUATRO2		    ;caso 4 
			
			MOVLW	0x05		    ;mover 5 al acumulador
			SUBWF	SEGD,	W	    ;restar 5 a la entrada
			BZ	CINCO2		    ;caso 5 
			
			MOVLW	0x06		    ;mover 6 al acumulador
			SUBWF	SEGD,	W	    ;restar 6 a la entrada
			BZ	SEIS2		    ;caso 6
			
			MOVLW	0x07		    ;mover 7 al acumulador
			SUBWF	SEGD,	W	    ;restar 7 a la entrada
			BZ	SIETE2		    ;caso 7 
			
			MOVLW	0x08		    ;mover 8 al acumulador
			SUBWF	SEGD,	W	    ;restar 8 a la entrada
			BZ	OCHO2		    ;caso 8 
			
			MOVLW	0x09		    ;mover 8 al acumulador
			SUBWF	SEGD,	W	    ;restar 8 a la entrada
			BZ	NUEVE2		    ;caso 8 
			
			
	MINS:					
			
			MOVLW	0x00		    ;mover 0 al acumulador
			SUBWF	MIN,	0,1	    ;restar 0 a la entrada
			BZ	CERO3		    ;caso 0 
			
			MOVLW	0x01		    ;mover 1 al acumulador
			SUBWF	MIN,	0,1	    ;restar 1 a la entrada
			BZ	UNO3	    ;caso 1 
			
			MOVLW	0x02		    ;mover 2 al acumulador
			SUBWF	MIN,	W	    ;restar 2 a la entrada
			BZ	DOS3		    ;caso 2 
			
			MOVLW	0x03		    ;mover 3 al acumulador
			SUBWF	MIN,	W	    ;restar 3 a la entrada
			BZ	TRES3		    ;caso 3 
			
			MOVLW	0x04		    ;mover 4 al acumulador
			SUBWF	MIN,	W	    ;restar 4 a la entrada
			BZ	CUATRO3		    ;caso 4 
			
			MOVLW	0x05		    ;mover 5 al acumulador
			SUBWF	MIN,	W	    ;restar 5 a la entrada
			BZ	CINCO3		    ;caso 5 
			
			MOVLW	0x06		    ;mover 6 al acumulador
			SUBWF	MIN,	W	    ;restar 6 a la entrada
			BZ	SEIS3		    ;caso 6
			
			MOVLW	0x07		    ;mover 7 al acumulador
			SUBWF	MIN,	W	    ;restar 7 a la entrada
			BZ	SIETE3		    ;caso 7 
			
			MOVLW	0x08		    ;mover 8 al acumulador
			SUBWF	MIN,	W	    ;restar 8 a la entrada
			BZ	OCHO3		    ;caso 8 
			
			MOVLW	0x09		    ;mover 8 al acumulador
			SUBWF	MIN,	W	    ;restar 8 a la entrada
			BZ	NUEVE3		    ;caso 8 
			
			
			
			
		
			
CERO1:
						    ;salida 0 en display
		    MOVLW 00111111B
		    MOVWF PORTD
		    GOTO DECS
		    
UNO1:
		    MOVLW 00000110B		    ;salida 1 en display
		    MOVWF PORTD
		    GOTO DECS		    
DOS1:
		    MOVLW 01011011B		    ;salida 2 en display
		    MOVWF PORTD
GOTO DECS
TRES1:
		    MOVLW 01001111B		   ;salida 3 en display
		    MOVWF PORTD
GOTO DECS
		    
CUATRO1:						  
		    MOVLW 01100110B		    ;salida 4 en display
		    MOVWF PORTD
GOTO DECS
CINCO1:						  
		    MOVLW 01101101B		    ;salida 5 en display
		    MOVWF PORTD
GOTO DECS
		    
SEIS1:						  
		    MOVLW 01111101B		    ;salida 6 en display
		    MOVWF PORTD
GOTO DECS
		    
SIETE1:						  
		    MOVLW 00000111B		    ;salida 7 en display
		    MOVWF PORTD
GOTO DECS
OCHO1:						  
		    MOVLW 01111111B		    ;salida 8 en display
		    MOVWF PORTD
GOTO DECS
NUEVE1:						  
		    MOVLW 01101111B		    ;salida 9 en display
		    MOVWF PORTD
		   GOTO DECS
		    
		   
		   
CERO2:
						    ;salida 0 en display
		    MOVLW 00111111B
		    BCF	  PORTE,0
		    MOVWF PORTA
GOTO MINS
		    
UNO2:
		    MOVLW 00000110B	
		    BCF	  PORTE,0
		    		    ;salida 1 en display
		    MOVWF PORTA
GOTO MINS

		    
DOS2:
		    MOVLW 01011011B		    ;salida 2 en display
		    		    BSF	  PORTE,0
		    MOVWF PORTA
GOTO MINS

TRES2:
		    MOVLW 01001111B		   ;salida 3 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

		    
CUATRO2:						  
		    MOVLW 01100110B		    ;salida 4 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

CINCO2:						  
		    MOVLW 01101101B		    ;salida 5 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

		    
SEIS2:						  
		    MOVLW 01111101B		    ;salida 6 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

		    
SIETE2:						  
		    MOVLW 00000111B		    ;salida 7 en display
		    		    		    BCF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

OCHO2:						  
		    MOVLW 01111111B		    ;salida 8 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
GOTO MINS

NUEVE2:						  
		    MOVLW 01101111B		    ;salida 9 en display
		    		    		    BSF	  PORTE,0

		    MOVWF PORTA
		   GOTO MINS
		    
		   
		   
CERO3:
						    ;salida 0 en display
		    MOVLW 10111111B
		    MOVWF PORTC
RETURN		    
		    
		    
UNO3:
		    MOVLW 00000110B		    ;salida 1 en display
		    MOVWF PORTC
RETURN		    
		    
		    
DOS3:
		    MOVLW 11011011B		    ;salida 2 en display
		    MOVWF PORTC
RETURN		    
		    
TRES3:
		    MOVLW 11001111B		   ;salida 3 en display

		    MOVWF PORTC
RETURN		    
		    
		    
CUATRO3:						  
		    MOVLW 01100110B		    ;salida 4 en display
		    MOVWF PORTC
RETURN		    
		    

CINCO3:						  
		    MOVLW 11101101B		    ;salida 5 en display

		    MOVWF PORTC
RETURN		    
		    

		    
SEIS3:						  
		    MOVLW 11111101B		    ;salida 6 en display
		    MOVWF PORTC
RETURN		    
		    

		    
SIETE3:						  
		    MOVLW 00000111B		    ;salida 7 en display
		    MOVWF PORTC
RETURN		    
		    

OCHO3:						  
		    MOVLW 11111111B		    ;salida 8 en display
		    MOVWF PORTC
RETURN		    
	    
NUEVE3:						  
		    MOVLW 11101111B		    ;salida 9 en display
		    MOVWF PORTC
RETURN		    

		    
		    

    
			
DELAY_1DS:	    
		    MOVLW 255
		    MOVWF TEMP
		    MOVLW 140
		    MOVWF V1
		    MOVLW 3
		    MOVWF AUX2
		    NOP
		    DECFSZ TEMP
		    GOTO $-2
		    DECFSZ V1
		    GOTO $-10
		    DECFSZ AUX2
		    GOTO $-16
		    RETURN

DELAY_5DS:		   
		  
		    MOVLW 5
		    MOVWF V2
		    NOP
		    CALL DELAY_1DS
		    DECFSZ V2
		    GOTO $-6
		    RETURN
DELAY_1S:		   
		  
		    MOVLW 10
		    MOVWF V3
		    NOP
		    CALL DELAY_1DS
		    DECFSZ V3
		    GOTO $-6
		    RETURN
DELAY_5S:		   
		  
		    MOVLW 5
		    MOVWF V4
		    NOP
		    CALL DELAY_1S
		    DECFSZ V4
		    GOTO $-6
		    RETURN
		
DELAY_10S:		   
		  
		    MOVLW 10
		    MOVWF V5
		    NOP
		    CALL DELAY_1S
		    DECFSZ V5
		    GOTO $-6
		    RETURN			    
END