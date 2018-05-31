--[[Valmir Torres de Jesus Junior		128745
	Compiladores 30-05-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Funções necessárias para o analisador léxico-
]]

function palavras_reservadas ()
	local tabela_simbolos = {
		[1] = {
			['token'] = 'inicio',
			['lexema'] = 'inicio',
			['tipo'] = nil,
		},
		[2] = {
			['token'] = 'varinicio',
			['lexema'] = 'varinicio',
			['tipo'] = nil,
		},
		[3] = {
			['token'] = 'varfim',
			['lexema'] = 'varfim',
			['tipo'] = nil,
		},
		[4] = {
			['token'] = 'escreva',
			['lexema'] = 'escreva',
			['tipo'] = nil,
		},
		[5] = {
			['token'] = 'leia',
			['lexema'] = 'leia',
			['tipo'] = nil,
		},
		[6] = {
			['token'] = 'se',
			['lexema'] = 'se',
			['tipo'] = nil,
		},
		[7] = {
			['token'] = 'entao',
			['lexema'] = 'entao',
			['tipo'] = nil,
		},
		[8] = {
			['token'] = 'senao',
			['lexema'] = 'senao',
			['tipo'] = nil,
		},
		[9] = {
			['token'] = 'fimse',
			['lexema'] = 'fimse',
			['tipo'] = nil,
		},
		[10] = {
			['token'] = 'fim',
			['lexema'] = 'fim',
			['tipo'] = nil,
		},
		[11] = {
			['token'] = 'inteiro',
			['lexema'] = 'inteiro',
			['tipo'] = nil,
		},
		[12] = {
			['token'] = 'literal',
			['lexema'] = 'literal',
			['tipo'] = nil,
		},
		[13] = {
			['token'] = 'real',
			['lexema'] = 'real',
			['tipo'] = nil,
		},
	}
	
	return tabela_simbolos
end

function dfa_regular ()
	local dfa = {}
	for i = 1, 22 do 
		dfa[i] = {}
	end
	
	--Estado s1
	dfa[1][1] = 2 -- +
	dfa[1][2] = 2 -- -
	dfa[1][3] = 2 -- *
	dfa[1][4] = 2 -- /
	dfa[1][5] = 3 -- Digitos
	dfa[1][6] = 22 -- .
	dfa[1][7] = 9 -- e
	dfa[1][8] = 9 -- E
	dfa[1][9] = 9 -- Literal
	dfa[1][10] = 22 -- _
	dfa[1][11] = 12 -- {
	dfa[1][12] = 22 -- }
	dfa[1][13] = 10 -- "
	dfa[1][14] = 14 -- >
	dfa[1][15] = 21 -- =
	dfa[1][16] = 15 -- <
	dfa[1][17] = 18 -- )
	dfa[1][18] = 19 -- (
	dfa[1][19] = 20 -- ;
	dfa[1][20] = 1 -- space
	dfa[1][21] = 22 -- \ e :
	
	--Estado s2
	for i = 1, 20 do
		dfa[2][i] = 1
	end
	
	--Estado s3
	dfa[3][1] = 1
	dfa[3][2] = 1
	dfa[3][3] = 1
	dfa[3][4] = 1
	dfa[3][5] = 3
	dfa[3][6] = 4
	dfa[3][7] = 6
	dfa[3][8] = 6
	for i = 9, 21 do
		dfa[3][i] = 1
	end
	
	--Estado s4
	dfa[4][1] = 22
	dfa[4][2] = 22
	dfa[4][3] = 22
	dfa[4][4] = 22
	dfa[4][5] = 5
	for i = 6, 21 do
		dfa[4][i] = 22
	end
	
	--Estado s5
	dfa[5][1] = 1
	dfa[5][2] = 1
	dfa[5][3] = 1
	dfa[5][4] = 1
	dfa[5][5] = 5
	dfa[5][6] = 1
	dfa[5][7] = 6
	dfa[5][8] = 6
	for i = 9, 21 do
		dfa[5][i] = 1
	end
	
	--Estado s6
	dfa[6][1] = 7
	dfa[6][2] = 7
	dfa[6][3] = 22
	dfa[6][4] = 22
	dfa[6][5] = 8
	for i = 6, 21 do
		dfa[6][i] = 22
	end
	
	--Estado s7
	dfa[7][1] = 22
	dfa[7][2] = 22
	dfa[7][3] = 22
	dfa[7][4] = 22
	dfa[7][5] = 8
	for i = 6, 21 do
		dfa[7][i] = 22
	end
		
	--Estado s8
	dfa[8][1] = 1
	dfa[8][2] = 1
	dfa[8][3] = 1
	dfa[8][4] = 1
	dfa[8][5] = 8
	for i = 6, 21 do
		dfa[8][i] = 1
	end
	
	--Estado s9
	dfa[9][1] = 1
	dfa[9][2] = 1
	dfa[9][3] = 1
	dfa[9][4] = 1
	dfa[9][5] = 9
	dfa[9][6] = 1
	dfa[9][7] = 9
	dfa[9][8] = 9
	dfa[9][9] = 9
	dfa[9][10] = 9
	for i = 11, 21 do
		dfa[9][i] = 1
	end
	
	--Estado s10
	for i = 1, 12 do
		dfa[10][i] = 10
	end
	dfa[10][13] = 11
	for i = 14, 21 do
		dfa[10][i] = 10
	end
	
	--Estado s11
	for i = 1, 21 do
		dfa[11][i] = 1
	end
	
	--Estado s12
	for i = 1, 11 do
		dfa[12][i] = 12
	end
	dfa[12][12] = 13
	for i = 13, 21 do
		dfa[12][i] = 12
	end
	
	--Estado s13
	for i = 1, 20 do
		dfa[13][i] = 1
	end
	
	--Estado s14
	for i = 1, 14 do
		dfa[14][i] = 1
	end
	dfa[14][15] = 16
	for i = 16, 21 do
		dfa[14][i] = 1
	end
	
	--Estado s15
	dfa[15][1] = 1
	dfa[15][2] = 17
	for i = 3, 13 do
		dfa[15][i] = 1
	end
	dfa[15][14] = 16
	for i = 15, 21 do
		dfa[15][i] = 1
	end
	
	--Estado s16
	for i = 1, 21 do
		dfa[16][i] = 1
	end
	
	--Estado s17
	for i = 1, 21 do
		dfa[17][i] = 1
	end
	
	--Estado s18
	for i = 1, 21 do
		dfa[18][i] = 1
	end
		
	--Estado s19
	for i = 1, 21 do
		dfa[19][i] = 1
	end
	
	--Estado s20
	for i = 1, 21 do
		dfa[20][i] = 1
	end
	
	--Estado s21
	for i = 1, 21 do
		dfa[21][i] = 1
	end
	
	--Estado s22
	for i = 1, 21 do
		dfa[22][i] = 22
	end
	
	return dfa
end
