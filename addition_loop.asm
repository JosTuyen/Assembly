section	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point

   mov     esi, 4       ;pointing to the rightmost digit
   mov     ecx, 5       ;loop counter - currently used for # of digits
   clc                  ;clears the carry flag (removing any garbage values)
add_loop:
   mov 	al, [num1 + esi];offset esi moves digit rightward
   adc 	al, [num2 + esi];adds two operands together + the value of the carry flag
   aaa                  ;converts to decimal & determines whether there has been an overflow
   pushf                ;back up the register flag value
   or 	al, 30h         ;convert the res to ASCII
   popf                 ;restore the register flag value

   mov	[res + esi], al ;move result to res
   dec	esi             ;move one digit left
   loop	add_loop        ;if ecx != 0, go back to addition

   mov	edx,len	        ;message length
   mov	ecx,msg	        ;message to write
   mov	ebx,1	        ;file descriptor (stdout)
   mov	eax,4	        ;system call number (sys_write)
   int	0x80	        ;call kernel

   mov	edx,5	        ;message length
   mov	ecx,res	        ;message to write
   mov	ebx,1	        ;file descriptor (stdout)
   mov	eax,4	        ;system call number (sys_write)
   int	0x80	        ;call kernel

   mov	eax,1	        ;system call number (sys_exit)
   int	0x80	        ;call kernel

section	.data
msg db 'The Sum is:',0xa
len equ $ - msg
num1 db '12345'
num2 db '23456'
res db '     '
