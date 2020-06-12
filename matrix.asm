N EQU 3
M EQU 4
P EQU 2

.MODEL small
.STACK
.DATA

matA DB  4,-3,5,1,3,-5,0,11,-5,12,4,-5
matB DB  -2,3,5,-1,4,3,9,-7
matC DW  N*P DUP(?)

.CODE
.STARTUP

    MOV CX, N ;3
    loopN:    
        PUSH CX
        MOV BP, N
        SUB BP, CX 
        MOV AX, M
        MUL BP
        MOV BP, AX
        XOR DI, DI        
        MOV CX, P ;2
        loopP:                                          
            PUSH CX
            
            MOV CX, M ;4
            MOV SI, BP 
            loopM:
                PUSH CX
                XOR AX, AX
                MOV AL, matA[SI]
                MOV DL, matB[DI]
                IMUL DL
                ADD matC+BX, AX
                ADD DI, P
                INC SI
                    
            POP CX
            LOOP loopM
             
        POP CX
        ADD BX, 2
        MOV AH, M
        MOV AL, P
        MUL AH
        SUB DI, AX 
        INC DI
        LOOP loopP        
            
    POP CX
    LOOP loopN
    
.EXIT
END 