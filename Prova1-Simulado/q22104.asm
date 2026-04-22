.data
   orig: .space 24
   dest: .space 24
   
.text
.globl main
main:
   la $t0, orig
   la $t1, dest
   li $t2, 0
   li $t3, 6
   while:
      beq $t2, $t3, saida
      sll $t4, $t2, 2
      move $t5, $t4
      add $t4, $t4, $t0
      add $t5, $t5, $t1
      
      li $v0, 5
      syscall
      
      sw $v0, 0($t4)
      lw $t6, 0($t4)
      bgtz $t6, armazena
      addi $t2, $t2, 1
      j while

armazena:
    sw $t6, 0($t5)
    addi $t2, $t2, 1
    j while

saida:
    li $v0, 10
    syscall
      
      