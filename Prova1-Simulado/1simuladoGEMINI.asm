.data
   vector: .space 24
   
   pos: .asciiz "A soma dos positivos é\n"
   nega: .asciiz "\nA soma dos negativos é\n"
   msg: .asciiz "\nDigite um inteiro\n"
	

.text
.globl main

main:
   la $t0, vector
   li $t1, 0
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 0($t0)
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 4($t0)
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 8($t0)
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 12($t0)
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 16($t0)
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   sw $v0, 20($t0)
   
   li $t2, 0 # ITERADOR
   li $t3, 6 # TAMANHO VETOR
   
   li $t4, 0 # SOMA DOS POSITIVOS
   li $t5, 0 # SOMA DOS NEGATIVOS

while: 
    beq  $t2, $t3, sair
    sll $t6, $t2, 2 
    add $t7, $t0, $t6
    lw $s0, 0($t7)
    bgez $s0, positivos
    add $t5, $t5, $s0
    addi $t2, $t2, 1
    sll $t6, $t2, 2
    j while
    
positivos:
    add $t4, $t4, $s0
    addi $t2, $t2, 1
    j while
    
sair: 
    la $a0, pos
    li $v0, 4
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    la $a0, nega
    li $v0, 4
    syscall
    
    move $a0, $t5
    li $v0, 1
    syscall
    
end:
    li $v0, 10
    syscall
    
    
    


   