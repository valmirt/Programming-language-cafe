--[[Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .cafe file
	and translates to C language.

	-Semantic Functions-
]]

function semantic_analyzer (file, rule, production)
	local terminal = {}
	local n_terminal = {}

	for i = 1, #production do
		if production[i].is_terminal then
			table.insert(terminal, production[i])
		else table.insert(n_terminal, production[i])
		end
	end

	--For each rule of grammar we have a block of semantic rules to be executed
	if rule == 5 then
		file = file..'\n\n\n'
	elseif rule == 6 then
		for i = 1, #symbol_table do
			if symbol_table[i].lexeme == terminal[2].lexeme then
				symbol_table[i].type = n_terminal[1].type
				break
			end
		end
		if n_terminal[1].type == 'real' then
			file = file..'double '..terminal[2].lexeme..';\n'
		else file = file..n_terminal[1].type..' '..terminal[2].lexeme..';\n' end
	elseif rule == 7 then
		nonterminals.TIPO.type = symbol_table[11].type
	elseif rule == 8 then
		nonterminals.TIPO.type = symbol_table[13].type
	elseif rule == 9 then
		nonterminals.TIPO.type = symbol_table[12].type
	elseif rule == 11 then
		for i = 1, #symbol_table do
			if symbol_table[i].lexeme == terminal[2].lexeme then
				if terminal[2].type == 'lit' then
					file = file..'scanf("%s", '..terminal[2].lexeme..');\n'
				elseif terminal[2].type == 'int' then
					file = file..'scanf("%d", &'..terminal[2].lexeme..');\n'
				elseif terminal[2].type == 'real' then
					file = file..'scanf("%1f", &'..terminal[2].lexeme..');\n'
				else
					print('Line error '..num_row..': variable "'..terminal[2].lexeme..'" not declared.')
					error = true
				end
				break
			end
		end
	elseif rule == 12 then
		if n_terminal[1].type == 'lit' then
			file = file..'printf("%s", '..n_terminal[1].lexeme..');\n'
		elseif n_terminal[1].type == 'int' then
			file = file..'printf("%d", '..n_terminal[1].lexeme..');\n'
		elseif n_terminal[1].type == 'real' then
			file = file..'printf("%.1f", '..n_terminal[1].lexeme..');\n'
		elseif n_terminal[1].type == 'literal' then
			file = file..'printf('..n_terminal[1].lexeme..');\n'
		else
			print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
			error = true
		end
	elseif rule == 13 or rule == 14 then
		nonterminals.ARG.token = terminal[1].token
		nonterminals.ARG.lexeme = terminal[1].lexeme
		nonterminals.ARG.type = terminal[1].type
	elseif rule == 15 then
		local flag = false
		for i = 1, #symbol_table do
			if symbol_table[i].lexeme == terminal[1].lexeme then
				nonterminals.ARG.token = terminal[1].token
				nonterminals.ARG.lexeme = terminal[1].lexeme
				nonterminals.ARG.type = terminal[1].type
				flag = true
				break
			end
		end
		if not flag then
			print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
			error = true
		end
	elseif rule == 17 then
		local flag = false

		for i = 1, #symbol_table do
			if symbol_table[i].lexeme == terminal[3].lexeme then
				if symbol_table[i].type == nil then
					print('Line error '..num_row..': variable "'..terminal[3].lexeme..'" not declared.')
					error = true
				else
					if symbol_table[i].type == n_terminal[1].type or
						((symbol_table[i].type == 'int' or symbol_table[i].type == 'real') and
						(n_terminal[1].type == 'int' or n_terminal[1].type == 'real')) then
						file = file..symbol_table[i].lexeme..' '..terminal[2].type..' '..n_terminal[1].lexeme..';\n'
					else
						print('Line error '..num_row..': different types for assignment.')
						error = true
					end
				end
				flag = true
				break
			end
		end
		if not flag then
			print('Line error '..num_row..': variable "'..terminal[3].lexeme..'" not declared.')
			error = true
		end
	elseif rule == 18 then
		if n_terminal[1].type == 'int' or n_terminal[1].type == 'real' and
			n_terminal[2].type == 'int' or n_terminal[2].type == 'real' then
			num_temp = num_temp + 1
			local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme
			nonterminals.LD.type = n_terminal[1].type
			nonterminals.LD.lexeme = 'T'..num_temp
			file = file..'T'..num_temp..' = '..t..';\n'

			nonterminals.OPRD.is_used = false
			nonterminals.OPRD2.is_used = false
			nonterminals.OPRD1.is_used = false
			nonterminals.OPRD3.is_used = false
		else
			print('Line error '..num_row..': different types for assignment.')
			error = true
		end
	elseif rule == 19 then
		nonterminals.LD.token = n_terminal[1].token
		nonterminals.LD.lexeme = n_terminal[1].lexeme
		nonterminals.LD.type = n_terminal[1].type

		nonterminals.OPRD.is_used = false
		nonterminals.OPRD2.is_used = false
		nonterminals.OPRD1.is_used = false
		nonterminals.OPRD3.is_used = false
	elseif rule == 20 then
		local flag = false

		for i = 1, #symbol_table do
			if symbol_table[i].lexeme == terminal[1].lexeme then
				if symbol_table[i].type == nil then
					print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
					error = true
				else
					if not nonterminals.OPRD.is_used then
						nonterminals.OPRD.lexeme = terminal[1].lexeme
						nonterminals.OPRD.type = terminal[1].type
						nonterminals.OPRD.token = terminal[1].token
						nonterminals.OPRD.is_used = true
					else
						nonterminals.OPRD2.lexeme = terminal[1].lexeme
						nonterminals.OPRD2.type = terminal[1].type
						nonterminals.OPRD2.token = terminal[1].token
						nonterminals.OPRD2.is_used = true
					end
				end
				flag = true
				break
			end
		end
		if not flag then
			print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
			error = true
		end
	elseif rule == 21 then
		if not nonterminals.OPRD1.is_used then
			nonterminals.OPRD1.lexeme = terminal[1].lexeme
			nonterminals.OPRD1.type = terminal[1].type
			nonterminals.OPRD1.token = terminal[1].token
			nonterminals.OPRD1.is_used = true
		else
			nonterminals.OPRD3.lexeme = terminal[1].lexeme
			nonterminals.OPRD3.type = terminal[1].type
			nonterminals.OPRD3.token = terminal[1].token
			nonterminals.OPRD3.is_used = true
		end
	elseif rule == 23 then
		file = file..'}\n'
	elseif rule == 24 then
		file = file..'if ('..n_terminal[1].lexeme..') {\n'
	elseif rule == 25 then
		if n_terminal[1].type == 'int' or n_terminal[1].type == 'real' and
			n_terminal[2].type == 'int' or n_terminal[2].type == 'real' then
			num_temp = num_temp + 1
			local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme

			nonterminals.EXP_R.lexeme = 'T'..num_temp
			file = file..'T'..num_temp..' = '..t..';\n'

			nonterminals.OPRD.is_used = false
			nonterminals.OPRD2.is_used = false
			nonterminals.OPRD1.is_used = false
			nonterminals.OPRD3.is_used = false
		else
			print('Line error '..num_row..': different types for assignment.')
			error = true
		end
	end

	return file
end

function reserved_words ()
	local symbol_table = {
		[1] = {
			['token'] = 'inicio',
			['lexeme'] = 'inicio',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[2] = {
			['token'] = 'varinicio',
			['lexeme'] = 'varinicio',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[3] = {
			['token'] = 'varfim',
			['lexeme'] = 'varfim',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[4] = {
			['token'] = 'escreva',
			['lexeme'] = 'escreva',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[5] = {
			['token'] = 'leia',
			['lexeme'] = 'leia',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[6] = {
			['token'] = 'se',
			['lexeme'] = 'se',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[7] = {
			['token'] = 'entao',
			['lexeme'] = 'entao',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[8] = {
			['token'] = 'senao',
			['lexeme'] = 'senao',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[9] = {
			['token'] = 'fimse',
			['lexeme'] = 'fimse',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[10] = {
			['token'] = 'fim',
			['lexeme'] = 'fim',
			['type'] = nil,
			['is_terminal'] = true,
		},
		[11] = {
			['token'] = 'int',
			['lexeme'] = 'int',
			['type'] = 'int',
			['is_terminal'] = true,
		},
		[12] = {
			['token'] = 'lit',
			['lexeme'] = 'lit',
			['type'] = 'lit',
			['is_terminal'] = true,
		},
		[13] = {
			['token'] = 'real',
			['lexeme'] = 'real',
			['type'] = 'real',
			['is_terminal'] = true,
		},
	}

	return symbol_table
end

--Defines the non-terminal attributes of the grammar
function nonterminal_attributes()
	local nonterminals = {
		['S'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['P'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['V'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['LV'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['D'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['TIPO'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['A'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['ES'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['ARG'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['CMD'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['LD'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['OPRD'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD2'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD1'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['OPRD3'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
			['is_used'] = false,
		},
		['COND'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['CABECALHO'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['EXP_R'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
		['CORPO'] = {
			['token'] = nil,
			['lexeme'] = nil,
			['type'] = nil,
			['is_terminal'] = false,
		},
	}

	return nonterminals
end
