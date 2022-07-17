		.data
# valores inteiros
interface:		.space 576
campo:		    .space 576
		.text
main:
	# vars que vamos usar ao longo do main
	li s7, 4 
	
	# inicializa matriz
    la a0, interface
    li a1, 144
	li a2, 10 
	jal inicializa_matriz
	
	li a7, 10   # chamada de sistema para encerrar programa
	ecall


# Função inicializa_matriz
# parametros
# a0 => endereço inicial da matriz
# a1 => tamanho matriz (64/100/144)
# a2 => valor pra inicializar com
# retorno 
# nao tem

inicializa_matriz:
	add t0, a0, zero 
	mul t1, a1, s7
	add t1, a0, t1
for_inicializa_matriz:
	beq t1, t0, termina_for_inicializar
	sw a2, (t0)
	add t0, t0, s7
	j for_inicializa_matriz
termina_for_inicializar:
	ret

