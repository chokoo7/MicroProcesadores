        PROCESSOR   16F887
        #include    <xc.inc>

        CONFIG  FOSC   = INTRC_NOCLKOUT
        CONFIG  WDTE   = OFF
        CONFIG  PWRTE  = ON
        CONFIG  MCLRE  = ON
        CONFIG  CP     = OFF
        CONFIG  CPD    = OFF
        CONFIG  BOREN  = ON
        CONFIG  BOR4V  = BOR40V
        CONFIG  FCMEN  = OFF
        CONFIG  IESO   = OFF
        CONFIG  LVP    = OFF
        CONFIG  WRT    = OFF

        PSECT   resetVec, class=CODE, delta=2
        ORG     0x0000
        GOTO    INIT

        PSECT   intVec, class=CODE, delta=2
        ORG     0x0004
        RETFIE

        PSECT   udata_bank0, space=1
R0:     DS 1
R1:     DS 1

        PSECT   code, class=CODE, delta=2

INIT:
        BANKSEL OSCCON
        MOVLW   0b01110000
        MOVWF   OSCCON

        BANKSEL ANSEL
        CLRF    ANSEL
        CLRF    ANSELH

        BANKSEL TRISB
        CLRF    TRISB
        BANKSEL PORTB
        CLRF    PORTB

MAIN:
        ; Rojo ON, Azul OFF
        BSF     PORTB, 0
        BCF     PORTB, 1
        CALL    DELAY

        ; Rojo OFF, Azul ON
        BCF     PORTB, 0
        BSF     PORTB, 1
        CALL    DELAY

        GOTO    MAIN

DELAY:
        MOVLW   250
        MOVWF   R0
OUTER:
        MOVLW   250
        MOVWF   R1
INNER:
        NOP
        DECFSZ  R1, F
        GOTO    INNER
        DECFSZ  R0, F
        GOTO    OUTER
        RETURN
        END



