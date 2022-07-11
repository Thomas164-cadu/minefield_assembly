		.data
menu:			.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:		.asciz "\nO valor selecionado n�o existe, favor imprmir novamente\n"
indices:		.word 0,1,2,3,4,5,6,7,8,9,0,1
interface:		.word 5,10,10,10,3,10,10,10,10,10,10,10,10,0,0,10,10,10,10,10,10,10,10,10,10,1,10,-4,10,10,10,9,10,10,2,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,9,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
cerquilha:		.asciz "#"
quebra_linha:		.asciz "\n"
asterisco:		.asciz "*"
flag:			.asciz "F"

		.text
main:
	la s6, interface 
	li s7, 4 
	jal escolher_tabuleiro 
	jal mostra_campo 
	li a7, 10   # chamada de sistema para encerrar programa
	ecall
escolher_tabuleiro:
	li	a7, 4
	la	a0, menu
	ecall
	li	a7, 5
	ecall
	mv 	s0, a0
	li	t1, 1
	li	t2, 2
	li	t3, 3
	beq	s0, t1, carregar_dados_oito
	beq	s0, t2, carregar_dados_dez
	beq	s0, t3, carregar_dados_doze
	li	a7, 4
	la	a0, inputFail
	ecall
	j escolher_tabuleiro
carregar_dados_oito: 
	li t0, 8
	mul s0, t0, t0
	ret
carregar_dados_dez:
	li t0, 10
	mul s0, t0, t0
	ret
carregar_dados_doze:
	li t0, 12
	mul s0, t0, t0
	ret
mostra_campo:
	la s9, indices
	mul s8, s7, t0 
	add s8, s8, s9
for_mostrar_index:
	beq s9, s8, continua
	li a7, 1
	lw a0, (s9)
	ecall
	add s9, s9, s7
	j for_mostrar_index
continua:
	li a7, 4
	la a0, quebra_linha
	ecall
	mul t2, s7, s0 
	add t2, t2, s6 
	add t6, s6, zero 
	la s9, indices
	mul s8, s7, t0 
	add s8, s8, s9 
for_mostra_campo:
	beq t6, t2, fim_for_mostra_campo 
	mul t3, s7, t0 
	add t3, t3, t6 
	li a7, 1
	lw a0, (s9)
	ecall
	add s9, s9, s7
for_dentro_mostra_campo:
	beq t6, t3, fim_for_dentro_mostra_campo
	li s10, 10
	li s11, 9
	lw a0, (t6)
	beq a0, s10, imprime_cerquilha
	beq a0, s11, imprime_asterisco
	blt a0, zero, imprime_flag
	j imprime_numero
continua_for_mostrar:
	add t6, t6, s7
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
	
	
	
