--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Funções necessárias e o analisador semântico-
]]

function analisador_semantico (file, regra, terminal)
	print('------------------------------')
	print(terminal.token)
	print(terminal.lexema)
	print(terminal.tipo)
	print(regra)
	print('------------------------------')
	--Para cada regra temos um bloco de regras semânticas a ser executada
	if regra == 5 then
		--Imprime tres linhas em branco no arquivo
		file = file..'\n\n\n'
	elseif regra == 6 then
		--Procura o terminal na tabela de simbolos e atribui o tipo dele
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].lexema == terminal.lexema then
				tabela_simbolos[i].tipo = nao_terminais.TIPO.tipo
				terminal.tipo = tabela_simbolos[i].tipo
				break
			end
		end
		file = file..nao_terminais.TIPO.tipo..' '..terminal.lexema..';\n'
		print('Define o tipo do id recido pelo não terminal TIPO')
		print('Escreve a sentença no arquivo')
	elseif regra == 7 then
		nao_terminais.TIPO.tipo = tabela_simbolos[11].tipo
		print('Define o tipo do não terminal TIPO como int')
	elseif regra == 8 then
		nao_terminais.TIPO.tipo = tabela_simbolos[13].tipo
		print('Define o tipo do não terminal TIPO como real')
	elseif regra == 9 then
		nao_terminais.TIPO.tipo = tabela_simbolos[12].tipo
		print('Define o tipo do não terminal TIPO como lit')
	elseif regra == 11 then
		print('Verfica se o campo tipo do id está preenchido')
		print('Escreve a sentença no arquivo')
		--Procura o terminal na tabela de simbolos e escreve a sentença no arquivo
		for i = 1, #tabela_simbolos do
			if tabela_simbolos[i].token == terminal.token then
				if tabela_simbolos[i].tipo == 'int' then
					file = file..'scanf("%s", '..tabela_simbolos[i].lexema..');\n'
				elseif tabela_simbolos[i].tipo == 'real' then
					file = file..'scanf("%d", &'..tabela_simbolos[i].lexema..');\n'
				elseif tabela_simbolos[i].tipo == 'lit' then
					file = file..'scanf("%1f", &'..tabela_simbolos[i].lexema..');\n'
				else 
					print('Erro!! Variável '..tabela_simbolos[i].lexema..' não declarada...')
					erro = true
					erro_semantico = true
				end
				break
			end
		end
	elseif regra == 12 then
	elseif regra == 13 then
	elseif regra == 14 then
	elseif regra == 15 then
	elseif regra == 16 then
	elseif regra == 17 then
	elseif regra == 18 then
	elseif regra == 19 then
	elseif regra == 20 then
	elseif regra == 21 then
	elseif regra == 23 then
	elseif regra == 24 then
	elseif regra == 25 then
	end
	
	return file
end

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
			['token'] = 'int',
			['lexema'] = 'int',
			['tipo'] = 'int',
		},
		[12] = {
			['token'] = 'lit',
			['lexema'] = 'lit',
			['tipo'] = 'lit',
		},
		[13] = {
			['token'] = 'real',
			['lexema'] = 'real',
			['tipo'] = 'real',
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
		},
		['P'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['V'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['LV'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['D'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['TIPO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['A'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['ES'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['ARG'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['CMD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['LD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['OPRD'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['COND'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['CABECALHO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['EXP_R'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
		['CORPO'] = {
			['token'] = nil,
			['lexema'] = nil,
			['tipo'] = nil,
		},
	}
	
	return tabela_nterminais
end

