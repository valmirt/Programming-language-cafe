--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018

	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.

	-Funções necessárias e o analisador sintático-
]]

function analisador_sintatico(content)
	local glc = gramatica_glc()
	local tb_terminais = lista_de_terminais()
	local tb_nao_terminais = lista_de_nao_terminais()
	local tabela_sr = tabela_sintatica_sr()
	local tabela_tokens = {}
	local aux
	local controle_reduce = false
	local controle_acc = false
	local pilha = Stack:Create()
	pilha:push(1)

	while not is_end do
		if not controle_reduce then
			--Recebe tabela com token, lexema e tipo definidos
			--Recebe também o ponteiro que percorre o arquivo
			if not is_end and not erro then
				aux = analisador_lexico()
				if aux ~= false then table.insert(tabela_tokens, aux) end
				if erro then break end --Se deu erro sai direto
			elseif is_end then aux = {['token'] = '$'} end--Indicando o fim do arquivo
		end

		local topo = pilha:topo()

		--Ignora tab, espaco, \n e comentario
		--[[if aux ~= false and aux.token ~= 'comentario' then
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
				pilha:push (aux, tabela_sr[topo][terminal].estado)
			elseif tabela_sr[topo][terminal].operacao == 'Reduce' then
				controle_reduce = true
				local temp_estado = tabela_sr[topo][terminal].estado
				--Printa a regra a ser reduzida
				local regra = glc[tabela_sr[topo][terminal].estado].regra..' ->'
				for k, v in pairs (glc[tabela_sr[topo][terminal].estado].producao) do
					regra = regra..' '..v
				end
				print(regra)
				--Regra GLC: alfa -> beta
				--Elimina os 2*|beta| elementos da pilha
				local nome_alfa = glc[tabela_sr[topo][terminal].estado].regra
				local beta = #glc[tabela_sr[topo][terminal].estado].producao
				--Recuperando informações que serão uteis para a parte semântica
				local producao = {}
				local temp = false
				for i = 1, (2*beta) do
					if not temp then
						pilha:pop()
						temp = true
					else
						table.insert(producao, pilha:pop())
						temp = false
					end
				end
				--Atualiza o topo
				topo = pilha:topo()
				--Chama o analisador semantico que atribui a regra semantica dirida pela sintaxe
				content = analisador_semantico(content, temp_estado, producao)

				--Gerando a variável alfa com os atributos token, tipo e lexema
				local alfa
				if temp_estado ~= 20 and temp_estado ~= 21 then
 					alfa = nao_terminais[nome_alfa]
				--Corrigindo bug
				else
					if temp_estado == 20 then
						if nao_terminais.OPRD.is_used and not nao_terminais.OPRD2.is_used then
							alfa = nao_terminais.OPRD
						elseif nao_terminais.OPRD2.is_used and nao_terminais.OPRD.is_used then
							alfa = nao_terminais.OPRD2
						end
					end
					if temp_estado == 21 then
						if nao_terminais.OPRD1.is_used and not nao_terminais.OPRD3.is_used then
							alfa = nao_terminais.OPRD1
						elseif nao_terminais.OPRD3.is_used and nao_terminais.OPRD1.is_used then
							alfa = nao_terminais.OPRD3
						end
					end
				end

				local nao_terminal
				for k, v in pairs (tb_nao_terminais) do
					if nome_alfa == v then
						nao_terminal = k + 22
						break
					end
				end
				--Insere o alfa e o estado da tabela shift/reduce
				local estado = tabela_sr[topo][nao_terminal].estado
				pilha:push(alfa, estado)
				if erro_semantico then break end --Sai direto no erro vindo pelo analisador_semantico
			elseif tabela_sr[topo][terminal].operacao == 'Aceita!' then
				controle_acc = true
				--Aceitou toda sintaxe do código
				--Esse print é só pra completar os prints das regras
				print('S -> P')
				print(tabela_sr[topo][terminal].operacao)
			else print(tabela_sr[topo][terminal].operacao) break end --Algum erro de sintaxe

			if controle_acc then
				if is_end then break end --depois de fazer a ultima execucao sai do while
			end
		end]]
	end
	--if erro == false then
		--Imprime os tokens encontrados no arquivo Mgol.txt
		print_tabela (tabela_tokens)
	--end

	--Imprime os tokens da tabela de simbolos
	--print_tabela (tabela_simbolos)

	--Retorna o arquivo que contem o codigo .c
	return content
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
		--Tabela com descrição dos erros sintáticos para auxílio da depuração do programador de mgol
		tabela_shift_reduce[i][1] = { ['operacao'] = 'Erro! Bad syntax... inicio disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][2] = { ['operacao'] = 'Erro! Bad syntax... varinicio disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][3] = { ['operacao'] = 'Erro! Bad syntax... varfim disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][4] = { ['operacao'] = 'Erro! Bad syntax... caractere ; disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][5] = { ['operacao'] = 'Erro! Bad syntax... declaração inteiro incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][6] = { ['operacao'] = 'Erro! Bad syntax... declaração real incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][7] = { ['operacao'] = 'Erro! Bad syntax... declaração literal incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][8] = { ['operacao'] = 'Erro! Bad syntax... operação leia disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][9] = { ['operacao'] = 'Erro! Bad syntax... id disposto de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][10] = { ['operacao'] = 'Erro! Bad syntax... operação escreva incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][11] = { ['operacao'] = 'Erro! Bad syntax... literal descrito de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][12] = { ['operacao'] = 'Erro! Bad syntax... número descrito de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][13] = { ['operacao'] = 'Erro! Bad syntax... descrito na atribuição.', ['estado'] = nil,}
		tabela_shift_reduce[i][14] = { ['operacao'] = 'Erro! Bad syntax... operador aritmético incorreto.', ['estado'] = nil,}
		tabela_shift_reduce[i][15] = { ['operacao'] = 'Erro! Bad syntax... estrutura de seleção incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][16] = { ['operacao'] = 'Erro! Bad syntax... caractere ( descrito de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][17] = { ['operacao'] = 'Erro! Bad syntax... caractere ) descrito de forma incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][18] = { ['operacao'] = 'Erro! Bad syntax... estrutura de seleção incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][19] = { ['operacao'] = 'Erro! Bad syntax... operador relacional incorreto.', ['estado'] = nil,}
		tabela_shift_reduce[i][20] = { ['operacao'] = 'Erro! Bad syntax... estrutura de seleção incorreta.', ['estado'] = nil,}
		tabela_shift_reduce[i][21] = { ['operacao'] = 'Erro! Bad syntax... fim disposto de forma incorreta', ['estado'] = nil,}
		tabela_shift_reduce[i][22] = { ['operacao'] = 'Erro! Bad syntax...', ['estado'] = nil,}
		for j = 23, 36 do
			tabela_shift_reduce[i][j] = { ['operacao'] = 'Erro! Bad syntax...', ['estado'] = nil,}
		end
	end

	--Estado 1
	tabela_shift_reduce[1][1] = { ['operacao'] = 'Shift', ['estado'] = 3,} --terminal inicio
	tabela_shift_reduce[1][23] = { ['operacao'] = nil, ['estado'] = 2,} --nao-terminal P

	--Estado 2 --Estado de redução--
	tabela_shift_reduce[2][22] = { ['operacao'] = 'Aceita!', ['estado'] = true,} -- terminal $

	--Estado 3
	tabela_shift_reduce[3][2] = { ['operacao'] = 'Shift', ['estado'] = 5,} --terminal varinicio
	tabela_shift_reduce[3][24] = { ['operacao'] = nil, ['estado'] = 4,} --nao-terminal V

	--Estado 4
	tabela_shift_reduce[4][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[4][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[4][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[4][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[4][21] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[4][25] = { ['operacao'] = nil, ['estado'] = 6,} --nao-terminal A
	tabela_shift_reduce[4][29] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[4][31] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[4][34] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[4][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO


	--Estado 5
	tabela_shift_reduce[5][3] = { ['operacao'] = 'Shift', ['estado'] = 18,} --termial varfim
	tabela_shift_reduce[5][9] = { ['operacao'] = 'Shift', ['estado'] = 19,} --termial id
	tabela_shift_reduce[5][26] = { ['operacao'] = nil, ['estado'] = 16,} --nao-terminal LV
	tabela_shift_reduce[5][27] = { ['operacao'] = nil, ['estado'] = 17,} --nao-terminal D

	--Estado 6 --Estado de redução--
	tabela_shift_reduce[6][22] = { ['operacao'] = 'Reduce', ['estado'] = 2,} --termial $

	--Estado 7
	tabela_shift_reduce[7][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[7][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[7][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[7][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[7][21] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[7][25] = { ['operacao'] = nil, ['estado'] = 20,} --nao-terminal A
	tabela_shift_reduce[7][29] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[7][31] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[7][34] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[7][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO

	--Estado 8
	tabela_shift_reduce[8][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[8][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[8][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[8][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[8][21] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[8][25] = { ['operacao'] = nil, ['estado'] = 21,} --nao-terminal A
	tabela_shift_reduce[8][29] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[8][31] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[8][34] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[8][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO

	--Estado 9
	tabela_shift_reduce[9][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[9][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[9][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[9][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[9][21] = { ['operacao'] = 'Shift', ['estado'] = 10,} -- terminal fim
	tabela_shift_reduce[9][25] = { ['operacao'] = nil, ['estado'] = 22,} --nao-terminal A
	tabela_shift_reduce[9][29] = { ['operacao'] = nil, ['estado'] = 7,} --nao-terminal ES
	tabela_shift_reduce[9][31] = { ['operacao'] = nil, ['estado'] = 8,} --nao-terminal CMD
	tabela_shift_reduce[9][34] = { ['operacao'] = nil, ['estado'] = 9,} --nao-terminal COND
	tabela_shift_reduce[9][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO

	--Estado 10 --Estado de redução--
	tabela_shift_reduce[10][22] = { ['operacao'] = 'Reduce', ['estado'] = 30,} --termial $

	--Estado 11
	tabela_shift_reduce[11][9] = { ['operacao'] = 'Shift', ['estado'] = 23,} -- terminal id

	--Estado 12
	tabela_shift_reduce[12][9] = { ['operacao'] = 'Shift', ['estado'] = 27,} -- terminal id
	tabela_shift_reduce[12][11] = { ['operacao'] = 'Shift', ['estado'] = 25,} -- terminal literal
	tabela_shift_reduce[12][12] = { ['operacao'] = 'Shift', ['estado'] = 26,} -- terminal num
	tabela_shift_reduce[12][30] = { ['operacao'] = nil, ['estado'] = 24,} --nao-terminal ARG

	--Estado 13
	tabela_shift_reduce[13][13] = { ['operacao'] = 'Shift', ['estado'] = 28,} -- terminal rcb

	--Estado 14
	tabela_shift_reduce[14][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[14][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[14][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[14][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[14][20] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[14][29] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[14][31] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[14][34] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[14][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[14][37] = { ['operacao'] = nil, ['estado'] = 29,} --nao-terminal CORPO

	--Estado 15
	tabela_shift_reduce[15][16] = { ['operacao'] = 'Shift', ['estado'] = 33,} -- terminal (

	--Estado 16 --Estado de redução
	tabela_shift_reduce[16][8] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial leia
	tabela_shift_reduce[16][9] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial id
	tabela_shift_reduce[16][10] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial escreva
	tabela_shift_reduce[16][15] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial se
	tabela_shift_reduce[16][21] = { ['operacao'] = 'Reduce', ['estado'] = 3,} --termial fim

	--Estado 17
	tabela_shift_reduce[17][3] = { ['operacao'] = 'Shift', ['estado'] = 18,} -- terminal varfim
	tabela_shift_reduce[17][9] = { ['operacao'] = 'Shift', ['estado'] = 19,} -- terminal id
	tabela_shift_reduce[17][26] = { ['operacao'] = nil, ['estado'] = 34,} --nao-terminal LV
	tabela_shift_reduce[17][27] = { ['operacao'] = nil, ['estado'] = 17,} --nao-terminal D

	--Estado 18
	tabela_shift_reduce[18][4] = { ['operacao'] = 'Shift', ['estado'] = 35,} -- terminal ;

	--Estado 19
	tabela_shift_reduce[19][5] = { ['operacao'] = 'Shift', ['estado'] = 37,} -- terminal varfim
	tabela_shift_reduce[19][6] = { ['operacao'] = 'Shift', ['estado'] = 38,} -- terminal varfim
	tabela_shift_reduce[19][7] = { ['operacao'] = 'Shift', ['estado'] = 39,} -- terminal varfim
	tabela_shift_reduce[19][28] = { ['operacao'] = nil, ['estado'] = 36,} --nao-terminal TIPO

	--Estado 20 --Estado de redução--
	tabela_shift_reduce[20][22] = { ['operacao'] = 'Reduce', ['estado'] = 10,} --termial $

	--Estado 21 --Estado de redução--
	tabela_shift_reduce[21][22] = { ['operacao'] = 'Reduce', ['estado'] = 16,} --termial $

	--Estado 22 --Estado de redução--
	tabela_shift_reduce[22][22] = { ['operacao'] = 'Reduce', ['estado'] = 22,} --termial $

	--Estado 23
	tabela_shift_reduce[23][4] = { ['operacao'] = 'Shift', ['estado'] = 40,} -- terminal ;

	--Estado 24
	tabela_shift_reduce[24][4] = { ['operacao'] = 'Shift', ['estado'] = 59,} -- terminal ;

	--Estado 25 --Estado de redução
	tabela_shift_reduce[25][4] = { ['operacao'] = 'Reduce', ['estado'] = 13,} --termial ;

	--Estado 26 --Estado de redução
	tabela_shift_reduce[26][4] = { ['operacao'] = 'Reduce', ['estado'] = 14,} --termial ;

	--Estado 27 --Estado de redução
	tabela_shift_reduce[27][4] = { ['operacao'] = 'Reduce', ['estado'] = 15,} --termial ;

	--Estado 28
	tabela_shift_reduce[28][9] = { ['operacao'] = 'Shift', ['estado'] = 43,} -- terminal id
	tabela_shift_reduce[28][12] = { ['operacao'] = 'Shift', ['estado'] = 44,} -- terminal num
	tabela_shift_reduce[28][32] = { ['operacao'] = nil, ['estado'] = 41,} --nao-terminal LD
	tabela_shift_reduce[28][33] = { ['operacao'] = nil, ['estado'] = 42,} --nao-terminal OPRD

	--Estado 29 --Estado de redução
	tabela_shift_reduce[29][8] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial leia
	tabela_shift_reduce[29][9] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial id
	tabela_shift_reduce[29][10] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial escreva
	tabela_shift_reduce[29][15] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial se
	tabela_shift_reduce[29][20] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial fimse
	tabela_shift_reduce[29][21] = { ['operacao'] = 'Reduce', ['estado'] = 23,} --termial fim

	--Estado 30
	tabela_shift_reduce[30][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[30][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[30][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[30][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[30][20] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[30][29] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[30][31] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[30][34] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[30][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[30][37] = { ['operacao'] = nil, ['estado'] = 45,} --nao-terminal CORPO

	--Estado 31
	tabela_shift_reduce[31][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[31][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[31][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[31][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[31][20] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[31][29] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[31][31] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[31][34] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[31][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[31][37] = { ['operacao'] = nil, ['estado'] = 46,} --nao-terminal CORPO

	--Estado 32
	tabela_shift_reduce[32][8] = { ['operacao'] = 'Shift', ['estado'] = 11,} --terminal leia
	tabela_shift_reduce[32][9] = { ['operacao'] = 'Shift', ['estado'] = 13,} --terminal id
	tabela_shift_reduce[32][10] = { ['operacao'] = 'Shift', ['estado'] = 12,} --terminal escreva
	tabela_shift_reduce[32][15] = { ['operacao'] = 'Shift', ['estado'] = 15,} -- terminal se
	tabela_shift_reduce[32][20] = { ['operacao'] = 'Shift', ['estado'] = 58,} -- terminal fimse
	tabela_shift_reduce[32][29] = { ['operacao'] = nil, ['estado'] = 30,} --nao-terminal ES
	tabela_shift_reduce[32][31] = { ['operacao'] = nil, ['estado'] = 31,} --nao-terminal CMD
	tabela_shift_reduce[32][34] = { ['operacao'] = nil, ['estado'] = 32,} --nao-terminal COND
	tabela_shift_reduce[32][35] = { ['operacao'] = nil, ['estado'] = 14,} --nao-terminal CABEÇALHO
	tabela_shift_reduce[32][37] = { ['operacao'] = nil, ['estado'] = 47,} --nao-terminal CORPO

	--Estado 33
	tabela_shift_reduce[33][9] = { ['operacao'] = 'Shift', ['estado'] = 43,} -- terminal id
	tabela_shift_reduce[33][12] = { ['operacao'] = 'Shift', ['estado'] = 44,} -- terminal num
	tabela_shift_reduce[33][33] = { ['operacao'] = nil, ['estado'] = 49,} --nao-terminal OPRD
	tabela_shift_reduce[33][36] = { ['operacao'] = nil, ['estado'] = 48,} --nao-terminal EXP_R

	--Estado 34 --Estado de redução
	tabela_shift_reduce[34][8] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial leia
	tabela_shift_reduce[34][9] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial id
	tabela_shift_reduce[34][10] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial escreva
	tabela_shift_reduce[34][15] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial se
	tabela_shift_reduce[34][21] = { ['operacao'] = 'Reduce', ['estado'] = 4,} --termial fim

	--Estado 35 --Estado de redução
	tabela_shift_reduce[35][8] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial leia
	tabela_shift_reduce[35][9] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial id
	tabela_shift_reduce[35][10] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial escreva
	tabela_shift_reduce[35][15] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial se
	tabela_shift_reduce[35][21] = { ['operacao'] = 'Reduce', ['estado'] = 5,} --termial fim

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
	tabela_shift_reduce[40][15] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial se
	tabela_shift_reduce[40][20] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial fimse
	tabela_shift_reduce[40][21] = { ['operacao'] = 'Reduce', ['estado'] = 11,} --termial fim

	--Estado 41
	tabela_shift_reduce[41][4] = { ['operacao'] = 'Shift', ['estado'] = 51,} --termial ;

	--Estado 42 --Estado de redução
	tabela_shift_reduce[42][4] = { ['operacao'] = 'Reduce', ['estado'] = 19,} --termial ;
	tabela_shift_reduce[42][14] = { ['operacao'] = 'Shift', ['estado'] = 52,} --termial opm

	--Estado 43 --Estado de redução
	tabela_shift_reduce[43][4] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial ;
	tabela_shift_reduce[43][14] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial opm
	tabela_shift_reduce[43][17] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial )
	tabela_shift_reduce[43][19] = { ['operacao'] = 'Reduce', ['estado'] = 20,} --termial opr

	--Estado 44 --Estado de redução
	tabela_shift_reduce[44][4] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial ;
	tabela_shift_reduce[44][14] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial opm
	tabela_shift_reduce[44][17] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial )
	tabela_shift_reduce[44][19] = { ['operacao'] = 'Reduce', ['estado'] = 21,} --termial opr

	--Estado 45 --Estado de redução
	tabela_shift_reduce[45][8] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial leia
	tabela_shift_reduce[45][9] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial id
	tabela_shift_reduce[45][10] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial escreva
	tabela_shift_reduce[45][15] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial se
	tabela_shift_reduce[45][20] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial fimse
	tabela_shift_reduce[45][21] = { ['operacao'] = 'Reduce', ['estado'] = 26,} --termial fim

	--Estado 46 --Estado de redução
	tabela_shift_reduce[46][8] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial leia
	tabela_shift_reduce[46][9] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial id
	tabela_shift_reduce[46][10] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial escreva
	tabela_shift_reduce[46][15] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial se
	tabela_shift_reduce[46][20] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial fimse
	tabela_shift_reduce[46][21] = { ['operacao'] = 'Reduce', ['estado'] = 27,} --termial fim

	--Estado 47 --Estado de redução
	tabela_shift_reduce[47][8] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial leia
	tabela_shift_reduce[47][9] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial id
	tabela_shift_reduce[47][10] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial escreva
	tabela_shift_reduce[47][15] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial se
	tabela_shift_reduce[47][20] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial fimse
	tabela_shift_reduce[47][21] = { ['operacao'] = 'Reduce', ['estado'] = 28,} --termial fim

	--Estado 48
	tabela_shift_reduce[48][17] = { ['operacao'] = 'Shift', ['estado'] = 53,} --termial )

	--Estado 49
	tabela_shift_reduce[49][19] = { ['operacao'] = 'Shift', ['estado'] = 54,} --termial opr

	--Estado 50 --Estado de redução
	tabela_shift_reduce[50][3] = { ['operacao'] = 'Reduce', ['estado'] = 6,} --termial varfim
	tabela_shift_reduce[50][9] = { ['operacao'] = 'Reduce', ['estado'] = 6,} --termial id

	--Estado 51 --Estado de redução
	tabela_shift_reduce[51][8] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial leia
	tabela_shift_reduce[51][9] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial id
	tabela_shift_reduce[51][10] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial escreva
	tabela_shift_reduce[51][15] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial se
	tabela_shift_reduce[51][20] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial fimse
	tabela_shift_reduce[51][21] = { ['operacao'] = 'Reduce', ['estado'] = 17,} --termial fim

	--Estado 52
	tabela_shift_reduce[52][9] = { ['operacao'] = 'Shift', ['estado'] = 43,} -- terminal id
	tabela_shift_reduce[52][12] = { ['operacao'] = 'Shift', ['estado'] = 44,} -- terminal num
	tabela_shift_reduce[52][33] = { ['operacao'] = nil, ['estado'] = 55,} --nao-terminal OPRD

	--Estado 53
	tabela_shift_reduce[53][18] = { ['operacao'] = 'Shift', ['estado'] = 56,} -- terminal entao

	--Estado 54
	tabela_shift_reduce[54][9] = { ['operacao'] = 'Shift', ['estado'] = 43,} -- terminal id
	tabela_shift_reduce[54][12] = { ['operacao'] = 'Shift', ['estado'] = 44,} -- terminal num
	tabela_shift_reduce[54][33] = { ['operacao'] = nil, ['estado'] = 57,} --nao-terminal OPRD

	--Estado 55 --Estado de redução
	tabela_shift_reduce[55][4] = { ['operacao'] = 'Reduce', ['estado'] = 18,} --termial ;

	--Estado 56 --Estado de redução
	tabela_shift_reduce[56][8] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial leia
	tabela_shift_reduce[56][9] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial id
	tabela_shift_reduce[56][10] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial escreva
	tabela_shift_reduce[56][15] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial se
	tabela_shift_reduce[56][20] = { ['operacao'] = 'Reduce', ['estado'] = 24,} --termial fimse

	--Estado 57 --Estado de redução
	tabela_shift_reduce[57][17] = { ['operacao'] = 'Reduce', ['estado'] = 25,} --termial )

	--Estado 58 --Estado de redução
	tabela_shift_reduce[58][8] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial leia
	tabela_shift_reduce[58][9] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial id
	tabela_shift_reduce[58][10] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial escreva
	tabela_shift_reduce[58][15] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial se
	tabela_shift_reduce[58][20] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial fimse
	tabela_shift_reduce[58][21] = { ['operacao'] = 'Reduce', ['estado'] = 29,} --termial fim

	--Estado 59 --Estado de redução
	tabela_shift_reduce[59][8] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial leia
	tabela_shift_reduce[59][9] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial id
	tabela_shift_reduce[59][10] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial escreva
	tabela_shift_reduce[59][15] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial se
	tabela_shift_reduce[59][20] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial fimse
	tabela_shift_reduce[59][21] = { ['operacao'] = 'Reduce', ['estado'] = 12,} --termial fim

	return tabela_shift_reduce
end
