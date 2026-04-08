.data

    msg: .asciiz "Digite oito inteiros\n"
    pares: .asciiz "\nO número de pares é\n"
    impares: .asciiz "\nO número de ímpares é\n"
    word: .space 32
.text
.globl main

main:
   la $a0, msg
   li $v0, 4
   syscall
   
   la $t0, word
   li $t1, 0
   li $t2, 8
   
loop:
   beq $t1, $t2, finalloop
   
   li $v0, 5
   syscall
   
   sw $v0, 0($t0)
   
   addi $t0, $t0, 4
   addi $t1, $t1, 1
   
   j loop

finalloop:
  li $t3, 0
  li $s1, 0
  li $s2, 0
  la $t0, word
  
loop2:
     beq $t2, $t3, end
     lw $t4, 0($t0)
     andi $s0, $t4, 1
     beq $s0, 0, par
     beq $s0, 1, impar
     
   
par:
   addi $s1, $s1, 1
   addi $t3, $t3,1
   addi $t0, $t0, 4
   j loop2
   
impar:
   addi $s2, $s2, 1
   addi $t3, $t3, 1
   addi $t0, $t0, 4
   j loop2
   
   
end:
   la $a0, pares
   li $v0, 4
   syscall
   
   move $a0, $s1
   li $v0, 1
   syscall
   
   la $a0, impares
   li $v0, 4
   syscall
   
   move $a0, $s2
   li $v0, 1
   syscall
   
   li $v0, 10
   syscall
   
   