.data
   num: .asciiz "Digite um número\n"
   ans: .asciiz "\nEsse número tem essa quantidade de digitos\n"

.text 
.globl main

main:
   #########################################################
   la $a0, num
   li $v0, 4 # printa a mensagem 
   syscall
   
   li $v0, 5   # le o primeiro numero
   syscall  
   move $a1, $v0 # armazena o primeiro numero em $a1
   #########################################################
   la $a0, ans 
   li $v0, 4 # printa a mensagem da resposta
   syscall
   
   jal digitos
   move $a0, $v0
   li $v0, 1
   syscall
   #########################################################
   
end:
   li $v0, 10
   syscall
#########################################################
digitos:
   add $sp, $sp, -4
   sw $s0, 0($sp)
   add $s0, $s0, 0
   li $t0, 10
   abs $a1, $a1
   while:
      addi $s0, $s0, 1
      div $a1, $a1, $t0 
      bge $a1, 1, while
   
   move $v0, $s0
   lw $s0, 0($sp)
   addi $sp, $sp, 4
   jr $ra
