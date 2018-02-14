%include        'functions.asm'

section .data
    sumMsg db 'The Sum is:', 0
    subMsg db 'The Difference is:', 0
    ;len equ $ - msg
    num1 db '23456', 0
    num2 db '12345', 0
    res db '     '

section .text
    global _start
    
_start:
    call    addition
    
    mov     eax, sumMsg
    call    sprintLF
    
    mov     eax, res
    call    sprintLF
    
    call    subtraction
    
    mov     eax, subMsg
    call    sprintLF
    
    mov     eax, res
    call    sprintLF
    
    call    quit
