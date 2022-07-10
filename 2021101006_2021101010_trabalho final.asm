	.data
menu:	.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:	.asciz "\nO valor selecionado n�o existe, favor imprmir novamente\n"
	.text
main:

imprime_menu:
	#O 4 representa o ind�ce do tipo de comando de impress�o � salvo no a7 
	#Depois o a0 receba o endere�o de mem�ria da string e o sistema imprima no console
	li	a7, 4
	la	a0, menu
	ecall
	#Aqui � a mesma l�gica, o n�mero 5 representa um comando para ler o input do usu�rio
	li	a7, 5
	ecall
	#O valor retornado ser� armazenado no tempor�rio a0, passamos ele para t0
	mv 	t0, a0
	
verifica_opcao:
	#Verificando se o input corresponde aos valores fornecidos
	li	t1, 1
	li	t2, 2
	li	t3, 3
	beq	t0, t1, matriz_oito
	beq	t0, t2, matriz_dez
	beq	t0, t3, matriz_doze
	li	a7, 4
	la	a0, inputFail
	ecall
	j	imprime_menu
	
matriz_oito:
	nop
matriz_dez:
	nop
matriz_doze:
	nop