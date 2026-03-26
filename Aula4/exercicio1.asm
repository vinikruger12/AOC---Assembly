.data

#CRIA O VETOR
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
li $s1, 8 #TAMANHO DO VETOR
li $s2, 0 #SOMA POSITIVOS
li $t3, 0 #CONTADOR
li $s3, 0 ## CONTADOR DOS NEGATIVOS

while:
beq $t3, $s1, after ###AO CAIR NA CONDICAO (I == 8) DE PARADA VAI DIRETO PRO AFTER
sll $t0, $t3, 2 # ACESSA O VETOR
add $t4, $s0, $t0 # SOMA O ENDERECO DA BASE
lw $t1, 0($t4) #CARREGA EM T1 O VALOR DA POSICAO DO VETOR
blez $t1, pula #VERIFICA SE É MENOR QUE ZERO E VAI PRO PULA
add $s2, $s2, $t1 ## SE FOR POSITIVO SOMA


pula:
bltz $t1, num_negativos ## VERIFICA SE É NEGATIVO E VAI PRA NUM_NEGATIVOS

continua:
addi $t3, $t3, 1 #SOMA O CONTADOR
j while ##VOLTA PRO WHILE

num_negativos:
addi $s3, $s3, 1 ## SOMA OS VALORES QUE CAIEM NO NEGATIVO
j continua ## CAI NO CONTINUA E VAI SOMAR I++

after: ##O AFTER VERIFICA SE É MAIOR QUE 20, SE SIM CAI NO FLAG E DEPOIS ENCERRA (END), SENAO (ENCERRA) VAI PRO END DIRETO
li $t5, 20 ### VARIAVEL COM VALOR 20 PRA COMPARAR
li $s4, 0 ### FLAG
bgt $s2, $t5, flag ### SE FOR MAIOR QUE 20 CAII NO FLAG = 1 E ENCERRA
j end ### SENAO CAIR VAI PRO END E ACABA
flag:
li $s4, 1 ### SETA FLAG

end: ##ACABA
li $v0, 10
syscall