section	.text
   global _start    ;must be declared for using gcc

_start:             ;tell linker entry point

   mov ecx, enter1
   mov edx, len1
   mov ebx, 1
   mov eax, 4
   int 0x80

   mov ecx, num1
   mov edx, 2
   mov ebx, 0
   mov eax, 3
   int 0x80

   mov ecx, enter2
   mov edx, len2
   mov ebx, 1
   mov eax, 4
   int 0x80

   mov ecx, num2
   mov edx, 2
   mov ebx, 0
   mov eax, 3
   int 0x80

   mov al, [num1]
   mov bl, [num2]
   sub al, '0'
   sub bl, '0'
   mul bl
   add al, '0'

   mov 	[res], al
   mov	ecx,msg
   mov	edx, len
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel

   mov	ecx,res
   mov	edx, 1
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel

   mov	eax,1	;system call number (sys_exit)
   int	0x80	;call kernel

section .data
enter1 db "Enter the first number", 0xA,0xD
len1 equ $- enter1
enter2 db "Enter the second number", 0xA,0xD
len2 equ $- enter2
msg db "The result is:", 0xA,0xD
len equ $- msg
segment .bss
res resb 1
num1 resb 2
num2 resb 2
