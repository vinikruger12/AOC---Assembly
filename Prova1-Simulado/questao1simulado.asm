.data

    vector: .space 32
    msg: .asciiz "\nDigite um inteiro \n"
    pares: .asciiz "\nPares: "
    impares: .asciiz "\n Impares: "
    
.text
.globl main

main:
   
   la $t0, vector
   li $t1, 0 # Contador
   li $t2, 8 # Tamanho do vetor
   
   loop:
       beq $t1, $t2, saida
       sll $t3, $t1, 2
       add $t3, $t0, $t3
       
       la $a0, msg
       li $v0, 4
       syscall
       
       li $v0, 5
       syscall
       sw $v0, 0($t3)
       addi $t1, $t1, 1
       j loop

saida:
   li $t1, 0
   li $t4, 0 #Numero pares
   li $t5, 0 #Numero impares
    
   for:
       beq $t1, $t2, printar
       sll $t7, $t1, 2
       add $t7, $t7, $t0
       lw $t8, 0($t7)
       andi $t6, $t8, 1 # Se 0 par, 1 impar
       beqz $t6, ehPar
       addi $t5, $t5, 1
       addi $t1, $t1, 1
       j for
       
   ehPar:
       addi $t4, $t4, 1
       addi $t1, $t1, 1
       j for

printar:
    
    la $a0, pares
    li $v0, 4
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, impares
    li $v0, 4
    syscall
    
    move $a0, $t5
    li $v0, 1
    syscall
    
end:
    li $v0, 10
    syscall
       
   

