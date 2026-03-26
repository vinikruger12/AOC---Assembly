.data
   msg: .ascii "Digite vários números até encontrar -1"
   ans: .ascii "A média desses números é: "
  
.text
.globl main

main:

   la $a0, msg
   li $v0, 4
   syscall
   
   li $t0, 0
   li $t2, -1
   li $t3, 0
while:
   li $v0, 5
   syscall
   move $t1, $v0
   beq $t2, $t1, end
   add $t0, $t0, $t1
   addi $t3, $t3, 1
   j while

end:
   la $a0, ans
   li $v0, 4
   syscall
   
   div $t4, $t0, $t3
   move $a0, $t4
   li $v0, 2
   syscall

li $v0, 10
syscall