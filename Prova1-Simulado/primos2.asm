.data
   msg: .asciiz "\nÉ primo: "

.text
.globl main
main:
   li $t0, 2
   li $t1, 10000000
   while:
      li $a1, 2
      beq $t0, $t1, end
      move $a0, $t0
      jal primo
      li $t2, 1
      beq $v0, $t2, print
      addi $t0, $t0, 1
      j while
   
print: 
   la $a0, msg
   li $v0, 4
   syscall
   move $a0, $t0
   li $v0, 1
   syscall
   addi $t0, $t0, 1
   j while

end:
   li $v0, 10
   syscall

primo:
   beq $a1, $a0, eh_primo
   div $a0, $a1
   mfhi $t5
   beqz $t5, neh_primo
   addi $a1, $a1, 1
   j primo
neh_primo:
   move $v0, $t5
   jr $ra
eh_primo:
   li $t6, 1
   move $v0, $t6
   jr $ra
      
  