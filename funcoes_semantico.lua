--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018

	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.

	-Funções necessárias e o analisador semântico-
]]

function analisador_semantico (file, regra, producao)
	local terminal = {}
	local n_terminal = {}

	for i = 1, #producao do
		if producao[i].is_terminal then
			table.insert(terminal, producao[i])
		else table.insert(n_terminal, producao[i])
		end
	end

	--Para cada regra da gramática temos um bloco de regras semânticas a ser executada
	if regra == 5 then
		print('Imprime tres linhas em branco no arquivo')
		file = file..'\n\n\n'
	elseif regra == 6 then
		print('Define o tipo do id recebido pelo não terminal TIPO')
		print('Escreve a sentença no arquivo')
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal[2].lexema then
				tabela_simbolos[i].tipo = n_terminal[1].tipo
				break --interromper a busca na tabela
			end
		end
		if n_terminal[1].tipo == 'real' then
			file = file..'double '..terminal[2].lexema..';\n'
		else file = file..n_terminal[1].tipo..' '..terminal[2].lexema..';\n' end
	elseif regra == 7 then
		print('Define o tipo do não terminal TIPO como int')
		nao_terminais.TIPO.tipo = tabela_simbolos[11].tipo
	elseif regra == 8 then
		print('Define o tipo do não terminal TIPO como real')
		nao_terminais.TIPO.tipo = tabela_simbolos[13].tipo
	elseif regra == 9 then
		print('Define o tipo do não terminal TIPO como lit')
		nao_terminais.TIPO.tipo = tabela_simbolos[12].tipo
	elseif regra == 11 then
		print('Verfica se o campo tipo do id está preenchido')
		print('Escreve a sentença no arquivo')
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal[2].lexema then
				if terminal[2].tipo == 'lit' then
					file = file..'scanf("%s", '..terminal[2].lexema..');\n'
				elseif terminal[2].tipo == 'int' then
					file = file..'scanf("%d", &'..terminal[2].lexema..');\n'
				elseif terminal[2].tipo == 'real' then
					file = file..'scanf("%1f", &'..terminal[2].lexema..');\n'
				else
					print('Erro!! Variável '..terminal[2].lexema..' não declarada...')
					erro = true
					erro_semantico = true
				end
				break
			end
		end
	elseif regra == 12 then
		print('Gerar código para o comando escreva')
		if n_terminal[1].tipo == 'lit' then
			file = file..'printf("%s", '..n_terminal[1].lexema..');\n'
		elseif n_terminal[1].tipo == 'int' then
			file = file..'printf("%d", '..n_terminal[1].lexema..');\n'
		elseif n_terminal[1].tipo == 'real' then
			file = file..'printf("%1.f", '..n_terminal[1].lexema..');\n'
		elseif n_terminal[1].tipo == 'literal' then
			file = file..'printf('..n_terminal[1].lexema..');\n'
		end
	elseif regra == 13 or regra == 14 then
		print('Atribui os atributos do terminal a ARG')
		nao_terminais.ARG.token = terminal[1].token
		nao_terminais.ARG.lexema = terminal[1].lexema
		nao_terminais.ARG.tipo = terminal[1].tipo
	elseif regra == 15 then
		print('Verfica se o id está contido na tabela de simbolos')
		print('caso esteja é passado seus atributos para ARG')
		local flag = false
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal[1].lexema then
				nao_terminais.ARG.token = terminal[1].token
				nao_terminais.ARG.lexema = terminal[1].lexema
				nao_terminais.ARG.tipo = terminal[1].tipo
				flag = true
				break
			end
		end
		if not flag then
			print('Erro!! Variável '..terminal[1].lexema..' não declarada...')
			erro = true
			erro_semantico = true
		end
	elseif regra == 17 then
		print('Verifica se o id já foi declarado')
		print('Caso seja seu tipo é comparado com LD')
		local flag = false
		
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal[3].lexema then
				if tabela_simbolos[i].tipo == nil then
					print('Erro!! Variável '..terminal[3].lexema..' não declarada...')
					erro = true
					erro_semantico = true
				else
					if tabela_simbolos[i].tipo == n_terminal[1].tipo or
						tabela_simbolos[i].tipo == 'int' or tabela_simbolos[i].tipo == 'real' and
						n_terminal[1].tipo == 'int' or n_terminal[1].tipo == 'real' then
						file = file..tabela_simbolos[i].lexema..' '..terminal[2].tipo..' '..n_terminal[1].lexema..';\n'
					else
						print('Erro!! Tipos diferentes para atribuição ou Variável...')
						erro = true
						erro_semantico = true
					end
				end
				flag = true
				break
			end
		end
		if not flag then
			print('Erro!! Variável '..terminal[3].lexema..' não declarada...')
			erro = true
			erro_semantico = true
		end
	elseif regra == 18 then
		print('Verifica se algum dos operandos é do tipo literal')
		print('Caso nao seja, é gerado uma variável temporária como resultado da operação')
		if n_terminal[1].tipo == 'int' or n_terminal[1].tipo == 'real' and
			n_terminal[2].tipo == 'int' or n_terminal[2].tipo == 'real' then
			num_temp = num_temp + 1
			local t = n_terminal[2].lexema..' '..terminal[1].tipo..' '..n_terminal[1].lexema
			nao_terminais.LD.tipo = n_terminal[1].tipo
			nao_terminais.LD.lexema = 'T'..num_temp
			file = file..'T'..num_temp..' = '..t..';\n'

			nao_terminais.OPRD.is_used = false
			nao_terminais.OPRD2.is_used = false
			nao_terminais.OPRD1.is_used = false
			nao_terminais.OPRD3.is_used = false
		else
			print('Erro!! Operandos de tipo inválido...')
			erro = true
			erro_semantico = true
		end
	elseif regra == 19 then
		print('Copia todos os atributos de OPRD para LD')
		nao_terminais.LD.token = n_terminal[1].token
		nao_terminais.LD.lexema = n_terminal[1].lexema
		nao_terminais.LD.tipo = n_terminal[1].tipo

		nao_terminais.OPRD.is_used = false
		nao_terminais.OPRD2.is_used = false
		nao_terminais.OPRD1.is_used = false
		nao_terminais.OPRD3.is_used = false
	elseif regra == 20 then
		print('Verfica se o id está contido na tabela de simbolos')
		print('caso esteja é passado seus atributos para OPRD')
		local flag = false

		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal[1].lexema then
				if tabela_simbolos[i].tipo == nil then
					print('Erro!! Variável '..terminal[1].lexema..' não declarada...')
					erro = true
					erro_semantico = true
				else
					if not nao_terminais.OPRD.is_used then
						nao_terminais.OPRD.lexema = terminal[1].lexema
						nao_terminais.OPRD.tipo = terminal[1].tipo
						nao_terminais.OPRD.token = terminal[1].token
						nao_terminais.OPRD.is_used = true
					else
						nao_terminais.OPRD2.lexema = terminal[1].lexema
						nao_terminais.OPRD2.tipo = terminal[1].tipo
						nao_terminais.OPRD2.token = terminal[1].token
						nao_terminais.OPRD2.is_used = true
					end
				end
				flag = true
				break
			end
		end
		if not flag then
			print('Erro!! Variável '..terminal[1].lexema..' não declarada...')
			erro = true
			erro_semantico = true
		end
	elseif regra == 21 then
		print('Copia todos os atributos de num para OPRD')
		if not nao_terminais.OPRD1.is_used then
			nao_terminais.OPRD1.lexema = terminal[1].lexema
			nao_terminais.OPRD1.tipo = terminal[1].tipo
			nao_terminais.OPRD1.token = terminal[1].token
			nao_terminais.OPRD1.is_used = true
		else
			nao_terminais.OPRD3.lexema = terminal[1].lexema
			nao_terminais.OPRD3.tipo = terminal[1].tipo
			nao_terminais.OPRD3.token = terminal[1].token
			nao_terminais.OPRD3.is_used = true
		end
	elseif regra == 23 then
		print('Imprime fecha chaves no arquivo')
		file = file..'}\n'
	elseif regra == 24 then
		print('Imprime o cabeçalho do if no arquivo')
		file = file..'if ('..n_terminal[1].lexema..') {\n'
	elseif regra == 25 then
		print('Verifica se os operandos são de tipos equivalentes')
		print('Caso sejam, é gerado uma variável temporária como resultado da operação')
		if n_terminal[1].tipo == 'int' or n_terminal[1].tipo == 'real' and
			n_terminal[2].tipo == 'int' or n_terminal[2].tipo == 'real' then
			num_temp = num_temp + 1
			local t = n_terminal[2].lexema..' '..terminal[1].tipo..' '..n_terminal[1].lexema

			nao_terminais.EXP_R.lexema = 'T'..num_temp
			file = file..'T'..num_temp..' = '..t..';\n'

			nao_terminais.OPRD.is_used = false
			nao_terminais.OPRD2.is_used = false
			nao_terminais.OPRD1.is_used = false
			nao_terminais.OPRD3.is_used = false
		else
			print('Erro!! Operandos de tipo inválido...')
			erro = true
			erro_semantico = true
		end
	end

	return file
end

function palavras_reservadas ()
	local tabela_simbolos = {
		[1] = {
			['token'] = 'inicio',
			['lexema'] = 'inicio',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[2] = {
			['token'] = 'varinicio',
			['lexema'] = 'varinicio',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[3] = {
			['token'] = 'varfim',
			['lexema'] = 'varfim',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[4] = {
			['token'] = 'escreva',
			['lexema'] = 'escreva',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[5] = {
			['token'] = 'leia',
			['lexema'] = 'leia',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[6] = {
			['token'] = 'se',
			['lexema'] = 'se',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[7] = {
			['token'] = 'entao',
			['lexema'] = 'entao',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[8] = {
			['token'] = 'senao',
			['lexema'] = 'senao',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[9] = {
			['token'] = 'fimse',
			['lexema'] = 'fimse',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[10] = {
			['token'] = 'fim',
			['lexema'] = 'fim',
			['tipo'] = nil,
			['is_terminal'] = true,
		},
		[11] = {
			['token'] = 'int',
			['lexema'] = 'int',
			['tipo'] = 'int',
			['is_terminal'] = true,
		},
		[12] = {
			['token'] = 'lit',
			['lexema'] = 'lit',
			['tipo'] = 'lit',
			['is_terminal'] = true,
		},
		[13] = {
			['token'] = 'real',
			['lexema'] = 'real',
			['tipo'] = 'real',
			['is_terminal'] = true,
		},
	}

	return tabela_simbolos
end

--Define os atributos dos não-terminais da gramática
function atributos_nterminais()
	local tabela_nterminais = {
		['S'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['P'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['V'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['LV'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['D'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['TIPO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['A'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['ES'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['ARG'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['CMD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['LD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['OPRD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD2'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD1'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD3'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['COND'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['CABECALHO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['EXP_R'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
		['CORPO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
			['is_terminal'] = false,
		},
	}

	return tabela_nterminais
end
