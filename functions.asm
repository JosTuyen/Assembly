;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
    ret
 
 
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
 
; push eax onto the stack to preserve it while we use the eax register in this function
; move 0Ah into eax - 0Ah is the ascii character for a linefeed
; push the linefeed onto the stack so we can get the address
; move the address of the current stack pointer(esp) into eax for sprint
; call our sprint function
; remove our linefeed character from the stack
; restore the original value of eax before our function was called
; return to our program
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
    
;------------------------------------------
; String addition(String num1, num2)
; Adds 5 digit numbers
addition:
    
;------------------------------------------
; String subtraction(String num1, num2)
; Subtracts 5 digit numbers
subtraction:

;points to rightmost digit
;loop counter - currently used for # of digits
;clears the carry flag (removing any garbage values)

;offset esi moves digit rightward
;subtracts two operands together + the value of the carry flag
;converts to decimal & determines whether a digit has been borrowed
;back up the register flag value
;convert the res to ASCII
;restore the register flag value
    
;move result to res
;move one digit left
;if ecx != 0, go back to subtraction
