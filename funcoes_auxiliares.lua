--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Funções auxiliares-
]]

--Função que verifica se o token é uma palavra reservada
function compara_token (t)
	local aux = t
	local flag = false
	
	if aux ~= false then
		if aux.token == 'id' then
			--Verifica se já existe na tabela de simbolos
			for i = 1, #tabela_simbolos do
				if tabela_simbolos[i].lexema == aux.lexema then
					aux = tabela_simbolos[i]
					flag = true
					break
				end
			end
			--Insere o id antes nao encontrado na tabela de simbolos
			if flag == false then
				table.insert(tabela_simbolos, aux)
			end
		end
	end
	
	return aux
end

function gramatica_glc ()
	--Gramatica livre de contexto da linguagem Mgol
	local glc = {
		[1] = {
			['regra'] = 'S',
			['producao'] = {'P',},
		},
		[2] = {
			['regra'] = 'P',
			['producao'] = {'inicio', 'V', 'A',},
		},
		[3] = {
			['regra'] = 'V',
			['producao'] = {'varinicio', 'LV',},
		},
		[4] = {
			['regra'] = 'LV',
			['producao'] = {'D', 'LV',},
		},
		[5] = {
			['regra'] = 'LV',
			['producao'] = {'varfim', 'pt_v',},
		},
		[6] = {
			['regra'] = 'D',
			['producao'] = {'id', 'TIPO', 'pt_v',},
		},
		[7] = {
			['regra'] = 'TIPO',
			['producao'] = {'int',},
		},
		[8] = {
			['regra'] = 'TIPO',
			['producao'] = {'real',},
		},
		[9] = {
			['regra'] = 'TIPO',
			['producao'] = {'lit',},
		},
		[10] = {
			['regra'] = 'A',
			['producao'] = {'ES', 'A',},
		},
		[11] = {
			['regra'] = 'ES',
			['producao'] = {'leia', 'id', 'pt_v',},
		},
		[12] = {
			['regra'] = 'ES',
			['producao'] = {'escreva', 'ARG', 'pt_v',},
		},
		[13] = {
			['regra'] = 'ARG',
			['producao'] = {'literal',},
		},
		[14] = {
			['regra'] = 'ARG',
			['producao'] = {'num',},
		},
		[15] = {
			['regra'] = 'ARG',
			['producao'] = {'id',},
		},
		[16] = {
			['regra'] = 'A',
			['producao'] = {'CMD', 'A',},
		},
		[17] = {
			['regra'] = 'CMD',
			['producao'] = {'id', 'rcb', 'LD', 'pt_v',},
		},
		[18] = {
			['regra'] = 'LD',
			['producao'] = {'OPRD', 'opm', 'OPRD',},
		},
		[19] = {
			['regra'] = 'LD',
			['producao'] = {'OPRD',},
		},
		[20] = {
			['regra'] = 'OPRD',
			['producao'] = {'id',},
		},
		[21] = {
			['regra'] = 'OPRD',
			['producao'] = {'num',},
		},
		[22] = {
			['regra'] = 'A',
			['producao'] = {'COND', 'A',},
		},
		[23] = {
			['regra'] = 'COND',
			['producao'] = {'CABECALHO', 'CORPO',},
		},
		[24] = {
			['regra'] = 'CABECALHO',
			['producao'] = {'se', 'ab_p', 'EXP_R', 'fc_p', 'entao',},
		},
		[25] = {
			['regra'] = 'EXP_R',
			['producao'] = {'OPRD', 'opr', 'OPRD',},
		},
		[26] = {
			['regra'] = 'CORPO',
			['producao'] = {'ES', 'CORPO',},
		},
		[27] = {
			['regra'] = 'CORPO',
			['producao'] = {'CMD', 'CORPO',},
		},
		[28] = {
			['regra'] = 'CORPO',
			['producao'] = {'COND', 'CORPO',},
		},
		[29] = {
			['regra'] = 'CORPO',
			['producao'] = {'fimse',},
		},
		[30] = {
			['regra'] = 'A',
			['producao'] = {'fim',},
		}, 
	}
	return glc
end

function lista_de_terminais ()
	--Lista com todos os terminais da gramatica
	local glc = {
		[1] = 'inicio',
		[2] = 'varinicio',
		[3] = 'varfim',
		[4] = 'pt_v',
		[5] = 'int',
		[6] = 'real',
		[7] = 'lit',
		[8] = 'leia',
		[9] = 'id',
		[10] = 'escreva',
		[11] = 'literal',
		[12] = 'num',
		[13] = 'rcb',
		[14] = 'opm',
		[15] = 'se',
		[16] = 'ab_p',
		[17] = 'fc_p',
		[18] = 'entao',
		[19] = 'opr',
		[20] = 'fimse',
		[21] = 'fim',
		[22] = '$',
	}
	return glc
end

function lista_de_nao_terminais ()
	--Lista com todos os terminais da gramatica
	local glc = {
		[1] = 'P',
		[2] = 'V',
		[3] = 'A',
		[4] = 'LV',
		[5] = 'D',
		[6] = 'TIPO',
		[7] = 'ES',
		[8] = 'ARG',
		[9] = 'CMD',
		[10] = 'LD',
		[11] = 'OPRD',
		[12] = 'COND',
		[13] = 'CABECALHO',
		[14] = 'EXP_R',
		[15] = 'CORPO',
	}
	return glc
end

function create_file (content)
	--cria o arquivo final .c
	local file = io.open('programa.c', 'w')
	--seta o arquivo como saida padrão 
	io.output(file)
	--escreve no arquivo
	io.write(content)
	--fecha o arquivo
	io.close(file)
end

function le_arquivo (i)
	--abre o arquivo fonte.mgl
	local file = io.open('fonte.mgl', 'r')
	--seta o arquivo como entrada padrão 
	io.input(file)
	--salva arquivo em uma variável
	local string = io.read(i)
	--fecha o arquivo
	io.close(file)
	
	return string
end

function compara_final ()
	--abre o arquivo fonte.mgl 
	local file = io.open('fonte.mgl', 'r')
	--seta o arquivo como entrada padrão 
	io.input(file)
	--salva arquivo em uma variável
	local string = io.read('*a')
	--fecha o arquivo
	io.close(file)
	
	return string
end

function print_tabela_tokens (tabela_tokens)
	--Imprime os tokens encontrados no arquivo Mgol.txt 
	for i = 1, #tabela_tokens do
		print ('------------------------------------')
		print (i)
		print ('Token = '..tabela_tokens[i].token) 
		print ('Lexema = '..tabela_tokens[i].lexema) 
		print ('Tipo =', tabela_tokens[i].tipo)
		print ()
	end
end

function print_tabela_simbolos (tabela_simbolos)
	--Imprime os tokens da tabela de simbolos 
	print ('\n\n------------TABELA DE SIMBOLOS-----------------')
	for i = 1, #tabela_simbolos do
		print ('------------------------------------')
		print (i)
		print ('Token = '..tabela_simbolos[i].token) 
		print ('Lexema = '..tabela_simbolos[i].lexema) 
		print ('Tipo =', tabela_simbolos[i].tipo)
		print ()
	end
end
