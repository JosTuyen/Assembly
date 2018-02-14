section .date
	msg db 'Hello, World!', 0xa
	len equ $ - msg

section .text
	global _start

_start:
	mov eax, 4 	;system call number (sys_write)
	mov ebx, 1 	;file descriptor (stdout)
	mov ecx, msg 	;message to write
	mov edx, len 	;message to length
	int 0x80	;call kernel

	mov eax, 1	;system call (sys_exit)
	int 0x80	;call kernel

