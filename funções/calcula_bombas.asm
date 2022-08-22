
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