.data

vector:
.word 3
.word 7
.word 5
.word 1

.text
.global main

main:
la $t0, vector
lw $t1, 12($t0)
lw $t2, 8($t0)
addi $t2, $t1, 87
sw $t2, 8($t0)

end:
li $v0, 10
syscall