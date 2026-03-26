.data
   msg1: .asciiz "A soma dos valores postivos é "
   msg2: .asciiz "A quantidade de números negativos é "
   msg3: .asciiz "A soma é maior que 20 "
   msg4: .asciiz "A soma nao é maior que 20 "
   pula: .asciiz "\n"

vector:
.word 5
.word -3
.word 12
.word 0
.word -7
.word 8
.word -1
.word 4

.text
.globl main

main:
	
   la $s0, vector
   li $t0, 0 #SOMA DOS POSTIVOS
   li $t1, 0 #QUANTIDADE DE NUMEROS NEGATIVOS
   li $t2, 0 #CONTADOR
   li $t4, 8 # TAMANHO VETOR
   
while:
   beq $t2, $t4, after
   sll $t7, $t2, 2
   add $t8, $s0, $t7
   lw $t3, 0($t8)
   addi $t2, $t2, 1
   bgtz $t3, soma
   bltz $t3, negativo
   j continua
   
soma:
   add $t0, $t0, $t3
   j continua

negativo:
    addi $t1, $t1, 1

continua:
   j while

after:

   li $t5, 20 #VALOR 20
   li $t6, 0 
   bgt $t0, $t5, flag
   li $t6, 0
   j print
   
flag:
   li $t6, 1
   j print
   
print:
   la $a0, msg1
   li $v0, 4
   syscall
   move $a0, $t0
   li $v0, 1
   syscall
   	
   la $a0, pula
   li $v0, 4
   syscall
   
   la $a0, msg2
   li $v0, 4
   syscall
   move $a0, $t1
   li $v0, 1
   syscall
   
   la $a0, pula
   li $v0, 4
   syscall
   
   beq $t6, 1, true
   j false

true:
   la $a0, msg3
   li $v0, 4
   syscall
   j end
false:
   la $a0, msg4
   li $v0, 4
   syscall
   j end


end:
   li $v0, 10
   syscall
   
