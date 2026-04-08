.data
   msg: .asciiz "Digite um valor\n"
   abss: .asciiz "Seu valor absoluto é\n"

.text 
.globl main

main:

  la $a0, msg
  li $v0, 4
  syscall
  
  li $v0, 5
  syscall
  move $t0, $v0
  
  move $a0, $t0
  
  jal absoluto
  	
  move $t0, $v0
	  
  la $a0, abss
  li $v0, 4
  syscall
  
  move $a0, $t0
  li $v0, 1
  syscall
  
  li $v0, 10
  syscall
  
absoluto:
   li $t1, 0
   blt $a0, $t1, negativo
   move $v0, $a0
   
   jr $ra

negativo:
     li $t2, -1
     mul $a0, $a0, $t2
     move $v0, $a0
     jr $ra 