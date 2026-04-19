.data
    msg: .asciiz "Escreva um número inteiro\n"
    absoluto: .asciiz "\nSeu valor absoluto é: "
    
.text 
.globl main

main:
    
    la $a0, msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    
    move $a0, $v0
    
    jal valorAbs
    
    move $t0, $v0
    
    la $a0, absoluto
    li $v0, 4
    syscall
    
    move $a0, $t0
    li $v0, 1
    syscall
    
end:
   li $v0, 10
   syscall
   
valorAbs:

   blt $a0, $zero, multiplica
   move $v0, $a0
   jr $ra

multiplica:
    li $t1, -1
    mul $a0, $a0, $t1
    move $v0, $a0
    jr $ra