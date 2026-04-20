.data
   vector: .space 40
   aux: .space 40
   s: .asciiz "\nÉ primo: "
   n: .asciiz "\nNao eh primo: "
   inteiro: .asciiz "\nDigite um inteiro\n"
   
.text
.globl main

main:
   la $t0, vector # Numeros
   la $t1, aux # Booleanos
   
   li $t2, 0 # Iterador
   li $t3, 10 # Tamanho
   
   while:
       beq $t2, $t3, saida
       la $a0, inteiro
       li $v0, 4
       syscall
       li $v0, 5
       syscall
       move $a0, $v0
       
       sll $t4, $t2, 2 # t4 dos vetores
       add $t4, $t4, $t0
       sll $t5, $t2, 2 ## t5 dos auxiliares
       add $t5, $t5, $t1
       
       sw $a0, 0($t4)
       jal primo
       move $a0, $v0
       sw $a0, 0($t5)
       addi $t2, $t2, 1
       j while

saida:
   li $t2, 0
   loop:
       beq $t2, $t3, end
       
       sll $t4, $t2, 2 # t4 dos vetores
       add $t4, $t4, $t0
       sll $t5, $t2, 2 ## t5 dos auxiliares
       add $t5, $t5, $t1
       lw $t9, 0($t5)
       beqz $t9, printa_NAO
       la $a0, s
       li $v0, 4
       syscall
       lw $a0, 0($t4)
       li $v0, 1
       syscall
       addi $t2, $t2, 1
       j loop
    printa_NAO:
       la $a0, n
       li $v0, 4
       syscall
       lw $a0, 0($t4)
       li $v0, 1
       syscall
       addi $t2, $t2, 1
       j loop

end:
   li $v0, 10
   syscall
   
primo:
    li $t6, 2
    looping:
       beq $t6, $a0, ehPRIMO
       div $a0, $t6
       mfhi $t7
       beqz $t7, NAO_eh
       addi $t6, $t6, 1
       j looping
    
    ehPRIMO:
       li $a0, 1
       move $v0, $a0
       jr $ra
    
    NAO_eh:
       li $a0, 0
       move $v0, $a0
       jr $ra
    
       
       
       
       
       
       
       