
# a0 => pos inicial do vetor
# a1 => tamanho do lado do campo
calcula_bombas:
    li t0, 1 # 1
    li s9, 9 # 9
    add s7, s7, zero # 4
    mul t1, a1, a1
    mul t1, t1, s7
    add t1, t1, a0
    mv t2, a0 
for_calcula_bombas:
    beq t1, t2, fim_calcula_bombas
    lw t3, (t2)
    add t2, t2, s7 # incrementa for
    beq t3, s9, valida_bomba
    j for_calcula_bombas
valida_bomba:
    j valida_direita
valida_direita:
    add t4, t2, s7 # j = i + 1;
    lw t5, (t4) # vetor[j] 
    beq t5, s9, valida_esquerda # if vetor[j] != 9
    # bgt t4, t1, valida_esquerda
    sub t6, t4, a0
    div t6, t6, s7
    rem t6, t6, a1
    beq t6, zero, valida_esquerda # if j % 12 != 0
    add t5, t5, t0
    sw t5, (t4)
valida_esquerda:
    sub t4, t2, s7 # j = i - 1
    lw t5, (t4) # vetor[j] 
    beq t5, s9, valida_por_cima # if vetor[j] != 9
    # blt t4, a0, valida_acima
    sub t6, t4, a0
    div t6, t6, s7
    rem t6, t6, a1
    sub s5, a1, t0
    beq t6, s5, valida_por_cima # j % 12 != 11
    add t5, t5, t0
    sw t5, (t4)
valida_por_cima:
    mul t6, a1, s7 # auxaux = 8 x 4 = 64
    sub t4, t2, t6 # aux = auxaux - 64		i-12
    lw t5, (t4) # vetor[aux]
    blt t4, a0, valida_acima
valida_acima:
    beq t5, s9, valida_abaixo # vetor[aux] != 9
    add t5, t5, t0
    sw t5, (t4)
valida_diagonal_esquerda_cima:

    beq t5, s9, valida_diagonal_esquerda_baixo
    blt t4, a0, valida_diagonal_esquerda_baixo
    add t5, t5, t0
    sw t5, (t4)
valida_diagonal_direita_cima:
    mul t6, a1, s7
    sub t6, t6, s7
    sub t4, t2, t6
    lw t5, (t4)
    beq t5, s9, valida_diagonal_direita_baixo
    blt t4, a0, valida_diagonal_direita_baixo
    add t5, t5, t0
    sw t5, (t4)

valida_por_baixo:

valida_abaixo:
    mul t6, a1, s7
    add t4, t2, t6
    lw t5, (t4)
    beq t5, s9, valida_diagonal_esquerda_cima
    blt t4, a0, valida_diagonal_esquerda_cima
    add t5, t5, t0
    sw t5, (t4)
valida_diagonal_esquerda_baixo:
    mul t6, a1, s7
    sub t6, t6, s7
    add t4, t2, t6
    lw t5, (t4)
    beq t5, s9, valida_diagonal_direita_cima
    bgt t4, t1, valida_diagonal_direita_cima
    add t5, t5, t0
    sw t5, (t4)
valida_diagonal_direita_baixo:
    mul t6, a1, s7
    add t6, t6, s7
    add t4, t2, t6
    lw t5, (t4)
    beq t5, s9, termina_validacao
    bgt t4, t1, termina_validacao
    add t5, t5, t0
    sw t5, (t4)
termina_validacao:
    j for_calcula_bombas
fim_calcula_bombas:
    ret