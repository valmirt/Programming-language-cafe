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
	
	--Estado s14
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
	
	--Estado 19
	
	--Estado 20
end
