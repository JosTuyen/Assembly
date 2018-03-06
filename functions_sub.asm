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

    push    eax     ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     eax, 0Ah; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    eax     ; push the linefeed onto the stack so we can get the address
    mov     eax, esp; move the address of the current stack pointer(esp) into eax for sprint
    call    sprint  ; call our sprint function
    pop     eax     ; remove our linefeed character from the stack
    pop     eax     ; restore the original value of eax before our function was called
    ret             ; return to our program

;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret

;------------------------------------------
; int addition(String num1, num2)
; Adds 5 digit numbers
addition:
    push    ecx
    mov     esi, 4              ;points to rightmost digit
    mov     ecx, 5              ;loop counter - currently used for # of digits
    clc                         ;clears the carry flag (removing any garbage values)
add_loop:
    mov 	al, [num1 + esi];offset esi moves digit rightward
    adc 	al, [num2 + esi];adds two operands together + the value of the carry flag
    aaa                   ;converts to decimal & determines whether there has been an overflow
    pushf                 ;back up the register flag value
    or 	al, 30h           ;convert the res to ASCII
    popf                  ;restore the register flag value

    mov	[res + esi], al   ;move result to res
    dec	esi               ;move one digit left
    loop	add_loop        ;if ecx != 0, go back to addition
    pop     ecx
    ret

;------------------------------------------
; int subtraction(String num1, num2)
; Subtracts 5 digit numbers
subtraction:
    push    ecx

    mov     esi, 4              ;points to rightmost digit
    mov     ecx, 5              ;loop counter - currently used for # of digits
    clc                         ;clears the carry flag (removing any garbage values)
sub_loop:
    mov 	al, [num1 + esi];offset esi moves digit rightward
    sub 	al, [num2 + esi];subtracts two operands together + the value of the carry flag
    aas                   ;converts to decimal & determines whether a digit has been borrowed
    pushf                 ;back up the register flag value
    or al, 30h            ;convert the res to ASCII
    popf                  ;restore the register flag value

    mov [res + esi], al   ;move result to res
    dec esi               ;move one digit left
    loop    sub_loop      ;if ecx != 0, go back to addition

    jc      negative      ;jump to negative if the borrow flag was used at the leftmost digit
sub_finish:
    pop     ecx
    ret


negative:
    mov     [res], byte '-'     ;add '-' to res
    call    swap                ;swap num1 and num2 for subtraction
    call    subtraction         ;subtract again with the swapped values
    jmp     sub_finish

;------------------------------------------
; String swap(String num1, num2)
; Swaps two strings
swap:

    ;move num1 to temp
    mov     ecx, 5          ;loop 5 times (ecx)
    mov     esi, num1       ;source string (num1)
    mov     edi, temp       ;destination string (temp)
    call    write_loop      ;call loop that replaces each character

    ;move num2 to num1
    mov     ecx, 5          ;loop 5 times (ecx)
    mov     esi, num2       ;source string (num2)
    mov     edi, num1       ;destination string (num1)
    call    write_loop      ;call loop that replaces each character

    ;move temp(num1) to num2
    mov     ecx, 5          ;loop 5 times (ecx)
    mov     esi, temp       ;source string (temp)
    mov     edi, num2       ;destination string (num2)
    call    write_loop      ;call loop that replaces each character

    ret

    write_loop:
    mov     al, [esi]   ;move source char to al register
    mov     [edi], al   ;move char to destination
    inc     esi         ;point to next char in esi
    inc     edi         ;point to next char in edi
    loop    write_loop  ;back to write_loop (unless ecx == 0)
    ret
