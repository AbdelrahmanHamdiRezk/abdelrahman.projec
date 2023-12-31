.MODEL SMALL
.STACK 100H

.DATA
    ; ???? ?????? ???????? ????????
    amount DW 100

    ; ??? ??? ?????? ??????
    egp_exchange_rate DW 16.5   ; ????????? ?? 1 ????? = 16.5 ???? ????

    ; ??? ??? ??????
    euro_exchange_rate DW 0.85  ; ????????? ?? 1 ????? = 0.85 ????

    ; ???????
    result_egp DW ?
    result_euro DW ?

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; ?????? ??? ???????
    MOV AH, 09H
    LEA DX, prompt
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'   ; ??? ????? ???????? '1' (????? ??? ?????? ??????)
    JE CONVERT_TO_EGP

    CMP AL, '2'   ; ??? ????? ???????? '2' (????? ??? ??????)
    JE CONVERT_TO_EURO

CONVERT_TO_EGP:
    ; ????? ??????? ???????? ??? ?????? ??????
    MOV AX, amount
    MOV BX, egp_exchange_rate
    MUL BX
    DIV egp_exchange_rate
    MOV result_egp, AX

    ; ??? ???????
    MOV AH, 09H
    MOV DX, OFFSET result_egp
    INT 21H
    JMP END_PROGRAM

CONVERT_TO_EURO:
    ; ????? ??????? ???????? ??? ??????
    MOV AX, amount
    MOV BX, euro_exchange_rate
    MUL BX
    DIV euro_exchange_rate
    MOV result_euro, AX

    ; ??? ???????
    MOV AH, 09H
    MOV DX, OFFSET result_euro
    INT 21H

END_PROGRAM:
    MOV AH, 4CH    ; ????? ????????
    INT 21H

prompt DB 'Choose conversion: 1. USD to EGP, 2. USD to Euro$'
