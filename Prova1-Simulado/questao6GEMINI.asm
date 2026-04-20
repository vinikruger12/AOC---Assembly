.data
   vector: .space 20
   msg: .asciiz "\n Digite um inteiro"
   filtro: .asciiz "\nDepois do filtro\n"

.text
.globl main

main:
    la $t0, vector
    li $t1, 0
    li $t2, 5
    
    while:
       beq $t1, $t2, sair
       sll $t3, $t1, 2
       add $t3, $t3, $t0
       
       la $a0, msg
       li $v0, 4
       syscall
       li $v0, 5
       syscall
       move $a0, $v0
       jal filtroF
       sw $v0, 0($t3)
       addi $t1, $t1, 1
       j while

sair:
   li $t1, 0
   la $a0, filtro
   li $v0, 4
   syscall
   
loop:
   beq $t1, $t2, end
   sll $t3, $t1, 2
   add $t3, $t3, $t0
   lw $a0, 0($t3)
   li $v0, 1
   syscall
   addi $t1, $t1, 1
   j loop

end:
   li $v0, 10
   syscall
   
filtroF:
    blt $a0, $zero, vira_zero
    move $v0, $a0
    jr $ra
    
vira_zero:
   li $a0, 0
   move $v0, $a0
   jr $ra