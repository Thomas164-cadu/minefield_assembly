# UNIVERSIDADE FEDERAL DA FRONTEIRA SUL
# Componente Curricular: Organização de Computadores
# Docente: Luciano Caimi
# Discentes: Carlos Eduardo Thomas e Matheus Vieira Santos

			.data
salva_S0:	.word 0
salva_ra:	.word 0
salva_ra1:	.word 0
indices:	.word 0,1,2,3,4,5,6,7,8,9,0,1
interface:	.space 576
campo:	.space 576
menu:	.asciz "\nCampo Minado \nQual o tamanho do campo que deseja jogar? \n1 - 8x8 \n2 - 10x10 \n3 - 12x12\n4 - Sair\n"
inputFail:	.asciz "\nO valor selecionado não existe, favor inserir novamente\n"
cerquilha:	.asciz "#"
quebra_linha:	.asciz "\n"
asterisco:	.asciz "*"
flag:	.asciz "F"
espaco_em_branco:	.asciz " "
menu_linha:	.asciz "\nQual a linha de sua jogada?\n"
menu_coluna:	.asciz "\nQual a coluna de sua jogada?\n"
menu_escolha_jogada:	.asciz "\nVocê deseja: \n1 - Abrir uma casa \n2 - Movimentar uma flag\n"
mensagem_perdeu:	.asciz "\nPoxa, você perdeu!\n\n"
mensagem_ganhou:	.asciz "\nBoa, você ganhou!\n\n"
mensagem_erro_flag:	.asciz "\nVish, essa casa aí já tem flag!\n"
mensagem_erro_campo_ja_aberto:	.asciz "\nEsse aí não dá pra jogar flag meu chapa, você já abriu ele\n"
			.text
main:
	li s7, 4

	la a0, menu
	la a1, inputFail
	jal escolher_tabuleiro
	
	add a0, a0, zero
    add a1, a1, zero
	li a2, 0 
    la a3, campo
	jal inicializa_matriz

	add a0, a0, zero
    add a1, a1, zero
	li a2, 10
    la a3, interface
	jal inicializa_matriz
	
	add a0, a0, zero
	add a1, a1, zero
		
	add s11, a0, zero
	add s10, a1, zero

	la a2, interface
	la a3, indices
	jal mostra_campo
	
	la a0, campo
	mv a1, s0
	jal INSERE_BOMBA
	
	# remover
	add a0, s11, zero
	add a1, s10, zero
	la a2, campo
	la a3, indices
	jal mostra_campo
	# remover

	# calcula bombas
	
	add a0, s11, zero
	la a1, inputFail
	jal menu_de_jogadas
	
	add a0, s11, zero
	add a1, s10, zero
	la a2, campo
	la a3, indices
	jal mostra_campo
	
	j main

sair:
	li a7, 10
	ecall
escolher_tabuleiro:
	add t0, a1, zero  
	li a7, 4
	ecall
	li a7, 5
	ecall
	li t1, 1
	li t2, 2
	li t3, 3
	li t4, 4
	beq a0, t1, carregar_dados_oito
	beq a0, t2, carregar_dados_dez
	beq a0, t3, carregar_dados_doze
	beq a0, t4, sair
	li a7, 4
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
	li a7, 4
	la a0, espaco_em_branco
	ecall
for_mostrar_index:
	beq t0, t1, continua
	li a7, 4
	la a0, espaco_em_branco
	ecall
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
	li a7, 4
	la a0, espaco_em_branco
	ecall
	li a7, 1
	lw a0, (t2)
	ecall
	add t2, t2, s7
for_dentro_mostra_campo:
	beq t1, t3, fim_for_dentro_mostra_campo
	li t4, 10
	li t5, 9
	li a7, 4
	la a0, espaco_em_branco
	ecall
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

menu_de_jogadas:
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
	add s9, a0, zero
	li a7, 4
	la a0, menu_linha
	ecall

	li a7, 5
	ecall

	blt a0, zero, menu_jogadas_erro
	bge a0, s0, menu_jogadas_erro
	add t0, zero, a0

	li a7, 4
	la a0, menu_coluna
	ecall

	li a7, 5
	ecall

	blt a0, zero, menu_jogadas_erro
	bge a0, s0, menu_jogadas_erro
	add t1, zero, a0
	li s8, 1
	mul t0, t0, s0
	add t0,	t0, t1
	mul t0, t0, s7
	beq s9, s8, abre_casa
	j movimentar_flag
abre_casa:
	la t1, interface
	add t4, t0, t1
	lw t2, (t4)
	bltz t2, menu_jogadas_erro_flag
	la t1, campo
	add t6, t0, t1
	lw t2, (t6)
	li t3, 9
	beq t2, t3, perdeu
	sw t2, (t4)
	j exibe_interface_volta_menu
movimentar_flag:
	la t1, interface
	add t0, t0, t1
	addi t2, zero, -1
	lw t3, (t0)
	li t5, 10
	bne t3, t5, valida_erro_campo_ja_aberto
pode_mudar:
	mul t2,t2,t3
	sw t2, (t0)
	j exibe_interface_volta_menu
valida_erro_campo_ja_aberto:
	li t5, -10
	beq t3, t5, pode_mudar
	j erro_campo_ja_aberto
exibe_interface_volta_menu:
	add s2, zero, ra
	add a0, s0, zero
	add a1, s1, zero
	la a2, interface
	la a3, indices
	jal mostra_campo
	add ra, s2, zero
	j inicia_menu_jogadas
	ret
menu_jogadas_erro:
	li a7, 4
    la a0, inputFail
	ecall
	j inicia_menu_jogadas
menu_jogadas_erro_flag:
	li a7, 4
    la a0, mensagem_erro_flag
	ecall
	j inicia_menu_jogadas
erro_campo_ja_aberto:
	li a7, 4
    la a0, mensagem_erro_campo_ja_aberto
	ecall
	j inicia_menu_jogadas
perdeu:
	li a7, 4
    la a0, mensagem_perdeu
    ecall
	ret
	
INSERE_BOMBA:
	la	t0, salva_S0
	sw  	s0, 0 (t0)		
	la	t0, salva_ra
	sw  	ra, 0 (t0)		
		
	add 	t0, zero, a0		
	add 	t1, zero, a1		

QTD_BOMBAS:
	addi 	t2, zero, 15 		
	add 	t3, zero, zero 	
	addi 	a7, zero, 30 		
	ecall 				
	add 	a1, zero, a0		
INICIO_LACO:
	beq 	t2, t3, FIM_LACO
	add 	a0, zero, t1 		
	jal 	PSEUDO_RAND
	add 	t4, zero, a0		
	add 	a0, zero, t1 		
   	jal 	PSEUDO_RAND
	add 	t5, zero, a0		
LE_POSICAO:	
	mul  	t4, t4, t1
	add  	t4, t4, t5  		
	add  	t4, t4, t4  		
	add  	t4, t4, t4  		
	add  	t4, t4, t0  		
	lw   	t5, 0(t4)   		
VERIFICA_BOMBA:		
	addi 	t6, zero, 9		
	beq  	t5, t6, PULA_ATRIB	
	sw   	t6, 0(t4)		
	addi 	t3, t3, 1		
PULA_ATRIB:
	j	INICIO_LACO

FIM_LACO:					
	la	t0, salva_S0
	lw  	s0, 0(t0)		
	la	t0, salva_ra
	lw  	ra, 0(t0)		
	jr 	ra			

PSEUDO_RAND:
	addi t6, zero, 125  		
	lui  t5, 682			
	addi t5, t5, 1697 		 
	addi t5, t5, 1034 		 	
	mul  a1, a1, t6			
	rem  a1, a1, t5			
	rem  a0, a1, a0			
	bge  a0, zero, EH_POSITIVO  	
	addi s2, zero, -1           	
	mul  a0, a0, s2		    	
EH_POSITIVO:	
		ret				
