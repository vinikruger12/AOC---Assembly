.data
array:      .word 34, 7, 23, 32, 5, 62, 78, 1, 55, 19
size:       .word 10

msg_orig:   .asciiz "Array original:\n"
msg_sorted: .asciiz "\nArray ordenado:\n"
space:      .asciiz " "
newline:    .asciiz "\n"

.text
.globl main

############################################################
# main
# - imprime vetor original
# - chama quicksort(array, 0, size-1)
# - imprime vetor ordenado
############################################################
main:
    # imprimir mensagem inicial
    li   $v0, 4
    la   $a0, msg_orig
    syscall

    # print_array(array, size)
    la   $a0, array
    lw   $a1, size
    jal  print_array

    # quicksort(array, 0, size-1)
    la   $a0, array       # base do vetor
    li   $a1, 0           # left
    lw   $t0, size
    addi $a2, $t0, -1     # right = size - 1
    jal  quicksort

    # imprimir mensagem final
    li   $v0, 4
    la   $a0, msg_sorted
    syscall

    # print_array(array, size)
    la   $a0, array
    lw   $a1, size
    jal  print_array

    # encerrar
    li   $v0, 10
    syscall


############################################################
# print_array(base, n)
# a0 = endere�o base do vetor
# a1 = n�mero de elementos
############################################################
print_array:
    addi $sp, $sp, -12
    sw   $ra, 8($sp)
    sw   $s0, 4($sp)
    sw   $s1, 0($sp)

    move $s0, $a0      # base
    move $s1, $a1      # n
    li   $t0, 0        # i = 0

print_loop:
    bge  $t0, $s1, print_done

    sll  $t1, $t0, 2        # i*4
    add  $t2, $s0, $t1      # &array[i]
    lw   $a0, 0($t2)        # valor

    li   $v0, 1             # print int
    syscall

    li   $v0, 4
    la   $a0, space
    syscall

    addi $t0, $t0, 1
    j    print_loop

print_done:
    li   $v0, 4
    la   $a0, newline
    syscall

    lw   $s1, 0($sp)
    lw   $s0, 4($sp)
    lw   $ra, 8($sp)
    addi $sp, $sp, 12
    jr   $ra


############################################################
# quicksort(base, left, right)
# a0 = base do vetor
# a1 = �ndice left
# a2 = �ndice right
#
# if left >= right: return
# p = partition(base, left, right)
# quicksort(base, left, p-1)
# quicksort(base, p+1, right)
############################################################
quicksort:
    addi $sp, $sp, -24
    sw   $ra, 20($sp)
    sw   $s0, 16($sp)
    sw   $s1, 12($sp)
    sw   $s2, 8($sp)
    sw   $s3, 4($sp)
    sw   $s4, 0($sp)

    move $s0, $a0     # base
    move $s1, $a1     # left
    move $s2, $a2     # right

    # caso base: if left >= right return
    bge  $s1, $s2, qs_return

    # p = partition(base, left, right)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    jal  partition
    move $s3, $v0     # pivot index

    # quicksort(base, left, p-1)
    move $a0, $s0
    move $a1, $s1
    addi $a2, $s3, -1
    jal  quicksort

    # quicksort(base, p+1, right)
    move $a0, $s0
    addi $a1, $s3, 1
    move $a2, $s2
    jal  quicksort

qs_return:
    lw   $s4, 0($sp)
    lw   $s3, 4($sp)
    lw   $s2, 8($sp)
    lw   $s1, 12($sp)
    lw   $s0, 16($sp)
    lw   $ra, 20($sp)
    addi $sp, $sp, 24
    jr   $ra


############################################################
# partition(base, left, right) -> retorna �ndice do piv�
# Estrat�gia de Lomuto:
# pivot = array[right]
# i = left - 1
# for j = left to right-1:
#   if array[j] <= pivot:
#       i++
#       swap(array[i], array[j])
# swap(array[i+1], array[right])
# return i+1
#
# a0 = base
# a1 = left
# a2 = right
# v0 = pivot_index
############################################################
partition:
    addi $sp, $sp, -28
    sw   $ra, 24($sp)
    sw   $s0, 20($sp)
    sw   $s1, 16($sp)
    sw   $s2, 12($sp)
    sw   $s3, 8($sp)
    sw   $s4, 4($sp)
    sw   $s5, 0($sp)

    move $s0, $a0      # base
    move $s1, $a1      # left
    move $s2, $a2      # right

    # pivot = array[right]
    sll  $t0, $s2, 2
    add  $t1, $s0, $t0
    lw   $s3, 0($t1)   # pivot

    addi $s4, $s1, -1  # i = left - 1
    move $s5, $s1      # j = left

part_loop:
    bge  $s5, $s2, part_after_loop

    # carregar array[j]
    sll  $t2, $s5, 2
    add  $t3, $s0, $t2
    lw   $t4, 0($t3)

    # if array[j] <= pivot
    ble  $t4, $s3, part_if
    j    part_next

part_if:
    addi $s4, $s4, 1   # i++

    # swap(array[i], array[j])
    move $a0, $s0
    move $a1, $s4
    move $a2, $s5
    jal  swap

part_next:
    addi $s5, $s5, 1
    j    part_loop

part_after_loop:
    # swap(array[i+1], array[right])
    addi $t5, $s4, 1
    move $a0, $s0
    move $a1, $t5
    move $a2, $s2
    jal  swap

    addi $v0, $s4, 1   # return i+1

    lw   $s5, 0($sp)
    lw   $s4, 4($sp)
    lw   $s3, 8($sp)
    lw   $s2, 12($sp)
    lw   $s1, 16($sp)
    lw   $s0, 20($sp)
    lw   $ra, 24($sp)
    addi $sp, $sp, 28
    jr   $ra


############################################################
# swap(base, i, j)
# a0 = base
# a1 = i
# a2 = j
############################################################
swap:
    addi $sp, $sp, -16
    sw   $ra, 12($sp)
    sw   $s0, 8($sp)
    sw   $s1, 4($sp)
    sw   $s2, 0($sp)

    move $s0, $a0      # base
    move $s1, $a1      # i
    move $s2, $a2      # j

    # endere�o de array[i]
    sll  $t0, $s1, 2
    add  $t1, $s0, $t0

    # endere�o de array[j]
    sll  $t2, $s2, 2
    add  $t3, $s0, $t2

    # troca
    lw   $t4, 0($t1)
    lw   $t5, 0($t3)

    sw   $t5, 0($t1)
    sw   $t4, 0($t3)

    lw   $s2, 0($sp)
    lw   $s1, 4($sp)
    lw   $s0, 8($sp)
    lw   $ra, 12($sp)
    addi $sp, $sp, 16
    jr   $ra