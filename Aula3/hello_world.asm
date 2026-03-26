.data
   msg:
    .ascii "Hello World"
   	
.text
.globl main

main:
   la $a0, msg
   li $v0, 4
   syscall

end:
   li $v0, 10
   syscall