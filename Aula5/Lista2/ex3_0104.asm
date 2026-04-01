.data
   maior: .asciiz "O maior número é\n"
   menor: .asciiz "\nO menor número é\n"
   num1: .asciiz "Digite o primeiro número\n"
   num2: .asciiz "Digite o segundo número\n"
   num3: .asciiz "Digite o terceiro número\n"

.text 
.globl main

main:
   #########################################################
   la $a0, num1
   li $v0, 4 # printa a mensagem do numero 1
   syscall
   
   li $v0, 5   # le o primeiro numero
   syscall  
   move $a1, $v0 # armazena o primeiro numero em $a1
   #########################################################
   la $a0, num2 
   li $v0, 4 # printa a mensagem do numero 2
   syscall
   
   li $v0, 5 # le o segundo numero
   syscall
   move $a2, $v0 # move o segundo numero para $a2
   #########################################################
   la $a0, num3
   li $v0, 4 #printa a mensagem 3
   syscall
   
   li $v0, 5 # le o terceiro numero
   syscall
   move $a3, $v0 #move o terceiro numero para #$a3
   #########################################################
   
   la $a0, maior # mensagem dizendo que o maior numero é
   li $v0, 4
   syscall
   
   jal max
   move $a0, $v0
   li $v0, 1
   syscall
   #########################################################
   la $a0, menor # mensagem dizendo que o menor numero é
   li $v0, 4
   syscall
   
   jal min
   move $a0, $v1
   li $v0, 1
   syscall
   

#########################################################
end:
   li $v0, 10
   syscall
#########################################################
max:
   bge $a1, $a2, max2
   bge $a2, $a3, max3
   move $v0, $a3
   jr $ra
   
retorna1:
   move $v0, $a1
   jr $ra

max2:
   bge $a1, $a3, retorna1
   move $v0, $a3
   jr $ra

max3:
   move $v0, $a2
   jr $ra  
#########################################################
min:
   ble $a1, $a2, min2
   ble $a2, $a3, min3
   move $v1, $a3
   jr $ra
   
retorna2:
   move $v1, $a1
   jr $ra

min2:
   ble $a1, $a3, retorna2
   move $v1, $a3
   jr $ra

min3:
   move $v1, $a2
   jr $ra  
#########################################################