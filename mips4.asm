.data
msg: .asciiz "Hello, World!\n"

.text
.globl main

main:
    li $v0, 4       # código do syscall para imprimir string
    la $a0, msg     # carrega endereço da string em $a0
    syscall         # executa

    li $v0, 10      # código para encerrar o programa
    syscall