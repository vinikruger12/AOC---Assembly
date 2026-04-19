.data
    num1: .asciiz "Digite o primeiro numero\n"
    num2: .asciiz "\nDigite o segundo numero\n"
    
    maior: .asciiz "\nO maior número é\n"
    menor: .asciiz "\nO menor número é\n"
    
.text
.globl main

main:
   
   la $a0, num1
   li $v0, 4
   syscall
   	
   li $v0, 5
   syscall
   
   move $a2, $v0
   
   la $a0, num2
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   move $a1, $v0
   
   jal encontra_maior
   
   move $t0, $v0
   move $t1, $v1
   
   la $a0, maior
   li $v0, 4
   syscall
   
   move $a0, $t0
   li $v0, 1
   syscall
   
   la $a0, menor
   li $v0, 4
   syscall
   
   move $a0, $t1
   li $v0, 1
   syscall
   
end:
    li $v0, 10
    syscall
    

encontra_maior:
    bgt $a2, $a1, aZero
    move $v0, $a1
    move $v1, $a2
    jr $ra
    
aZero:
    move $v0, $a2
    move $v1, $a1
    jr $ra
   