.data
     vector: .space 20
    inteiro: .asciiz "\nDigite um inteiro\n"
    msg: .asciiz "Esse foi o total de horas extras: "
    

.text
.globl main
main:
    la $t0, vector
    li $t1, 0
    li $t2, 5
    while:
        beq $t1, $t2, saida
        sll $t3, $t1, 2
        add $t3, $t3, $t0
        
        la $a0, inteiro
        li $v0, 4
        syscall
        
        li $v0, 5
        syscall
        
        sw $v0, 0($t3)
        addi $t1, $t1, 1
        j while

saida:
    li $t1, 0
    li $t5, 0
    loop:
        beq $t1, $t2, out
        sll $t3, $t1, 2
        add $t3, $t3, $t0
        lw $t4, 0($t3)
        add $t5, $t5, $t4
        addi $t1, $t1, 1
        j loop
out:
    li $t6, 40
    bgt $t5, $t6, printar
    la $a0, msg
    li $v0, 4
    syscall
    
    li $a0, 0
    li $v0, 1
    syscall
    
end:
    li $v0, 10
    syscall
    
printar:
    sub $t5, $t5, $t6
    la $a0, msg
    li $v0, 4
    syscall
    move $a0, $t5
    li $v0, 1
    syscall
    j end
     
        