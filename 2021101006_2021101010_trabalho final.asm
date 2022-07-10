	.data
menu:		.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:	.asciz "\nO valor selecionado n�o existe, favor imprmir novamente\n"
matriz:		.word 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
cerquilha:	.asciz "#"
quebra_linha: .asciz "\n"
	.text
main:
	la s6, matriz # carrega endereço da matriz em s6
	li s7, 4 # carrega imediato 4 em s7
	jal escolher_matriz # chama a escolha da matriz e salva em s0 o tamanho de posicoes do vet e em t0 o tamanho do lado da matriz
	jal mostrar_matriz # mostra a matriz de acordo com o tamanho escolhido
	nop # encerra o programa

# escolher matriz, talvez mudar
escolher_matriz:
	# O 4 representa o indíce do tipo de comando de impressão salvo no a7 
	# Depois o a0 receba o endereço de memória da string e o sistema imprima no console
	li	a7, 4
	la	a0, menu
	ecall
	# Aqui segue a mesma lógica, o número 5 representa um comando para ler o input do usuário
	li	a7, 5
	ecall
	# O valor a retornado é armazenado no temporário a0, passamos ele para s0
	mv 	s0, a0

	# Verificando se o input corresponde aos valores fornecidos
	li	t1, 1
	li	t2, 2
	li	t3, 3
	beq	s0, t1, carregar_dados_oito # salva o size em s0 e da ret
	beq	s0, t2, carregar_dados_dez # salva o size em s0 e da ret
	beq	s0, t3, carregar_dados_doze # salva o size em s0 e da ret
	li	a7, 4
	la	a0, inputFail
	ecall
	j escolher_matriz
	
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

mostrar_matriz:
	# carrega o ultimo endereco de memoria do vet em t2
	mul t2, s7, s0 # t2 = s7 * s0 / t2 = 4 * size / 4 * 64 = 256
	add t2, t2, s6 # t2 = memIni + 256
	add t6, s6, zero # t6 = memIni
for_mostrar_matriz:
	beq t6, t2, fim_for_mostrar_matriz # if (memIni = t2)
	mul t3, s7, t0 # t3 = s7 * t0 = 4 * 8  = 24
	add t3, t3, t6 # t3 = memIni + 24
for_dentro_mostrar_matriz:
	beq t6, t3, fim_for_dentro_mostrar_matriz
	li a7, 4
	la a0, cerquilha
	ecall
	add t6, t6, s7 # ++
	j for_dentro_mostrar_matriz
fim_for_dentro_mostrar_matriz:
	li a7, 4
	la a0, quebra_linha
	ecall
	j for_mostrar_matriz
fim_for_mostrar_matriz:
	ret


	
	
	
