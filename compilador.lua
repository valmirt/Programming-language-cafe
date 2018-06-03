--[[Valmir Torres de Jesus Junior		128745
	Compiladores 31-05-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
]]

dofile('funcoes_auxiliares.lua')
dofile('funcoes_lexico.lua')
dofile('funcoes_sintatico.lua')
dofile('stack.lua')

local erro = false
local is_end = false
--Popula a tabela de simbolos com as palavras reservadas
local tabela_simbolos = palavras_reservadas()

function analisador_sintatico()
	local glc = gramatica_glc()
	local tb_terminais = lista_de_terminais()
	local tb_nao_terminais = lista_de_nao_terminais()
	local tabela_sr = tabela_sintatica_sr()
	local tabela_tokens = {}
	local j = 1
	local aux, i
	local controle_recuce = false
	local controle_acc = false
	local pilha = Stack:Create()
	pilha:push(1)
	
	while true do
		if not controle_reduce then
			--Recebe tabela com token, lexema e tipo definidos
			--Recebe também o ponteiro que percorre o arquivo
			if not is_end and not erro then
				aux, i = analisador_lexico (j)
				j = i
				if aux ~= false then table.insert(tabela_tokens, aux) end
				if erro then break end --Se deu erro sai direto
			elseif is_end then aux = {['token'] = '$'} end--Indicando o fim do arquivo
		end
		
		local topo = pilha:topo()
		
		--Ignora tab, espaco, \n e comentario
		if aux ~= false and aux.token ~= 'comentario' then
			--Definindo o numero q representa o terminal de acordo
			--com a construção da tabela shift/reduce
			local terminal
			for k, v in pairs (tb_terminais) do
				if aux.token == v then
					terminal = k
					break
				end
			end
			
			if tabela_sr[topo][terminal].operacao == 'Shift' then
				controle_reduce = false
				--Empilha o terminal e o estado
				pilha:push (aux.token, tabela_sr[topo][terminal].estado)
			elseif tabela_sr[topo][terminal].operacao == 'Reduce' then
				controle_reduce = true
				--Printa a regra a ser reduzida
				local regra = glc[tabela_sr[topo][terminal].estado].regra..' ->'
				for k, v in pairs (glc[tabela_sr[topo][terminal].estado].producao) do
					regra = regra..' '..v
				end
				print(regra)
				--Regra GLC: alfa -> beta
				--Elimina os 2*|beta| elementos da pilha
				local alfa = glc[tabela_sr[topo][terminal].estado].regra
				local beta = #glc[tabela_sr[topo][terminal].estado].producao
				pilha:pop(2*beta)
				--Atualiza o topo
				topo = pilha:topo()
				
				local nao_terminal
				for k, v in pairs (tb_nao_terminais) do
					if alfa == v then
						nao_terminal = k + 21
						break
					end
				end
				--Insere o alfa e o estado da tabela shift/reduce
				local estado = tabela_sr[topo][nao_terminal].estado
				pilha:push(alfa, estado)
			elseif tabela_sr[topo][terminal].operacao == 'Aceita!' then
				controle_acc = true
				--Aceitou toda sintaxe do código
				print(tabela_sr[topo][terminal].operacao)
			else print(tabela_sr[topo	][terminal].operacao) break --Algum erro de sintaxe
			end
			
			if controle_acc then
				if is_end then break end --depois de fazer a ultima execucao sai do while
			end
		end
	end
	--[[if erro == false then
		--Imprime os tokens encontrados no arquivo Mgol.txt 
		print_tabela_tokens (tabela_tokens)
	end]]
	
	--[[--Imprime os tokens da tabela de simbolos 
	print_tabela_simbolos (tabela_simbolos)]]
end

local quebra_linha = 1

function analisador_lexico (j)
	local i = j
	local lexema = ''
	
	
	--Recupera a matriz que representa os estados de transição do DFA
	local dfa = dfa_regular()
	--Variável que compara se é o fim do arquivo
	local fim_arquivo = compara_final()
	
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
	}
	
	--Repete até voltar pro estado inicial ou estado de rejeição
	repeat
		--Transfere os dados do arquivo para memoria principal
		local arquivo = le_arquivo(i)
		local teste = string.sub(arquivo, -1)

		--Fim do arquivo
		if fim_arquivo == arquivo then
			is_end = true
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
		
		--Pega sempre o ultimo caractere do arquivo
		buffer.entrada = string.sub(arquivo, -1)
		
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
			print ('Erro! caractere inválido na posição '.. i..' do arquivo')
			erro = true
			return nil
		end
		
		if buffer.estado_atual ~= 1 and buffer.estado_atual ~= 22 then
			--Armazena o lexema por caractere
			lexema = lexema..buffer.entrada
			--Incrementa i para ler o próximo caractere	
			i = i + 1
		end
	--Condição de parada do repeat-until		
	until buffer.estado_atual == 1 or buffer.estado_atual == 22
	
	--Verifica se é estado final
	if buffer.estado_atual == 1 then
		if buffer.estado_anterior == 1 then
			t = false
			i = i + 1
		elseif buffer.estado_anterior == 2 then
			t.token = 'opm'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 3 or buffer.estado_anterior == 5 or 
				buffer.estado_anterior == 8 then
			t.token = 'num'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 9 then
			t.token = 'id'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 11 then
			t.token = 'literal'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 13 then
			t.token = 'comentario'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 14 or buffer.estado_anterior == 15 or
				buffer.estado_anterior == 16 or buffer.estado_anterior == 21 then
			t.token = 'opr'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 17 then
			t.token = 'rcb'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 18 then
			t.token = 'ab_p'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 19 then
			t.token = 'fc_p'
			t.lexema = lexema
			t.tipo = nil
		elseif buffer.estado_anterior == 20 then
			t.token = 'pt_v'
			t.lexema = lexema
			t.tipo = nil
		end
	else
		print ('Erro! caractere inválido na posição '.. i..' do arquivo')
		erro = true
		return nil
	end
		
	local aux = compara_token(t)
	t = aux
	
	return t, i
end

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


--Chama a função
analisador_sintatico()
