		.data
menu:			.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:		.asciz "\nO valor selecionado não existe, favor imprmir novamente\n"
		.text
main:
	# escolher tabuleiro
	la	a0, menu
	la	a1, inputFail
	jal escolher_tabuleiro 
	
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