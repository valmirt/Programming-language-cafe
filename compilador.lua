--[[Valmir Torres de Jesus Junior		128745
	Compiladores 26-04-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Primeira parte Analisador Léxico-
]]

dofile('funcoes_auxiliares.lua')
local erro = false

function chama_analisador ()
	--Popula a tabela de simbolos com as palavras reservadas
	local tabela_simbolos = palavras_reservadas()
	local tabela_tokens = {}
	local j = 1
	
	while true do
		--Recebe tabela com token, lexema e tipo definidos
		--Recebe também o ponteiro que percorre o arquivo
		local aux, i = analisador_lexico (j)
		j = i
		--Arquivo retornou eof
		if aux == nil then
			break
		elseif aux ~= false then
			--Verifica se já existe na tabela de simbolos
			if aux.token == 'id' then
				--Variáveis de controle
				local contem = false
				local pos
		
				for i = 1, #tabela_simbolos do
					if tabela_simbolos[i].lexema == aux.lexema then
						contem = true
						pos = i
						break
					end
				end
	
				--Caso nao
				if contem == false then
					local jaTem = false
					
					for i = 1, #tabela_tokens do
						if tabela_tokens[i].lexema == aux.lexema then
							jaTem = true
						end
					end
					if jaTem == false then
						table.insert(tabela_tokens, aux)
					else
						jaTem = false
					end
					
				--Caso sim
				else
					local jaTem = false
					
					for i = 1, #tabela_tokens do
						if tabela_tokens[i].lexema == tabela_simbolos[pos].lexema then
							jaTem = true
						end
					end
					if jaTem == false then
						table.insert(tabela_tokens, tabela_simbolos[pos])
						pos = nil
						contem = false
					else
						jaTem = false
					end
				end
			else 
				local jaTem = false
					
				for i = 1, #tabela_tokens do
					if tabela_tokens[i].lexema == aux.lexema then
						jaTem = true
					end
				end
				if jaTem == false then
					table.insert(tabela_tokens, aux)
				else
					jaTem = false
				end
			end
		end
	end
	
	if erro == false then
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
end

function analisador_lexico (j)
	local i = j
	local lexema = ''
	
	--Recupera a matriz que representa os estados de transição do DFA
	local dfa = dfa_regular()
	--Variável que compara se é o fim do arquivo
	local fim_arquivo = compara_final()
	--Buffer usado para caminhar no dfa
	local buffer = {
		['estado_anterior'] = 1,
		['estado_atual'] = 1,
		['entrada'] = nil,
	}
	--Elemento que será enviado ao final da análise
	local t = {
		['token'] = nil,
		['lexema'] = nil,
		['tipo'] = nil,
	}
	
	--Enquanto não temos um espaço
	while buffer.estado_atual ~= false do
		--Transfere os dados do arquivo para memoria principal
		local arquivo = le_arquivo(i)
	
		--Fim do arquivo
		if fim_arquivo == arquivo then
			--Terminou sem ser estado final nos três casos
			if buffer.estado_atual == 10 then
				print('Erro! Aspas não foram fechadas.')
				erro = true
			elseif buffer.estado_atual == 12 then
				print('Erro! Chaves não foram fechadas.')
				erro = true
			elseif buffer.estado_atual ~= false and buffer.estado_atual ~= 1 then
				print(buffer.estado_atual)
				print('Erro! Alguma sentença descrita de forma irregular')
				erro = true
			end
			
			return nil
		else
			--Salva o estado anterior
			buffer.estado_anterior = buffer.estado_atual
			
			--Pega sempre o ultimo caractere do arquivo
			buffer.entrada = string.sub(arquivo, -1)
			lexema = lexema..buffer.entrada
			
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
					string.byte(buffer.entrada) == 13 or string.byte(buffer.entrada) == 10 then
				buffer.estado_atual = dfa[buffer.estado_atual][20]
			--Caracteres : e \
			elseif string.byte(buffer.entrada) == 58 or string.byte(buffer.entrada) == 92 then
			--Qualquer caractere não listado
			else
				print ('Erro! caractere inválido na posição '.. i)
				erro = true
				return nil
			end
		end
		
		--Verifica se é estado final
		if(buffer.estado_atual == false) then
			if buffer.estado_anterior == 2 then
				t.token = 'OPM'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 3 or buffer.estado_anterior == 5 or 
					buffer.estado_anterior == 8 then
				t.token = 'Num'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 9 then
				t.token = 'id'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 11 then
				t.token = 'Literal'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 13 then
				t.token = 'Comentário'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 14 or buffer.estado_anterior == 15 or
					buffer.estado_anterior == 16 or buffer.estado_anterior == 21 then
				t.token = 'OPR'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 17 then
				t.token = 'RCB'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 18 then
				t.token = 'AB_P'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 19 then
				t.token = 'FC_P'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			elseif buffer.estado_anterior == 20 then
				t.token = 'PT_V'
				lexema = string.gsub(lexema, "%s+", "")
				t.lexema = lexema
				t.tipo = nil
			else
				t = false
			end
		end
		i = i + 1		
	end
	return t, i
end


--Chama a função
chama_analisador()

