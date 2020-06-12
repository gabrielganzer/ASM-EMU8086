DIM1      EQU 20	; min number of entries      
DIM2	  EQU 50	; max number of entries 
DIM3	  EQU 52	; dimensioni of occurence array 
ENTER     EQU 13	; ascii code for carriage return
SPACE     EQU 32	; ascii code for space key
K1        EQU 1		; parameter k1 Caesar cipher
K2        EQU 2		; parameter k2 Caesar cipher
K3        EQU 3		; parameter k3 Caesar cipher
K4        EQU 4		; parameter k4 Caesar cipher

.MODEL small
.STACK
.DATA

first_line DB DIM2 DUP(?)   ; my_string array
second_line DB DIM2 DUP(?)  ; my_string array
third_line DB DIM2 DUP(?)   ; my_string array
fourth_line DB DIM2 DUP(?)  ; my_string array
1st_occur DB DIM3 DUP(0)    ; occurence array
2nd_occur DB DIM3 DUP(0)    ; occurence array
3rd_occur DB DIM3 DUP(0)    ; occurence array
4th_occur DB DIM3 DUP(0)    ; occurence array
DIMS1 DW 0		            ; number of entries 1st line
DIMS2 DW 0		            ; number of entries 2nd line
DIMS3 DW 0		            ; number of entries 3rd line
DIMS4 DW 0		            ; number of entries 4th line 
max_char DB ?               ; maximum number of occurrences  
index DW ? 		            ; index variable

.CODE
.STARTUP
 
; 1. Read in input a short text of 4 lines, each of these lines long from 20 to 50 characters
;Print "Line1: "
    MOV AH,2
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4CH ; L         
    INT 21H
    MOV DL,31H ; 1        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H
;Geting 1st line
get1:  
    MOV CX,DIM2
    MOV DI,0
    MOV AH,1
loop_get1:  
    INT 21H  
    CMP AL,ENTER       ; verify if the user input the enter key
    JE end_get1	  ; if input is ENTER it would jump to END_ROW1
    MOV first_line[DI],AL
    INC DI      
    INC DIMS1
    DEC CX
    CMP CX,0
    JNZ loop_get1 ; if CX is 0, than all 50 were acquired, otherwise cotinue entry
end_get1:
    CMP DI,DIM1		
    JL loop_get1:           ; if DI is less than DIM1 it would jump to lab1 continuing entry        

;Print "Line2: "
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4CH ; L               
    INT 21H
    MOV DL,32H ; 2        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H
;Geting 2nd line
get2:  
    MOV CX,DIM2
    MOV DI,0
    MOV AH,1
loop_get2:  
    INT 21H  
    CMP AL,ENTER       ; verify if the user input the enter key
    JE end_get2	  ; if input is ENTER it would jump to END_ROW1
    MOV second_line[DI],AL
    INC DI      
    INC DIMS2
    DEC CX
    CMP CX,0
    JNZ loop_get2 ; if CX is 0, than all 50 were acquired, otherwise cotinue entry
end_get2:
    CMP DI,DIM1		
    JL loop_get2:           ; if DI is less than DIM1 it would jump to lab1 continuing entry        

;Print "Line3: "
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4CH ; L         
    INT 21H
    MOV DL,33H ; 3        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H
;Geting 3rd line
get3:  
    MOV CX,DIM2
    MOV DI,0
    MOV AH,1
loop_get3:  
    INT 21H  
    CMP AL,ENTER       ; verify if the user input the enter key
    JE end_get3	  ; if input is ENTER it would jump to END_ROW1
    MOV third_line[DI],AL
    INC DI      
    INC DIMS3
    DEC CX
    CMP CX,0
    JNZ loop_get3 ; if CX is 0, than all 50 were acquired, otherwise cotinue entry
end_get3:
    CMP DI,DIM1		
    JL loop_get3:           ; if DI is less than DIM1 it would jump to lab1 continuing entry        

;Print "Line4: "
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4CH ; L         
    INT 21H
    MOV DL,34H ; 4        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H
;Geting 4th line
get4:  
    MOV CX,DIM2
    MOV DI,0
    MOV AH,1
loop_get4:  
    INT 21H  
    CMP AL,ENTER       ; verify if the user input the enter key
    JE end_get4	  ; if input is ENTER it would jump to END_ROW1
    MOV fourth_line[DI],AL
    INC DI      
    INC DIMS4
    DEC CX
    CMP CX,0
    JNZ loop_get4 ; if CX is 0, than all 50 were acquired, otherwise cotinue entry
end_get4:
    CMP DI,DIM1		
    JL loop_get4:           ; if DI is less than DIM1 it would jump to lab1 continuing entry        

;2. Count number of occurrences of the letters
     
;Print "Max_1: "    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4DH ; M        
    INT 21H
    MOV DL,61H ; a       
    INT 21H
    MOV DL,78H ; x        
    INT 21H
    MOV DL,31H ; 1        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H         
;Fill occurence array1
    MOV CX,DIMS1
    MOV DI,0  
    XOR AX,AX 
fill1:
    MOV AL,first_line[DI]
    CMP AL,41h ; A 
    JL end_fill1; before A = invalid
    CMP AL,7Ah ; z 
    JG end_fill1; after z = invalid
    CMP AL,5Ah ; Z
    JLE upper_op1 ;after A and before Z = valid and upper case
    CMP AL,61h ; a
    JL  end_fill1;after A, after Z and before a = invalid
    JMP lower_op1
upper_op1:
    MOV BL,41h ; 'A'
    SUB AL,BL  ;char - 'A'         
    MOV BL,AL    
    MOV BH,0
    INC 1st_occur[BX+26]    
    JMP end_fill1
lower_op1:
    MOV BL,61h ;   'a'     
    SUB AL,BL  ;char - 'a'/'A'         
    MOV BL,AL    
    MOV BH,0
    INC 1st_occur[BX]
    JMP end_fill1
end_fill1:
    INC DI      
    DEC CX
    CMP CX,0
    JNZ fill1
    JMP freq1
;Find most frequent character     
freq1:
     MOV DI, 0
     MOV AL,1st_occur[DI]
     MOV index,DI
     MOV CX, DIM3-1 ; DIM2 == 26
     MOV DI, 1  
find1:CMP AL,1st_occur[DI]
     JAE pass1
     MOV AL,1st_occur[DI] 
     MOV index,DI;INDEX is a variable to track the max value position
pass1:INC DI
     DEC CX
     CMP CX,0             
     JNZ find1
     MOV max_char,AL ;MAX_CHAR is the charater with max occurences 
;Print the list of most frequent characters     
     MOV DI, 0
list1:      
     MOV CL, 1st_occur[DI]
     CMP CL, max_char
     JE cheking1
loop_list1:      
     INC DI
     CMP DI, DIM3
     JB  list1
     JMP max_2     
output1:
     MOV index, CX
     MOV AH,2
     MOV DX, index         
     INT 21H
     JMP loop_list1
cheking1:
     MOV CX,DI         
     CMP CX,DIM3/2
     JB  lower_max1
     JAE upper_max1
upper_max1:
     ADD CX,27h      ; index + 'A'
     JMP output1
lower_max1:
     ADD CX,61h      ; index + 'a'
     JMP output1

;Print "Max_2: "
max_2:    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4DH ; M        
    INT 21H
    MOV DL,61H ; a       
    INT 21H
    MOV DL,78H ; x        
    INT 21H
    MOV DL,32H ; 2        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H         
;Fill occurence array2
    MOV CX,DIMS2
    MOV DI,0
    MOV max_char, 0
    MOV index, 0  
    XOR AX,AX 
fill2:
    MOV AL,second_line[DI]
    CMP AL,41h ; A 
    JL end_fill2; before A = invalid
    CMP AL,7Ah ; z 
    JG end_fill2; after z = invalid
    CMP AL,5Ah ; Z
    JLE upper_op2 ;after A and before Z = valid and upper case
    CMP AL,61h ; a
    JL  end_fill2;after A, after Z and before a = invalid
    JMP lower_op2
upper_op2:
    MOV BL,41h ; 'A'
    SUB AL,BL  ;char - 'A'         
    MOV BL,AL    
    MOV BH,0
    INC 2nd_occur[BX+26]    
    JMP end_fill2
lower_op2:
    MOV BL,61h ;   'a'     
    SUB AL,BL  ;char - 'a'/'A'         
    MOV BL,AL    
    MOV BH,0
    INC 2nd_occur[BX]
    JMP end_fill2
end_fill2:
    INC DI      
    DEC CX
    CMP CX,0
    JNZ fill2
    JMP freq2
;Find most frequent character     
freq2:
     MOV DI, 0
     MOV AL,2nd_occur[DI]
     MOV index,DI
     MOV CX, DIM3-1 ; DIM2 == 26
     MOV DI, 1  
find2:
     CMP AL,2nd_occur[DI]
     JAE pass2
     MOV AL,2nd_occur[DI] 
     MOV index,DI;INDEX is a variable to track the max value position
pass2:
     INC DI
     DEC CX
     CMP CX,0             
     JNZ find2
     MOV max_char,AL ;MAX_CHAR is the charater with max occurences 
;Print the list of most frequent characters     
     MOV DI, 0
list2:      
     MOV CL, 2nd_occur[DI]
     CMP CL, max_char
     JE cheking2
loop_list2:      
     INC DI
     CMP DI, DIM3
     JB  list2
     JMP max_3:     
output2:
     MOV index, CX
     MOV AH,2
     MOV DX, index         
     INT 21H
     JMP loop_list2
cheking2:
     MOV CX,DI         
     CMP CX,DIM3/2
     JB  lower_max2
     JAE upper_max2
upper_max2:
     ADD CX,27h      ; index + 'A'
     JMP output2
lower_max2:
     ADD CX,61h      ; index + 'a'
     JMP output2

;Print "Max_3: "
max_3:    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4DH ; M        
    INT 21H
    MOV DL,61H ; a       
    INT 21H
    MOV DL,78H ; x        
    INT 21H
    MOV DL,33H ; 3        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H         
;Fill occurence array3
    MOV CX,DIMS3
    MOV DI,0
    MOV max_char, 0
    MOV index, 0  
    XOR AX,AX 
fill3:
    MOV AL,third_line[DI]
    CMP AL,41h ; A 
    JL end_fill3; before A = invalid
    CMP AL,7Ah ; z 
    JG end_fill3; after z = invalid
    CMP AL,5Ah ; Z
    JLE upper_op3 ;after A and before Z = valid and upper case
    CMP AL,61h ; a
    JL  end_fill3;after A, after Z and before a = invalid
    JMP lower_op3
upper_op3:
    MOV BL,41h ; 'A'
    SUB AL,BL  ;char - 'A'         
    MOV BL,AL    
    MOV BH,0
    INC 3rd_occur[BX+26]    
    JMP end_fill3
lower_op3:
    MOV BL,61h ;   'a'     
    SUB AL,BL  ;char - 'a'/'A'         
    MOV BL,AL    
    MOV BH,0
    INC 3rd_occur[BX]
    JMP end_fill3
end_fill3:
    INC DI      
    DEC CX
    CMP CX,0
    JNZ fill3
    JMP freq3
;Find most frequent character     
freq3:
     MOV DI, 0
     MOV AL,3rd_occur[DI]
     MOV index,DI
     MOV CX, DIM3-1 ; DIM2 == 26
     MOV DI, 1  
find3:
     CMP AL,3rd_occur[DI]
     JAE pass3
     MOV AL,3rd_occur[DI] 
     MOV index,DI;INDEX is a variable to track the max value position
pass3:
     INC DI
     DEC CX
     CMP CX,0             
     JNZ find3
     MOV max_char,AL ;MAX_CHAR is the charater with max occurences 
;Print the list of most frequent characters     
     MOV DI, 0
list3:      
     MOV CL, 3rd_occur[DI]
     CMP CL, max_char
     JE cheking3
loop_list3:      
     INC DI
     CMP DI, DIM3
     JB  list3
     JMP max_4:     
output3:
     MOV index, CX
     MOV AH,2
     MOV DX, index         
     INT 21H
     JMP loop_list3
cheking3:
     MOV CX,DI         
     CMP CX,DIM3/2
     JB  lower_max3
     JAE upper_max3
upper_max3:
     ADD CX,27h      ; index + 'A'
     JMP output3
lower_max3:
     ADD CX,61h      ; index + 'a'
     JMP output3

;Print "Max_4: "
max_4:    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,4DH ; M        
    INT 21H
    MOV DL,61H ; a       
    INT 21H
    MOV DL,78H ; x        
    INT 21H
    MOV DL,34H ; 4        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H         
;Fill occurence array4
    MOV CX,DIMS4
    MOV DI,0
    MOV max_char, 0
    MOV index, 0  
    XOR AX,AX 
fill4:
    MOV AL,fourth_line[DI]
    CMP AL,41h ; A 
    JL end_fill4; before A = invalid
    CMP AL,7Ah ; z 
    JG end_fill4; after z = invalid
    CMP AL,5Ah ; Z
    JLE upper_op4 ;after A and before Z = valid and upper case
    CMP AL,61h ; a
    JL  end_fill4;after A, after Z and before a = invalid
    JMP lower_op4
upper_op4:
    MOV BL,41h ; 'A'
    SUB AL,BL  ;char - 'A'         
    MOV BL,AL    
    MOV BH,0
    INC 4th_occur[BX+26]    
    JMP end_fill4
lower_op4:
    MOV BL,61h ;   'a'     
    SUB AL,BL  ;char - 'a'/'A'         
    MOV BL,AL    
    MOV BH,0
    INC 4th_occur[BX]
    JMP end_fill4
end_fill4:
    INC DI      
    DEC CX
    CMP CX,0
    JNZ fill4
    JMP freq4
;Find most frequent character     
freq4:
     MOV DI, 0
     MOV AL,4th_occur[DI]
     MOV index,DI
     MOV CX, DIM3-1 ; DIM2 == 26
     MOV DI, 1  
find4:
     CMP AL,4th_occur[DI]
     JAE pass4
     MOV AL,4th_occur[DI] 
     MOV index,DI;INDEX is a variable to track the max value position
pass4:
     INC DI
     DEC CX
     CMP CX,0             
     JNZ find4
     MOV max_char,AL ;MAX_CHAR is the charater with max occurences 
;Print the list of most frequent characters     
     MOV DI, 0
list4:      
     MOV CL, 4th_occur[DI]
     CMP CL, max_char
     JE cheking4
loop_list4:      
     INC DI
     CMP DI, DIM3
     JB  list4
     JMP set_caesar1:     
output4:
     MOV index, CX
     MOV AH,2
     MOV DX, index         
     INT 21H
     JMP loop_list4
cheking4:
     MOV CX,DI         
     CMP CX,DIM3/2
     JB  lower_max4
     JAE upper_max4
upper_max4:
     ADD CX,27h      ; index + 'A'
     JMP output4
lower_max4:
     ADD CX,61h      ; index + 'a'
     JMP output4
       
;3. Apply a cryptographic algorithm.

;Encrypt first line
set_caesar1:
    MOV CX,DIMS1
    MOV DI,0  
    XOR AX,AX 
caesar1:
    MOV AL,first_line[DI]
    CMP AL,41h ; A 
    JL end_test_caesar1
    CMP AL,7Ah ; z 
    JG end_test_caesar1
    CMP AL,5Ah ; Z
    JLE upper_case1
    CMP AL,61h ; a
    JL  end_test_caesar1 
    MOV BL,7Ah 
test_caesar1:
    ADD AL,K1; letter + k
    CMP AL,7Ah
    JG modulo2_1        
    MOV first_line[DI],AL    
end_test_caesar1:    
    INC DI      
    DEC CX
    CMP CX,0
    JNZ caesar1 
    JMP end_caesar1
upper_case1:
    ADD AL,K1; letter + k
    CMP AL,5Ah
    JG modulo1_1 
    MOV first_line[DI],AL
    JMP end_test_caesar1 
modulo1_1:
    ADD AL,6  ; after z -> A
    MOV first_line[DI],AL  
    JMP end_test_caesar1    
modulo2_1: 
    MOV BL,58
    SUB AL,BL ; after Z -> a
    MOV first_line[DI],AL
    JMP end_test_caesar1
end_caesar1:
;Print "Encrypted_1: "    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,45H ; E        
    INT 21H        
    MOV DL,31H ; 1        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H          
;Print crypted characters         
    MOV DI, 0 
    MOV CX,DIMS1
printf1:
    MOV AH,2
    MOV DL,first_line[DI]         
    INT 21H 
    INC DI
    DEC CX
    CMP CX,0             
    JNZ printf1
    JMP set_caesar2

;Encrypt second line
set_caesar2:
    MOV CX,DIMS2
    MOV DI,0  
    XOR AX,AX 
caesar2:
    MOV AL,second_line[DI]
    CMP AL,41h ; A 
    JL end_test_caesar2
    CMP AL,7Ah ; z 
    JG end_test_caesar2
    CMP AL,5Ah ; Z
    JLE upper_case2
    CMP AL,61h ; a
    JL  end_test_caesar2 
    MOV BL,7Ah 
test_caesar2:
    ADD AL,K2; letter + k
    CMP AL,7Ah
    JG modulo2_2        
    MOV second_line[DI],AL    
end_test_caesar2:    
    INC DI      
    DEC CX
    CMP CX,0
    JNZ caesar2 
    JMP end_caesar2
upper_case2:
    ADD AL,K2; letter + k
    CMP AL,5Ah
    JG modulo1_2 
    MOV second_line[DI],AL
    JMP end_test_caesar2 
modulo1_2:
    ADD AL,6  ; after z -> A
    MOV second_line[DI],AL  
    JMP end_test_caesar2    
modulo2_2: 
    MOV BL,58
    SUB AL,BL ; after Z -> a
    MOV second_line[DI],AL
    JMP end_test_caesar2    
end_caesar2:
;Print "Encrypted_2: "    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,45H ; E        
    INT 21H
    MOV DL,32H ; 2        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H          
;Print crypted characters         
    MOV DI, 0 
    MOV CX,DIMS2
printf2:
    MOV AH,2
    MOV DL,second_line[DI]         
    INT 21H 
    INC DI
    DEC CX
    CMP CX,0             
    JNZ printf2
    JMP set_caesar3

;Encrypt third line
set_caesar3:
    MOV CX,DIMS3
    MOV DI,0  
    XOR AX,AX 
caesar3:
    MOV AL,third_line[DI]
    CMP AL,41h ; A 
    JL end_test_caesar3
    CMP AL,7Ah ; z 
    JG end_test_caesar3
    CMP AL,5Ah ; Z
    JLE upper_case3
    CMP AL,61h ; a
    JL  end_test_caesar3 
    MOV BL,7Ah 
test_caesar3:
    ADD AL,K3; letter + k
    CMP AL,7Ah
    JG modulo2_3        
    MOV third_line[DI],AL    
end_test_caesar3:    
    INC DI      
    DEC CX
    CMP CX,0
    JNZ caesar3 
    JMP end_caesar3
upper_case3:
    ADD AL,K3; letter + k
    CMP AL,5Ah
    JG modulo1_3 
    MOV third_line[DI],AL
    JMP end_test_caesar3 
modulo1_3:
    ADD AL,6  ; after z -> A
    MOV third_line[DI],AL  
    JMP end_test_caesar3    
modulo2_3: 
    MOV BL,58
    SUB AL,BL ; after Z -> a
    MOV third_line[DI],AL
    JMP end_test_caesar3
end_caesar3:
;Print "Encrypted_3: "    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,45H ; E        
    INT 21H
    MOV DL,33H ; 3        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H          
;Print crypted characters         
    MOV DI, 0 
    MOV CX,DIMS3
printf3:
    MOV AH,2
    MOV DL,third_line[DI]         
    INT 21H 
    INC DI
    DEC CX
    CMP CX,0             
    JNZ printf3
    JMP set_caesar4
 
;Encrypt fourth line
set_caesar4:
    MOV CX,DIMS4
    MOV DI,0  
    XOR AX,AX 
caesar4:
    MOV AL,fourth_line[DI]
    CMP AL,41h ; A 
    JL end_test_caesar4
    CMP AL,7Ah ; z 
    JG end_test_caesar4
    CMP AL,5Ah ; Z
    JLE upper_case4
    CMP AL,61h ; a
    JL  end_test_caesar4 
    MOV BL,7Ah 
test_caesar4:
    ADD AL,K4; letter + k
    CMP AL,7Ah
    JG modulo2_4        
    MOV fourth_line[DI],AL    
end_test_caesar4:    
    INC DI      
    DEC CX
    CMP CX,0
    JNZ caesar4 
    JMP end_caesar4
upper_case4:
    ADD AL,K4; letter + k
    CMP AL,5Ah
    JG modulo1_4 
    MOV fourth_line[DI],AL
    JMP end_test_caesar4 
modulo1_4:
    ADD AL,6  ; after z -> A
    MOV fourth_line[DI],AL  
    JMP end_test_caesar4    
modulo2_4: 
    MOV BL,58
    SUB AL,BL ; after Z -> a
    MOV fourth_line[DI],AL
    JMP end_test_caesar4
end_caesar4:
;Print "Encrypted_4: "    
    MOV AH,2
    MOV DL,0AH ; newline        
    INT 21H
    MOV DL,0DH ; carriagereturn        
    INT 21H
    MOV DL,45H ; E        
    INT 21H
    MOV DL,34H ; 4        
    INT 21H
    MOV DL,3AH ; :        
    INT 21H
    MOV DL,20H ; space        
    INT 21H          
;Print crypted characters         
    MOV DI, 0 
    MOV CX,DIMS4
printf4:
    MOV AH,2
    MOV DL,fourth_line[DI]         
    INT 21H 
    INC DI
    DEC CX
    CMP CX,0             
    JNZ printf4
    
.EXIT
END