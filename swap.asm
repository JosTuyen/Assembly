
section .data
    str1 db 'Everything', 0xa, 0
    len1 equ $ - str1
    str2 db 'Nothing   ', 0xa, 0
    len2 equ $ - str2
    temp db 'abcdefghij', 0xa, 0

    msg1 db 'str1 is: ', 0
    msg1Len equ $ - msg1
    msg2 db 'str2 is: ', 0
    msg2Len equ $ - msg2
section .text
    global _start

_start:
    ;move str1 to temp
    mov     ecx, 10            ;loop 10 times (ecx)
    mov     esi, str1          ;source string (str1)
    mov     edi, temp          ;destination string (temp)
    call    write_loop         ;call loop that replaces each character

    ;move str2 to str1
    mov     ecx, 10            ;loop 10 times (ecx)
    mov     esi, str2          ;source string (str2)
    mov     edi, str1          ;destination string (str1)
    call    write_loop         ;call loop that replaces each character

    ;move temp(str1) to str2
    mov     ecx, 10            ;loop 10 times (ecx)
    mov     esi, temp          ;source string (temp)
    mov     edi, str2          ;destination string (str2)
    call    write_loop         ;call loop that replaces each character

    jmp     print

    write_loop:
    mov     al, [esi]           ;move source char to al register
    mov     [edi], al           ;move char to destination
    inc     esi                 ;point to next char in esi
    inc     edi                 ;point to next char in edi
    loop    write_loop          ;back to write_loop (unless ecx == 0)
    ret

print:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, msg1
    mov     edx, msg1Len
    int     80h

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, str1
    mov     edx, len1
    int     80h

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, msg2
    mov     edx, msg2Len
    int     80h

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, str2
    mov     edx, len2
    int     80h

    mov     eax, 1
    mov     ebx, 0
    int     80h
