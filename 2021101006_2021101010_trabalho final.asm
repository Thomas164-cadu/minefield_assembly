# UNIVERSIDADE FEDERAL DA FRONTEIRA SUL
# Componente Curricular: Organização de Computadores
# Docente: Luciano Caimi
# Discentes: Carlos Eduardo Thomas e Matheus Vieira Santos
		.data
# valores inteiros
indices:		.word 0,1,2,3,4,5,6,7,8,9,0,1
interface:		.space 576
campo:		    .space 576

# strings
menu:			.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:		.asciz "\nO valor selecionado não existe, favor imprmir novamente\n"
cerquilha:		.asciz "#"
quebra_linha:		.asciz "\n"
asterisco:		.asciz "*"
flag:			.asciz "F"
espaco_em_branco:	.asciz " "
		.text
main:
	# vars que vamos usar ao longo do main
	li s7, 4 
	
	# escolher tabuleiro
	la	a0, menu
	la	a1, inputFail
	jal escolher_tabuleiro 
	
	# inicializa matriz interface
	add a0, a0, zero
    add a1, a1, zero
	li a2, 10 
    la a3, interface
	jal inicializa_matriz

	# inicializa matriz interface
	add a0, a0, zero
    add a1, a1, zero
	li a2, 0 
    la a3, campo
	jal inicializa_matriz
	
	# mostra interface
	add a0, a0, zero
	add a1, a1, zero
	la a2, interface
	la a3, indices
	jal mostra_campo 
	
	li a7, 10   # chamada de sistema para encerrar programa
	ecall

# Função escolher_tabuleiro	
# parametros
# a0 => endereço para o texto do menu
# a1 => endereço para o texto do inputfail
# retorno
# a0 => tamanho do lado da matriz 
# a1 => tamanho do array da matriz

escolher_tabuleiro:
    add t0, a1, zero  
	li	a7, 4
	ecall
	li	a7, 5
	ecall
	li	t1, 1
	li	t2, 2
	li	t3, 3
	beq	a0, t1, carregar_dados_oito
	beq	a0, t2, carregar_dados_dez
	beq	a0, t3, carregar_dados_doze
	li	a7, 4
    add a0, zero, t0
	ecall
	j escolher_tabuleiro
carregar_dados_oito: 
	li a0, 8
	mul a1, a0, a0
	ret
carregar_dados_dez:
	li a0, 10
	mul a1, a0, a0
	ret
carregar_dados_doze:
	li a0, 12
	mul a1, a0, a0
	ret

# Função inicializa_matriz
# parametros
# a0 => tamanho do lado da matriz (8/10/12)
# a1 => tamanho do array da matriz (64/100/144)
# a2 => valor pra inicializar com
# a3 => endereço inicial da matriz
# retorno 
# nao tem

inicializa_matriz:
	add t0, a3, zero 
	mul t1, a1, s7
	add t1, a3, t1
for_inicializa_matriz:
	beq t1, t0, termina_for_inicializar
	sw a2, (t0)
	add t0, t0, s7
	j for_inicializa_matriz
termina_for_inicializar:
	ret

# Função mostra_campo
# parametros
# a0 => tamanho do lado da matriz 
# a1 => tamanho do array da matriz
# a2 => endereço inicial da matriz interface
# a3 => endereço inicial do array dos indices
# retorno
# nao tem

mostra_campo:
	mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3

mostra_index:
	mul t0, s7, s0
	add t0, t0, s3
	add t1, zero, s3

	li a7, 4
	la a0, espaco_em_branco
	ecall

for_mostrar_index:
	beq t0, t1, continua
	li a7, 1
	lw a0, (t1)
	ecall
	add t1, t1, s7
	j for_mostrar_index
continua:
	li a7, 4
	la a0, quebra_linha
	ecall

mostra_matriz:
	mul t0, s7, s1
	add t0, t0, s2
	add t1, zero, s2
	mv t2, s3
for_mostra_campo:
	beq t1, t0, fim_for_mostra_campo 
	mul t3, s7, s0 
	add t3, t3, t1
	li a7, 1
	lw a0, (t2)
	ecall
	add t2, t2, s7
for_dentro_mostra_campo:
	beq t1, t3, fim_for_dentro_mostra_campo
	li t4, 10
	li t5, 9
	lw a0, (t1)
	beq a0, t4, imprime_cerquilha
	beq a0, t5, imprime_asterisco
	blt a0, zero, imprime_flag
	j imprime_numero
continua_for_mostrar:
	add t1, t1, s7
	j for_dentro_mostra_campo
fim_for_dentro_mostra_campo:
	li a7, 4
	la a0, quebra_linha
	ecall
	j for_mostra_campo
fim_for_mostra_campo:
	ret
imprime_cerquilha:
	li a7, 4
	la a0, cerquilha
	ecall
	j continua_for_mostrar
imprime_asterisco:
	li a7, 4
	la a0, asterisco
	ecall
	j continua_for_mostrar
imprime_flag:
	li a7, 4
	la a0, flag
	ecall
	j continua_for_mostrar
imprime_numero:
	li a7, 1
	ecall
	j continua_for_mostrar
