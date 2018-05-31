--[[Valmir Torres de Jesus Junior		128745
	Compiladores 30-05-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Funções necessárias para o analisador sintático-
]]

function gramatica_glc ()
	--Gramatica livre de contexto da linguagem Mgol
	local glc = {
		[1] = 'S -> P',
		[2] = 'P -> inicio V A',
		[3] = 'V -> varinicio LV',
		[4] = 'LV -> D LV',
		[5] = 'LV -> varfim;',
		[6] = 'D -> id TIPO;',
		[7] = 'TIPO -> int',
		[8] = 'TIPO -> real',
		[9] = 'TIPO -> literal',
		[10] = 'A -> ES A',
		[11] = 'ES -> leia id;',
		[12] = 'ES -> escreva ARG;',
		[13] = 'ARG -> literal',
		[14] = 'ARG -> num',
		[15] = 'ARG -> id',
		[16] = 'A -> CMD A',
		[17] = 'CMD -> id rcb LD;',
		[18] = 'LD -> OPRD opm OPRD',
		[19] = 'LD -> OPRD',
		[20] = 'OPRD -> id',
		[21] = 'OPRD -> num',
		[22] = 'A -> COND A',
		[23] = 'COND -> CABEÇALHO CORPO',
		[24] = 'CABEÇALHO -> se (EXP_R) entao',
		[25] = 'EXP_R -> OPRD opr OPRD',
		[26] = 'CORPO -> ES CORPO',
		[27] = 'CORPO -> CMD CORPO',
		[28] = 'CORPO -> COND CORPO',
		[29] = 'CORPO -> fimse',
		[30] = 'A -> fim', 
	}
	
	return glc
end

--Tabela Sintática Shift/Reduce
function tabela_sintatica_sr ()
	--Criando a tabela sintatica a partir do automato LR(0)
	local tabela_shift_reduce = {}
	for i = 1, 59 do 
		tabela_shift_reduce[i] = {}
	end
	
	--Inicializando a matriz tabela_shift_reduce
	--indice 1-21 = terminais
	--indice 22-36 = nao-terminais
	for i = 1, 59 do 
		for j = 1, 36 do
			tabela_shift_reduce[i][j] = { ['operacao'] = 'Erro! Bad syntax...', ['estado'] = nil,}
		end
	end
	
	--Estado 1
	tabela_shift_reduce[1][1] = { ['operacao'] = 'Shift', ['estado'] = 3,} --terminal inicio
	tabela_shift_reduce[1][22] = { ['operacao'] = nil, ['estado'] = 2,} --nao-terminal P
	
	--Estado 2 --Estado de redução--
	tabela_shift_reduce[2][21] = { ['operacao'] = 'Aceita!', ['estado'] = true,} -- terminal $
	
	--Estado 3
	tabela_shift_reduce[3][2] = { ['operacao'] = 'Shift', ['estado'] = 5,} --terminal varinicio
	tabela_shift_reduce[3][23] = { ['operacao'] = nil, ['estado'] = 4,} --nao-terminal V
	
	--Estado 4
	tabela_shift_reduce[4][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[4][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[4][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[4][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[4][20] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[4][24] = { ['operacao'] = nil, ['estado'] = 6,} --nao-terminal A
	tabela_shift_reduce[4][28] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[4][30] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[4][33] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[4][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	
	
	--Estado 5
	tabela_shift_reduce[5][3] = { ['operacao'] = 'Shift', ['estado'] = 18,} --termial varfim
	tabela_shift_reduce[5][9] = { ['operacao'] = 'Shift', ['estado'] = 19,} --termial id
	tabela_shift_reduce[5][25] = { ['operacao'] = nil, ['estado'] = 16,} --nao-terminal LV
	tabela_shift_reduce[5][26] = { ['operacao'] = nil, ['estado'] = 17,} --nao-terminal D
	
	--Estado 6 --Estado de redução--
	tabela_shift_reduce[6][21] = { ['operacao'] = 'Reduce', ['estado'] = 2,} --termial $
	
	--Estado 7
	tabela_shift_reduce[7][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[7][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[7][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[7][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[7][20] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[7][24] = { ['operacao'] = nil, ['estado'] = 20,} --nao-terminal A
	tabela_shift_reduce[7][28] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[7][30] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[7][33] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[7][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	
	--Estado 8
	tabela_shift_reduce[8][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[8][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[8][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[8][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[8][20] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[8][24] = { ['operacao'] = nil, ['estado'] = 21,} --nao-terminal A
	tabela_shift_reduce[8][28] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[8][30] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[8][33] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[8][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	
	--Estado 9
	tabela_shift_reduce[9][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[9][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[9][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[9][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[9][20] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[9][24] = { ['operacao'] = nil, ['estado'] = 22,} --nao-terminal A
	tabela_shift_reduce[9][28] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[9][30] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[9][33] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[9][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	
	--Estado 10 --Estado de redução--
	tabela_shift_reduce[10][21] = { ['operacao'] = 'Reduce', ['estado'] = 30,} --termial $
	
	--Estado 11
	tabela_shift_reduce[11][9] = { ['operacao'] = 'Shift', ['estado'] = 23,} -- terminal id
	
	--Estado 12
	tabela_shift_reduce[12][7] = { ['operacao'] = 'Shift', ['estado'] = 25,} -- terminal literal
	tabela_shift_reduce[12][9] = { ['operacao'] = 'Shift', ['estado'] = 27,} -- terminal id
	tabela_shift_reduce[12][11] = { ['operacao'] = 'Shift', ['estado'] = 26,} -- terminal num
	tabela_shift_reduce[12][29] = { ['operacao'] = nil, ['estado'] = 24,} --nao-terminal ARG

	--Estado 13
	tabela_shift_reduce[13][12] = { ['operacao'] = 'Shift', ['estado'] = 28,} -- terminal rcb
	
	--Estado 14
	tabela_shift_reduce[14][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[14][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[14][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[14][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[14][19] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[14][28] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[14][30] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[14][33] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[14][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[14][36] = { ['operacao'] = nil, ['estado'] = 29,} --nao-terminal CORPO
	
	--Estado 15
	tabela_shift_reduce[15][15] = { ['operacao'] = 'Shift', [2] = 33,} -- terminal (
	
	--Estado 16 --Estado de redução
	tabela_shift_reduce[16][8] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial leia
	tabela_shift_reduce[16][9] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial id
	tabela_shift_reduce[16][10] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial escreva
	tabela_shift_reduce[16][14] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial se
	tabela_shift_reduce[16][20] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial fim
	
	--Estado 17
	tabela_shift_reduce[17][3] = { ['operacao'] = 'Shift', [2] = 18,} -- terminal varfim
	tabela_shift_reduce[17][9] = { ['operacao'] = 'Shift', [2] = 19,} -- terminal id
	tabela_shift_reduce[17][25] = { ['operacao'] = nil, ['estado'] = 34,} --nao-terminal LV
	tabela_shift_reduce[17][26] = { ['operacao'] = nil, ['estado'] = 17,} --nao-terminal D
	
	--Estado 18
	tabela_shift_reduce[18][4] = { ['operacao'] = 'Shift', [2] = 35,} -- terminal ;
	
	--Estado 19
	tabela_shift_reduce[19][5] = { ['operacao'] = 'Shift', [2] = 37,} -- terminal varfim
	tabela_shift_reduce[19][6] = { ['operacao'] = 'Shift', [2] = 38,} -- terminal varfim
	tabela_shift_reduce[19][7] = { ['operacao'] = 'Shift', [2] = 39,} -- terminal varfim
	tabela_shift_reduce[19][27] = { ['operacao'] = nil, ['estado'] = 36,} --nao-terminal TIPO
	
	--Estado 20 --Estado de redução--
	tabela_shift_reduce[20][21] = { ['operacao'] = 'Reduce', ['estado'] = 10,} --termial $
	
	--Estado 21 --Estado de redução--
	tabela_shift_reduce[21][21] = { ['operacao'] = 'Reduce', ['estado'] = 16,} --termial $
	
	--Estado 22 --Estado de redução--
	tabela_shift_reduce[22][21] = { ['operacao'] = 'Reduce', ['estado'] = 22,} --termial $
	
	--Estado 23
	tabela_shift_reduce[23][4] = { ['operacao'] = 'Shift', [2] = 40,} -- terminal ;
	
	--Estado 24
	tabela_shift_reduce[24][4] = { ['operacao'] = 'Shift', [2] = 59,} -- terminal ;
	
	--Estado 25 --Estado de redução
	tabela_shift_reduce[25][4] = { ['operacao'] = 'Reduce', ['estado'] = 13,} --termial ;
	
	--Estado 26 --Estado de redução
	tabela_shift_reduce[26][4] = { ['operacao'] = 'Reduce', ['estado'] = 14,} --termial ;
	
	--Estado 27 --Estado de redução
	tabela_shift_reduce[27][4] = { ['operacao'] = 'Reduce', ['estado'] = 15,} --termial ;
	
	--Estado 28
	tabela_shift_reduce[28][9] = { ['operacao'] = 'Shift', [2] = 43,} -- terminal id
	tabela_shift_reduce[28][11] = { ['operacao'] = 'Shift', [2] = 44,} -- terminal num
	tabela_shift_reduce[28][31] = { ['operacao'] = nil, ['estado'] = 41,} --nao-terminal LD
	tabela_shift_reduce[28][32] = { ['operacao'] = nil, ['estado'] = 42,} --nao-terminal OPRD
	
	--Estado 29 --Estado de redução
	tabela_shift_reduce[29][8] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial leia
	tabela_shift_reduce[29][9] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial id
	tabela_shift_reduce[29][10] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial escreva	
	tabela_shift_reduce[29][14] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial se
	tabela_shift_reduce[29][19] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial fimse
	tabela_shift_reduce[29][20] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial fim
	
	--Estado 30
	tabela_shift_reduce[30][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[30][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[30][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[30][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[30][19] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[30][28] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[30][30] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[30][33] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[30][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[30][36] = { ['operacao'] = nil, ['estado'] = 45,} --nao-terminal CORPO
	
	--Estado 31
	tabela_shift_reduce[31][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[31][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[31][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[31][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[31][19] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[31][28] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[31][30] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[31][33] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[31][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[31][36] = { ['operacao'] = nil, ['estado'] = 46,} --nao-terminal CORPO
	
	--Estado 32
	tabela_shift_reduce[32][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[32][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[32][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[32][14] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[32][19] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[32][28] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[32][30] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[32][33] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[32][34] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[32][36] = { ['operacao'] = nil, ['estado'] = 47,} --nao-terminal CORPO
	
	--Estado 33
	tabela_shift_reduce[33][9] = { ['operacao'] = 'Shift', [2] = 43,} -- terminal id
	tabela_shift_reduce[33][11] = { ['operacao'] = 'Shift', [2] = 44,} -- terminal num
	tabela_shift_reduce[33][32] = { ['operacao'] = nil, ['estado'] = 49,} --nao-terminal OPRD
	tabela_shift_reduce[33][35] = { ['operacao'] = nil, ['estado'] = 48,} --nao-terminal EXP_R
	
	--Estado 34 --Estado de redução
	tabela_shift_reduce[34][8] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial leia
	tabela_shift_reduce[34][9] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial id
	tabela_shift_reduce[34][10] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial escreva
	tabela_shift_reduce[34][14] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial se
	tabela_shift_reduce[34][20] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial fim
	
	--Estado 35 --Estado de redução
	tabela_shift_reduce[35][8] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial leia
	tabela_shift_reduce[35][9] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial id
	tabela_shift_reduce[35][10] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial escreva
	tabela_shift_reduce[35][14] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial se
	tabela_shift_reduce[35][20] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial fim
	
	--Estado 36
	tabela_shift_reduce[36][4] = { ['operacao'] = 'Shift', ['estado'] = 50,} --termial ;
	
	--Estado 37 --Estado de redução
	tabela_shift_reduce[37][4] = { ['operacao'] = 'Reduce', ['estado'] = 7,} --termial ;
	
	--Estado 38 --Estado de redução
	tabela_shift_reduce[38][4] = { ['operacao'] = 'Reduce', ['estado'] = 8,} --termial ;
	
	--Estado 39 --Estado de redução
	tabela_shift_reduce[39][4] = { ['operacao'] = 'Reduce', ['estado'] = 9,} --termial ;
	
	--Estado 40 --Estado de redução
	tabela_shift_reduce[40][8] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial leia
	tabela_shift_reduce[40][9] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial id
	tabela_shift_reduce[40][10] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial escreva	
	tabela_shift_reduce[40][14] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial se
	tabela_shift_reduce[40][19] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial fimse
	tabela_shift_reduce[40][20] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial fim
	
	--Estado 41
	tabela_shift_reduce[41][4] = { ['operacao'] = 'Shift', ['estado'] = 51,} --termial ;
	
	--Estado 42 --Estado de redução
	tabela_shift_reduce[42][4] = { ['operacao'] = 'Reduce', ['estado'] = 19,} --termial ;
	tabela_shift_reduce[42][13] = { ['operacao'] = 'Shift', ['estado'] = 52,} --termial opm
	
	--Estado 43 --Estado de redução
	tabela_shift_reduce[43][4] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial ;
	tabela_shift_reduce[43][13] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial opm
	tabela_shift_reduce[43][16] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial )
	tabela_shift_reduce[43][18] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial opr
	
	--Estado 44 --Estado de redução
	tabela_shift_reduce[44][4] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial ;
	tabela_shift_reduce[44][13] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial opm
	tabela_shift_reduce[44][16] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial )
	tabela_shift_reduce[44][18] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial opr
	
	--Estado 45 --Estado de redução
	tabela_shift_reduce[45][8] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial leia
	tabela_shift_reduce[45][9] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial id
	tabela_shift_reduce[45][10] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial escreva	
	tabela_shift_reduce[45][14] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial se
	tabela_shift_reduce[45][19] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial fimse
	tabela_shift_reduce[45][20] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial fim
	
	--Estado 46 --Estado de redução
	tabela_shift_reduce[46][8] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial leia
	tabela_shift_reduce[46][9] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial id
	tabela_shift_reduce[46][10] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial escreva	
	tabela_shift_reduce[46][14] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial se
	tabela_shift_reduce[46][19] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial fimse
	tabela_shift_reduce[46][20] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial fim
	
	--Estado 47 --Estado de redução
	tabela_shift_reduce[47][8] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial leia
	tabela_shift_reduce[47][9] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial id
	tabela_shift_reduce[47][10] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial escreva	
	tabela_shift_reduce[47][14] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial se
	tabela_shift_reduce[47][19] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial fimse
	tabela_shift_reduce[47][20] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial fim
	
	--Estado 48
	tabela_shift_reduce[48][16] = { ['operacao'] = 'Shift', ['estado'] = 53,} --termial )
	
	--Estado 49
	tabela_shift_reduce[49][18] = { ['operacao'] = 'Shift', ['estado'] = 54,} --termial opr
	
	--Estado 50 --Estado de redução
	tabela_shift_reduce[50][3] = { ['operacao'] = 'Reduce', ['estado'] = 6,} --termial varfim
	tabela_shift_reduce[50][9] = { ['operacao'] = 'Reduce', ['estado'] = 6,} --termial id
	
	--Estado 51 --Estado de redução
	tabela_shift_reduce[51][8] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial leia
	tabela_shift_reduce[51][9] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial id
	tabela_shift_reduce[51][10] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial escreva	
	tabela_shift_reduce[51][14] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial se
	tabela_shift_reduce[51][19] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial fimse
	tabela_shift_reduce[51][20] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial fim
	
	--Estado 52
	tabela_shift_reduce[52][9] = { ['operacao'] = 'Shift', [2] = 43,} -- terminal id
	tabela_shift_reduce[52][11] = { ['operacao'] = 'Shift', [2] = 44,} -- terminal num
	tabela_shift_reduce[52][32] = { ['operacao'] = nil, ['estado'] = 55,} --nao-terminal OPRD
	
	--Estado 53
	tabela_shift_reduce[53][17] = { ['operacao'] = 'Shift', [2] = 56,} -- terminal entao
	
	--Estado 54
	tabela_shift_reduce[54][9] = { ['operacao'] = 'Shift', [2] = 43,} -- terminal id
	tabela_shift_reduce[54][11] = { ['operacao'] = 'Shift', [2] = 44,} -- terminal num
	tabela_shift_reduce[54][32] = { ['operacao'] = nil, ['estado'] = 57,} --nao-terminal OPRD
	
	--Estado 55 --Estado de redução
	tabela_shift_reduce[55][4] = { ['operacao'] = 'Reduce', ['estado'] = 18,} --termial ;
	
	--Estado 56 --Estado de redução
	tabela_shift_reduce[56][8] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial leia
	tabela_shift_reduce[56][9] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial id
	tabela_shift_reduce[56][10] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial escreva	
	tabela_shift_reduce[56][14] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial se
	tabela_shift_reduce[56][19] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial fimse
	
	--Estado 57 --Estado de redução
	tabela_shift_reduce[57][16] = { ['operacao'] = 'Reduce', ['estado'] = 25,} --termial )
	
	--Estado 58 --Estado de redução
	tabela_shift_reduce[58][8] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial leia
	tabela_shift_reduce[58][9] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial id
	tabela_shift_reduce[58][10] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial escreva	
	tabela_shift_reduce[58][14] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial se
	tabela_shift_reduce[58][19] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial fimse
	tabela_shift_reduce[58][20] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial fim
	
	--Estado 59 --Estado de redução
	tabela_shift_reduce[59][8] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial leia
	tabela_shift_reduce[59][9] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial id
	tabela_shift_reduce[59][10] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial escreva	
	tabela_shift_reduce[59][14] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial se
	tabela_shift_reduce[59][19] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial fimse
	tabela_shift_reduce[59][20] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial fim
	
	return tabela_shift_reduce
end
