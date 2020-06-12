N  EQU 4
M  EQU 7
P  EQU 5
PS EQU -32768
NG EQU 32767

.MODEL small
.STACK
.DATA

matA DB  3,14,-15,9,26,-53,5,89,79,3,23,84,-6,26,43,-3,83,27,-9,50,28,-88,41,97,-103,69,39,-9
matB DB  37,-101,0,58,-20,9,74,94,-4,59,-23,90,-78,16,-4,0,-62,86,20,89,9,86,28,0,-34,82,5,34,-21,1,70,-67,9,82,14
matC DW  N*P DUP(?)


.CODE
.STARTUP

    MOV CX, N ;4
    loopN:    
        PUSH CX
        MOV BP, N
        SUB BP, CX 
        MOV AX, M
        MUL BP
        MOV BP, AX
        XOR DI, DI        
        MOV CX, P ;5
        loopP:                                          
            PUSH CX
            
            MOV CX, M ;7
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