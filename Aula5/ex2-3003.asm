.data
   msg: .asciiz "O maior número é\n"
   num1: .asciiz "Digite o primeiro número\n"
   num2: .asciiz "Digite o segundo número\n"

.text 
.globl main

main:
   la $a0, num1
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   move $a1, $v0
   
   la $a0, num2
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   move $a2, $v0
   
   la $a0, msg
   li $v0, 4
   syscall
   
   jal max
   move $a0, $v0
   li $v0, 1
   syscall
      
end:
   li $v0, 10
   syscall


max:
   add $sp, $sp, -4
   sw $s0, 0($sp)
   bge $a1, $a2, retorna_a1
   move $v0, $a2
   lw $s0, 0($sp)
   addi $sp, $sp, 4
   jr $ra
   
retorna_a1:
   move $v0, $a1
   lw $s0, 0($sp)
   addi $sp, $sp, 4
   jr $ra
     