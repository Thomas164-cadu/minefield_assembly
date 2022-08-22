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
inputFail:	.asciz "\nOpção inválida, favor inserir novamente\n"
cerquilha:	.asciz "#"
quebra_linha:	.asciz "\n"
asterisco:	.asciz "*"
flag:	.asciz "F"
espaco_em_branco:	.asciz " "
menu_linha:	.asciz "\nQual a linha de sua jogada?\n"
menu_coluna:	.asciz "\nQual a coluna de sua jogada?\n"
menu_escolha_jogada:	.asciz "\nVocê deseja: \n1 - Abrir uma casa \n2 - Movimentar uma flag\n"
mensagem_perdeu:	.asciz "\nPoxa, você perdeu!\nNão fica assim não, que tal jogar novamente?\nSó não perde quem não joga\n"
mensagem_ganhou:	.asciz "\nBoa, você ganhou meu chapa!\nQue tal continuar mostrando essa habilidade e desafiando nosso código Assembly?\n"
mensagem_erro_flag:	.asciz "\nVish, essa casa aí já tem flag meu chapa!\n"
mensagem_erro_campo_ja_aberto:	.asciz "\nVish, essa casa aí já foi aberta meu chapa!\n"
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

	la a0, campo
	mv a1, s0
	jal calcula_bombas
	
	add a0, s11, zero
	la a1, inputFail
	jal menu_de_jogadas
	
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
	li t3, 10
	bne t2, t3, erro_campo_ja_aberto
	la t1, campo
	add t6, t0, t1
	lw t2, (t6)
	li t3, 9
	beq t2, t3, perdeu
	sw t2, (t4)
	j verifica_se_ganhou
volta_abre_casa:
	j exibe_interface_volta_menu
verifica_se_ganhou:
	li t5, 10
	li t3, -10
	li t6, 0
	la t1, interface
	mul t2, s0, s0
	mul t2, t2, s7
	add t2, t2, t1
for_verificar_ganhou:
	beq t2, t1, termina_for_verificar_ganhou
	lw t4, (t1)
	beq t4, t5, incrementa
	beq t4, t3, incrementa
	add t1, t1, s7
	j for_verificar_ganhou
incrementa:
	addi t6, t6, 1
	add t1, t1, s7
	j for_verificar_ganhou
termina_for_verificar_ganhou:
	li t5, 15
	beq t5, t6, ganhou
	j volta_abre_casa
ganhou:
	li a7, 4
    la a0, mensagem_ganhou
    ecall
	j exibe_campo_e_ret
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
	add s4, zero, ra
	add a0, s0, zero
	add a1, s1, zero
	la a2, interface
	la a3, indices
	jal mostra_campo
	add ra, s4, zero
	j inicia_menu_jogadas
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
exibe_campo_e_ret:
	add s4, zero, ra
	add a0, s0, zero
	add a1, s1, zero
	la a2, campo
	la a3, indices
	jal mostra_campo
	add ra, s4, zero
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
calcula_bombas:
    li s9, 9 
    add s7, s7, zero 
    mul t1, a1, a1
    mul t1, t1, s7
    add t1, t1, a0
    mv t0, a0 
for_calcula_bombas:
    beq t0, t1, fim_calcula_bombas
    lw t3, (t0)
    beq t3, s9, valida_bomba 
continua_for_calcula_bombas:
    add t0, t0, s7 
    j for_calcula_bombas
valida_bomba:
valida_direita:
    add t4, t0, s7 
    lw t5, (t4) 
    bne t5, s9, continua_valida_direita 
    j valida_esquerda 
continua_valida_direita:
    sub s5, t4, a0
	div s5, s5, s7
    rem t6, s5, a1 
    bne t6, zero, salva_valida_direita 
    j valida_esquerda
salva_valida_direita:
    addi t5, t5, 1
    sw t5, (t4)
valida_esquerda:
    sub t4, t0, s7 
    lw t5, (t4) 
    bne t5, s9, continua_valida_esquerda
    j valida_por_cima 
continua_valida_esquerda:
    sub s5, t4, a0
	div s5, s5, s7
    rem t6, s5, a1 
    addi s5, a1, -1
    bne t6, s5, salva_valida_esquerda 
    j valida_por_cima
salva_valida_esquerda:
    addi t5, t5, 1
    sw t5, (t4)
valida_por_cima:
    mul t6, a1, s7
    sub t6, t0, t6 
    bgt t6, a0, valida_meio_cima
    j valida_por_baixo
valida_meio_cima:
    lw t5, (t6)
    bne t5, s9, continua_valida_por_cima
    j valida_esquerda_cima 
continua_valida_por_cima:
    addi t5, t5, 1
    sw t5, (t6)
valida_esquerda_cima:
    sub s1, t6, s7 
    bgt s1, zero, continua_continua_valida_esquerda_cima
    j valida_direita_cima
continua_continua_valida_esquerda_cima:
    lw t5, (s1)
    bne t5, s9, continua_valida_esquerda_cima
    j valida_direita_cima
continua_valida_esquerda_cima:
    addi s5, a1, -1
    sub s8, s1, a0
	div s8, s8, s7
    rem s2, s8, a1
    bne s2, s5, salva_valida_esquerda_cima
    j valida_direita_cima
salva_valida_esquerda_cima:
    addi t5, t5, 1
    sw t5, (s1)
valida_direita_cima:
    add s1, t6, s7 
    lw t5, (s1)
    bne t5, s9, continua_valida_direita_cima
    j valida_por_baixo
continua_valida_direita_cima:
    sub s8, s1, a0
	div s8, s8, s7
    rem s2, s8, a1
    bne s2, zero, salva_valida_direita_cima
    j valida_por_baixo
salva_valida_direita_cima:
    addi t5, t5, 1
    sw t5, (s1)
valida_por_baixo:
    mul t6, a1, s7
    add t6, t0, t6 
    blt t6, t1, valida_meio_baixo
    j continua_for_calcula_bombas
valida_meio_baixo:
    lw t5, (t6)
    bne t5, s9, continua_valida_meio_baixo
    j valida_esquerda_baixo 
continua_valida_meio_baixo:
    addi t5, t5, 1
    sw t5, (t6)
valida_esquerda_baixo:
    sub s1, t6, s7 
    lw t5, (s1)
    bne t5, s9, continua_valida_esquerda_baixo
    j valida_direita_baixo
continua_valida_esquerda_baixo:
    addi s5, a1, -1
    sub s8, s1, a0
	div s8, s8, s7
    rem s2, s8, a1
    bne s2, s5, salva_valida_esquerda_baixo
    j valida_direita_baixo
salva_valida_esquerda_baixo:
    addi t5, t5, 1
    sw t5, (s1)
valida_direita_baixo:
    add s1, t6, s7
    blt t1, s1, continua_for_calcula_bombas
    lw t5, (s1)
    bne t5, s9, continua_valida_direita_baixo
    j continua_for_calcula_bombas
continua_valida_direita_baixo:
    sub s5, s1, a0
	div s5, s5, s7
    rem s2, s5, a1
    bne s2, zero, salva_valida_direita_baixo
    j continua_for_calcula_bombas
salva_valida_direita_baixo:
    addi t5, t5, 1
    sw t5, (s1)
    j continua_for_calcula_bombas
fim_calcula_bombas:
    ret