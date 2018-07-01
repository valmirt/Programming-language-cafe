--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018

	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.

	-Funções necessárias e o analisador léxico-
]]

function analisador_lexico ()
	local lexema = ''

	--Recupera a matriz que representa os estados de transição do DFA
	local dfa = dfa_regular()

	--Buffer usado para caminhar no dfa
	local buffer = {
		['estado_anterior'] = nil,
		['estado_atual'] = 1,
		['entrada'] = nil,
	}
	--Elemento que será enviado ao final da análise
	local t = {
		['token'] = nil,
		['lexema'] = nil,
		['tipo'] = nil,
		['is_terminal'] = true,
	}

	--Repete até voltar pro estado inicial ou estado de rejeição
	repeat
		--Transfere os dados do arquivo para memoria principal
		local char, end_f = return_char()

		--Fim do arquivo
		if end_f then
			end_file = true
			if buffer.estado_atual == 10 then
				print('Erro! Aspas não foram fechadas.')
				erro = true
				return nil
			elseif buffer.estado_atual == 12 then
				print('Erro! Chaves não foram fechadas.')
				erro = true
				return nil
			end
		end
		--Salva o estado anterior
		buffer.estado_anterior = buffer.estado_atual
		buffer.entrada = char
		--Caractere +
		if string.byte(buffer.entrada) == 43 then
			buffer.estado_atual = dfa[buffer.estado_atual][1]
		--Caractere -
		elseif string.byte(buffer.entrada) == 45 then
			buffer.estado_atual = dfa[buffer.estado_atual][2]
		--Caractere *
		elseif string.byte(buffer.entrada) == 42 then
			buffer.estado_atual = dfa[buffer.estado_atual][3]
		--Caractere /
		elseif string.byte(buffer.entrada) == 47 then
			buffer.estado_atual = dfa[buffer.estado_atual][4]
		--Caractere num
		elseif string.byte(buffer.entrada) >= 48 and
				string.byte(buffer.entrada) <= 57 then
			buffer.estado_atual = dfa[buffer.estado_atual][5]
		--Caractere .
		elseif string.byte(buffer.entrada) == 46 then
			buffer.estado_atual = dfa[buffer.estado_atual][6]
		--Caractere e
		elseif string.byte(buffer.entrada) == 101 then
			buffer.estado_atual = dfa[buffer.estado_atual][7]
		--Caractere E
		elseif string.byte(buffer.entrada) == 69 then
			buffer.estado_atual = dfa[buffer.estado_atual][8]
		--Caractere lit
		elseif (string.byte(buffer.entrada) >= 65 and string.byte(buffer.entrada) <= 90) or
				(string.byte(buffer.entrada) >= 97 and string.byte(buffer.entrada) <= 122) then
			buffer.estado_atual = dfa[buffer.estado_atual][9]
		--Caractere _
		elseif string.byte(buffer.entrada) == 95 then
			buffer.estado_atual = dfa[buffer.estado_atual][10]
		--Caractere {
		elseif string.byte(buffer.entrada) == 123 then
			buffer.estado_atual = dfa[buffer.estado_atual][11]
		--Caractere }
		elseif string.byte(buffer.entrada) == 125 then
			buffer.estado_atual = dfa[buffer.estado_atual][12]
		--Caractere "
		elseif string.byte(buffer.entrada) == 34 then
			buffer.estado_atual = dfa[buffer.estado_atual][13]
		--Caractere >
		elseif string.byte(buffer.entrada) == 62 then
			buffer.estado_atual = dfa[buffer.estado_atual][14]
		--Caractere =
		elseif string.byte(buffer.entrada) == 61 then
			buffer.estado_atual = dfa[buffer.estado_atual][15]
		--Caractere <
		elseif string.byte(buffer.entrada) == 60 then
			buffer.estado_atual = dfa[buffer.estado_atual][16]
		--Caractere (
		elseif string.byte(buffer.entrada) == 40 then
			buffer.estado_atual = dfa[buffer.estado_atual][17]
		--Caractere )
		elseif string.byte(buffer.entrada) == 41 then
			buffer.estado_atual = dfa[buffer.estado_atual][18]
		--Caractere ;
		elseif string.byte(buffer.entrada) == 59 then
			buffer.estado_atual = dfa[buffer.estado_atual][19]
		--Espaço/Tab/Quebra de Linha
		elseif string.byte(buffer.entrada) == 32 or string.byte(buffer.entrada) == 9 or
				string.byte(buffer.entrada) == 10 then
			buffer.estado_atual = dfa[buffer.estado_atual][20]
		--Caracteres : e \ que vão no comentario ou literal
		elseif string.byte(buffer.entrada) == 58 or string.byte(buffer.entrada) == 92 then
			buffer.estado_atual = dfa[buffer.estado_atual][21]
		else
			print ('Erro linha '..num_row..': caractere "'..buffer.entrada..'" inválido')
			erro = true
			return nil
		end

		if buffer.estado_atual ~= 1 and buffer.estado_atual ~= 22 then
			--Armazena o lexema por caractere
			lexema = lexema..buffer.entrada
		else
			if buffer.estado_anterior ~= 1 then
				if num_char > 1 then
					num_char = num_char - 1
				end
			end
		end
	--Condição de parada do repeat-until
	until buffer.estado_atual == 1 or buffer.estado_atual == 22

	--Verifica se é estado final
	if buffer.estado_atual == 1 then
		if buffer.estado_anterior == 1 then
			t = false
		elseif buffer.estado_anterior == 2 then
			t.token = 'opm'
			t.lexema = lexema
			t.tipo = lexema
			t.is_terminal = true
		elseif buffer.estado_anterior == 3 or buffer.estado_anterior == 5 or
				buffer.estado_anterior == 8 then
			t.token = 'num'
			t.lexema = lexema
			t.tipo = 'real'
			t.is_terminal = true
		elseif buffer.estado_anterior == 9 then
			t.token = 'id'
			t.lexema = lexema
			t.tipo = nil
			t.is_terminal = true
		elseif buffer.estado_anterior == 11 then
			t.token = 'literal'
			t.lexema = lexema
			t.tipo = 'literal'
			t.is_terminal = true
		elseif buffer.estado_anterior == 13 then
			t.token = 'comentario'
			t.lexema = lexema
			t.tipo = nil
			t.is_terminal = true
		elseif buffer.estado_anterior == 14 or buffer.estado_anterior == 15 or
				buffer.estado_anterior == 16 or buffer.estado_anterior == 21 then
			t.token = 'opr'
			t.lexema = lexema
			t.tipo = lexema
			t.is_terminal = true
		elseif buffer.estado_anterior == 17 then
			t.token = 'rcb'
			t.lexema = lexema
			t.tipo = '='
			t.is_terminal = true
		elseif buffer.estado_anterior == 18 then
			t.token = 'ab_p'
			t.lexema = lexema
			t.tipo = lexema
			t.is_terminal = true
		elseif buffer.estado_anterior == 19 then
			t.token = 'fc_p'
			t.lexema = lexema
			t.tipo = lexema
			t.is_terminal = true
		elseif buffer.estado_anterior == 20 then
			t.token = 'pt_v'
			t.lexema = lexema
			t.tipo = lexema
			t.is_terminal = true
		end
	else
		print ('Erro linha '..num_row..': caractere "'..buffer.entrada..'" inválido')
		erro = true
		return nil
	end

	local aux = compara_token(t)
	t = aux

	return t
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
	dfa[15][15] = 16
	for i = 16, 21 do
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
