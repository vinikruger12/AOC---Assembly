.data
   vector:
      .word 2
      .word 3
      .word 4
      .word 5
.text
.globl main
main:
   la $t0, vector
   li $a1, 4
   jal processa_vetor
   li $t1, 0
   while:
      beq $t1, $a1, end
      sll $t3, $t1, 2
      add $t3, $t3,$t0
      lw $a0, 0($t3)
      li $v0, 1
      syscall
      addi $t1, $t1, 1
      j while

end:
   li $v0, 10
   syscall
   
processa_vetor:
   li $t1, 0
   add $sp, $sp, -4
   sw $ra, 0($sp)
   loop:
      beq $t1, $a1, saida
      sll $t3, $t1, 2
      add $t3, $t3, $t0
      lw $a0, 0($t3)
      jal quadrado
      sw $v0, 0($t3)
      addi $t1, $t1, 1
      j loop
saida:
   lw $ra, 0($sp)
   add $sp, $sp, 4
   jr $ra

quadrado:
   mul $a0, $a0, $a0
   move $v0, $a0
   jr $ra