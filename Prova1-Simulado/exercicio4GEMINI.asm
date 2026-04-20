.data
    msg: .asciiz "Digite um inteiro\n"
    digitos: .asciiz "\nEsse número tem essa quantidade de digitos: "
    
.text 
.globl main

main:
    la $a0, msg
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    
    move $a0, $v0
    jal conta_digitos
    move $t0, $v0
    
    la $a0, digitos
    li $v0, 4
    syscall
    
    move $a0, $t0
    li $v0, 1
    syscall

end:
   li $v0, 10
   syscall	

conta_digitos:
    li $t1, 10
    li $t2, 0 #Contador
    li $t3, 1 #Um
    while:
       blt $a0, $t3, sair
       addi $t2, $t2, 1
       div $a0, $a0, $t1
       j while
sair:
    move $v0, $t2
    jr $ra