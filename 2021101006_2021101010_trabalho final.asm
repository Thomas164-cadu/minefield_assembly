# UNIVERSIDADE FEDERAL DA FRONTEIRA SUL
# Componente Curricular: Organização de Computadores
# Docente: Luciano Caimi
# Discentes: Carlos Eduardo Thomas e Matheus Vieira Santos
		.data
salva_S0:			.word		0
salva_ra:			.word		0
salva_ra1:			.word		0

#########################################################
# necess�rio em caso de debug da funcao
#espaco:			.asciz		" "
#dois_pontos:		.asciz		": "
#nova_linha:		.asciz		"\n"
#posicao:		.asciz		"\nPosicao bomba "
#########################################################

#########################################################
#IN�CIO DO C�DIGO IMPLEMENTADO SOMENTE PELOS ALUNOS
# valores inteiros
indices:			.word 0,1,2,3,4,5,6,7,8,9,0,1
interface:			.space 576
campo:		    		.space 576

# strings
menu:				.asciz	"\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n"
inputFail:			.asciz "\nO valor selecionado não existe, favor inserir novamente\n"
cerquilha:			.asciz "#"
quebra_linha:			.asciz "\n"
asterisco:			.asciz "*"
flag:				.asciz "F"
espaco_em_branco:		.asciz " "
menu_linha:			.asciz "\nQual a linha de sua jogada?\nPara o campo 12x12, favor inserir valores entre 0 e 11\n"
menu_coluna:			.asciz "\nQual a coluna de sua jogada?\nPara o campo 12x12, favor inserir valores entre 0 e 11\n"
menu_escolha_jogada:		.asciz "\nVoc� deseja: \n1 - Abrir uma casa \n2 - Inserir uma flag\n"
		.text
main:
	# vars que vamos usar ao longo do main
	li s7, 4 
	#s10 ir� armazenar o n�mero de linhas para uso na fun��o insere_bombas
	
	# escolher tabuleiro
	la	a0, menu
	la	a1, inputFail
	jal escolher_tabuleiro 
	
	# inicializa matriz campo
	add a0, a0, zero
    	add a1, a1, zero
	li a2, 0 
    	la a3, campo
	jal inicializa_matriz

	# inicializa matriz interface
	add a0, a0, zero
    	add a1, a1, zero
	li a2, 10
    	la a3, interface
	jal inicializa_matriz
	
	# mostra interface
	add a0, a0, zero
	add a1, a1, zero
	la a2, interface
	la a3, indices
	jal mostra_campo 
	
	# salva tamanho do lado da matriz, refatorar esse cara aqui
	add s11, a0, zero
	
	# chamada da fun��o insere_bombas
	la a0, campo
	mv a1, s0
	jal INSERE_BOMBA
	
	# menu de jogadas
	add a0, s11, zero
	la a1, inputFail
	jal menu_de_jogadas
	
	li a7, 10   # chamada de sistema para encerrar programa
	ecall

# Função escolher_tabuleiro	
# parametros
# a0 => endereço para o texto do menu
# a1 => endereço para o texto do inputfail
# retorno
# a0 => tamanho do lado da matriz (8/10/12)
# a1 => tamanho do array da matriz (64/100/144)

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
# a2 => valor pra inicializar matriz
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
# a0 => tamanho do lado da matriz (8/10/12)
# a1 => tamanho do array da matriz (64/100/144)
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
	
#fun��o do menu de jogadas
# a0 => tamanho do lado da matriz (8/10/12)
# a1 => endereço para o texto do inputfail
#Lado da matriz em a0
#retorno
#valores de linha e coluna armazenados em t0 e t1 respectivamente
menu_de_jogadas:
	add t4, a0, zero
inicia_menu_jogadas:
	li a7, 4
	la a0, menu_escolha_jogada
	ecall
	li a7, 5
	ecall
	li t0, 1
	li t1, 2
	beq a0, t0, continua_menu_jogada
	beq a0, t1, continua_menu_jogada
    	j menu_jogadas_erro
continua_menu_jogada:
	li a7, 4
	la a0, menu_linha
	ecall
	
	li a7, 5
	ecall 
	# valida se é menor que zero
	blt a0, zero, menu_jogadas_erro
	#valida se é maior que o tamanho do lado da matriz
	blt t4, a0, menu_jogadas_erro
	add t0, zero, a0
	
	li a7, 4
	la a0, menu_coluna
	ecall
	
	li a7, 5
	ecall
	# valida se é menor que zero
	blt a0, zero, menu_jogadas_erro
	#valida se é maior que o tamanho do lado da matriz
	blt t4, a0, menu_jogadas_erro
	add t1, zero, a0
	
	mul t0, t0, t1
	mul t0,	t0, s7
	la t1, campo
	add t0, t0, t1
	#verifica se o valor da posi��o de mem�ria escolhida contem a bomba e se tiver, bye bye
	lw t2, (t0)
	li t3, 9
	beq t2, t3, fim_menu_de_jogadas
	j inicia_menu_jogadas
	ret
menu_jogadas_erro:
	li a7, 4
    	la a0, inputFail
	ecall
	j inicia_menu_jogadas
fim_menu_de_jogadas:
	ret
	
	

	
	
############################################################
#Implementa��o da fun��o insere_bombas
############################################################
#     Algoritmo	
#
#  Salva registradores
#  Carrega numero de sementes sorteadas = 15
#  Le semente para fun��o de numero pseudo randomico
#  while (bombas < x) 
#     sorteia linha
#     sorteia coluna
#     le posi��o pos = (L * tam + C) * 4
#     if(pos != 9)
#    	  grava posicao pos = 9
#     bombas++  
#
############################################################
INSERE_BOMBA:
		la	t0, salva_S0
		sw  	s0, 0 (t0)		# salva conteudo de s0 na memoria
		la	t0, salva_ra
		sw  	ra, 0 (t0)		# salva conteudo de ra na memoria
		
		add 	t0, zero, a0		# salva a0 em t0 - endere�o da matriz campo
		add 	t1, zero, a1		# salva a1 em t1 - quantidade de linhas 

QTD_BOMBAS:
		addi 	t2, zero, 15 		# seta para 15 bombas	
		add 	t3, zero, zero 	# inicia contador de bombas com 0
		addi 	a7, zero, 30 		# ecall 30 pega o tempo do sistema em milisegundos (usado como semente
		ecall 				
		add 	a1, zero, a0		# coloca a semente em a1
INICIO_LACO:
		beq 	t2, t3, FIM_LACO
		add 	a0, zero, t1 		# carrega limite para %	(resto da divis�o)
		jal 	PSEUDO_RAND
		add 	t4, zero, a0		# pega linha sorteada e coloca em t4
		add 	a0, zero, t1 		# carrega limite para % (resto da divis�o)
   		jal 	PSEUDO_RAND
		add 	t5, zero, a0		# pega coluna sorteada e coloca em t5

###############################################################################
# imprime valores na tela (para debug somente) - retirar comentarios para ver
#	
#		li	a7, 4		# mostra texto "Posicao: "
#		la	a0, posicao
#		ecall
#		
#		li	a7, 1		
#		add 	a0, zero, t3 	# imprime quantidade ja sorteada
#		ecall		
#
#		li	a7, 4		# imrpime :
#		la	a0, dois_pontos
#		ecall
#
#		li	a7, 1
#		add 	a0, zero, t4 	# imprime a linha sorteada	
#		ecall
#		
#		li	a7, 4		# imrpime espa�o
#		la	a0, espaco
#		ecall	
#			
#		li	a7, 1
#		add 	a0, zero, t5 	# imprime coluna sorteada
#		ecall
#		
##########################################################################	

LE_POSICAO:	
		mul  	t4, t4, t1
		add  	t4, t4, t5  		# calcula (L * tam) + C
		add  	t4, t4, t4  		# multiplica por 2
		add  	t4, t4, t4  		# multiplica por 4
		add  	t4, t4, t0  		# calcula Base + deslocamento
		lw   	t5, 0(t4)   		# Le posicao de memoria LxC
VERIFICA_BOMBA:		
		addi 	t6, zero, 9		# se posi��o sorteada j� possui bomba
		beq  	t5, t6, PULA_ATRIB	# pula atribui��o 
		sw   	t6, 0(t4)		# sen�o coloca 9 (bomba) na posi��o
		addi 	t3, t3, 1		# incrementa quantidade de bombas sorteadas
PULA_ATRIB:
		j	INICIO_LACO

FIM_LACO:					# recupera registradores salvos
		la	t0, salva_S0
		lw  	s0, 0(t0)		# recupera conteudo de s0 da mem�ria
		la	t0, salva_ra
		lw  	ra, 0(t0)		# recupera conteudo de ra da mem�ria		
		jr 	ra			# retorna para funcao que fez a chamada
		
##################################################################
# PSEUDO_RAND
# fun��o que gera um n�mero pseudo-randomico que ser�
# usado para obter a posi��o da linha e coluna na matriz
# entrada: a0 valor m�ximo do resultado menos 1 
#             (exemplo: a0 = 8 resultado entre 0 e 7)
#          a1 para o n�mero pseudo randomico 
# saida: a0 valor pseudo randomico gerado
#################################################################
#int rand1(int lim, int semente) {
#  static long a = semente; 
#  a = (a * 125) % 2796203; 
#  return (|a % lim|); 
# }  

PSEUDO_RAND:
		addi t6, zero, 125  		# carrega constante t6 = 125
		lui  t5, 682			# carrega constante t5 = 2796203
		addi t5, t5, 1697 		# 
		addi t5, t5, 1034 		# 	
		mul  a1, a1, t6			# a = a * 125
		rem  a1, a1, t5			# a = a % 2796203
		rem  a0, a1, a0			# a % lim
		bge  a0, zero, EH_POSITIVO  	# testa se valor eh positivo
		addi s2, zero, -1           	# caso n�o 
		mul  a0, a0, s2		    	# transforma em positivo
EH_POSITIVO:	
		ret				# retorna em a0 o valor obtido
