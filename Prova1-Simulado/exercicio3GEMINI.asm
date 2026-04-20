.data
     msg: .asciiz "\nDigite um inteiro\n"
     dobroMSG: .asciiz "\n A soma dos dobros é\n"

.text
.globl main

main:

   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   move $t0, $v0
   
   la $a0, msg
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   
   move $a0, $v0
   move $a1, $t0
   
   jal soma_dobro
   move $t0, $v0
   
   la $a0, dobroMSG
   li $v0, 4
   syscall
   
   move $a0, $t0
   li $v0, 1
   syscall

end:
    li $v0, 10
    syscall
    
    
soma_dobro:
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    
    jal dobro
    move $s0, $v0
    move $a0, $a1
    jal dobro
    add $s0, $s0, $v0
    
    move $v0, $s0
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
    
dobro:
    add $a0, $a0, $a0
    move $v0, $a0
    jr $ra
    
   