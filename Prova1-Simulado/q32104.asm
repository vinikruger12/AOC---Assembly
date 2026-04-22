.data
    msg: .asciiz "Digite um inteiro\n"

.text 
.globl main
main:
    la $a0, msg
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $a0, $v0
    jal processa_par
    move $a0, $v0
    li $v0, 1
    syscall
    
end:
   li $v0, 10
   syscall
   
processa_par:
    add $sp, $sp, -4
    sw $ra, 0($sp)
    li $t0, 1
    and $t1, $a0, $t0
    beq $t1,$t0, impar
    jal metade
    lw $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra

metade:
    li $t3, 2
    div $a0, $a0, $t3
    move $v0, $a0
    jr $ra
    
impar:
    lw $ra, 0($sp)
    add $sp, $sp, 4
    move $v0, $a0
    jr $ra
    
    