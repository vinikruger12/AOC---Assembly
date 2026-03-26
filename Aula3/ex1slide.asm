.data
   msg1: .ascii "Digite o número para saber seu fatorial: "
   msg2: .ascii "O fatorial é "
  
.text
.globl main

main:
   la $a0, msg1
   li $v0, 4
   syscall
   
   li $v0, 5
   syscall
   move $s0, $v0
   
   li $s1, 1

while:
   mul $s1, $s1, $s0
   subi $s0, $s0, 1
   bnez $s0, while

end:
   la $a0, msg2
   li $v0, 4
   syscall
   
   move $a0, $s1
   li $v0, 1
   syscall

li $v0, 10
syscall