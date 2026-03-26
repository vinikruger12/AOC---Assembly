.text
.globl main

main:

   li $s0, 5
   li $s1, 1

while:
   mul $s1, $s1, $s0
   subi $s0, $s0, 1
   bnez $s0, while

end:
   li $v0, 10
   syscall