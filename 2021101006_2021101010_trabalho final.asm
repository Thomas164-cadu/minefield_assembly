	.data
menu:		.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:	.asciz "\nO valor selecionado nï¿½o existe, favor imprmir novamente\n"
matriz:		.word 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
cerquilha:	.asciz "#"
	.text
main:
	la s6, matriz # s6 ï¿½ endereï¿½o da matriz
	li s7, 4
	jal escolher_matriz
	jal mostrar_matriz
	nop

# escolher matriz, talvez mudar
escolher_matriz:
	#O 4 representa o indíce do tipo de comando de impressão é salvo no a7 
	#Depois o a0 receba o endereço de memória da string e o sistema imprima no console
	li	a7, 4
	la	a0, menu
	ecall
	#Aqui é a mesma lógica, o número 5 representa um comando para ler o input do usuário
	li	a7, 5
	ecall
	#O valor retornado será armazenado no temporário a0, passamos ele para t0
	mv 	s0, a0

	# Verificando se o input corresponde aos valores fornecidos
	li	t1, 1
	li	t2, 2
	li	t3, 3
	beq	s0, t1, carregar_dados_oito # parametro em s0, size
	beq	s0, t2, carregar_dados_dez
	beq	s0, t3, carregar_dados_doze
	li	a7, 4
	la	a0, inputFail
	ecall
	j	escolher_matriz
	
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
	mul t2, s7, s0
	add t2, t2, s6 # t3 o max do for
for_mostrar_matriz:
	beq t0, t2, fim_for_mostrar_matriz
	
	li a7, 4
	la a0, cerquilha
	ecall
	
	add t0, t0, s7
	j for_mostrar_matriz
	
fim_for_mostrar_matriz:
	ret


	
	
	
