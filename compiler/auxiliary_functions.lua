--[[Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .cafe file
	and translates to C language.

	-Auxiliary Functions-
]]

--function that checks if the token is a reserved word
function check_token (token)
	local temp = token
	local flag = false

	if temp ~= false then
		if temp.token == 'id' then
			--check if it already exists in the symbol table
			for i = 1, #symbol_table do
				if symbol_table[i].lexeme == temp.lexeme then
					temp = symbol_table[i]
					flag = true
					break
				end
			end
			--inserts the id not found before in the symbol table
			if flag == false then
				table.insert(symbol_table, temp)
			end
		end
	end

	return temp
end

function glc_grammar ()
	--cafe Language Context-Free Grammar
	local glc = {
		[1] = {
			['symbol'] = 'S',
			['production'] = {'P',},
		},
		[2] = {
			['symbol'] = 'P',
			['production'] = {'inicio', 'V', 'A',},
		},
		[3] = {
			['symbol'] = 'V',
			['production'] = {'varinicio', 'LV',},
		},
		[4] = {
			['symbol'] = 'LV',
			['production'] = {'D', 'LV',},
		},
		[5] = {
			['symbol'] = 'LV',
			['production'] = {'varfim', 'pt_v',},
		},
		[6] = {
			['symbol'] = 'D',
			['production'] = {'id', 'TIPO', 'pt_v',},
		},
		[7] = {
			['symbol'] = 'TIPO',
			['production'] = {'int',},
		},
		[8] = {
			['symbol'] = 'TIPO',
			['production'] = {'real',},
		},
		[9] = {
			['symbol'] = 'TIPO',
			['production'] = {'lit',},
		},
		[10] = {
			['symbol'] = 'A',
			['production'] = {'ES', 'A',},
		},
		[11] = {
			['symbol'] = 'ES',
			['production'] = {'leia', 'id', 'pt_v',},
		},
		[12] = {
			['symbol'] = 'ES',
			['production'] = {'escreva', 'ARG', 'pt_v',},
		},
		[13] = {
			['symbol'] = 'ARG',
			['production'] = {'literal',},
		},
		[14] = {
			['symbol'] = 'ARG',
			['production'] = {'num',},
		},
		[15] = {
			['symbol'] = 'ARG',
			['production'] = {'id',},
		},
		[16] = {
			['symbol'] = 'A',
			['production'] = {'CMD', 'A',},
		},
		[17] = {
			['symbol'] = 'CMD',
			['production'] = {'id', 'rcb', 'LD', 'pt_v',},
		},
		[18] = {
			['symbol'] = 'LD',
			['production'] = {'OPRD', 'opm', 'OPRD',},
		},
		[19] = {
			['symbol'] = 'LD',
			['production'] = {'OPRD',},
		},
		[20] = {
			['symbol'] = 'OPRD',
			['production'] = {'id',},
		},
		[21] = {
			['symbol'] = 'OPRD',
			['production'] = {'num',},
		},
		[22] = {
			['symbol'] = 'A',
			['production'] = {'COND', 'A',},
		},
		[23] = {
			['symbol'] = 'COND',
			['production'] = {'CABECALHO', 'CORPO',},
		},
		[24] = {
			['symbol'] = 'CABECALHO',
			['production'] = {'se', 'ab_p', 'EXP_R', 'fc_p', 'entao',},
		},
		[25] = {
			['symbol'] = 'EXP_R',
			['production'] = {'OPRD', 'opr', 'OPRD',},
		},
		[26] = {
			['symbol'] = 'CORPO',
			['production'] = {'ES', 'CORPO',},
		},
		[27] = {
			['symbol'] = 'CORPO',
			['production'] = {'CMD', 'CORPO',},
		},
		[28] = {
			['symbol'] = 'CORPO',
			['production'] = {'COND', 'CORPO',},
		},
		[29] = {
			['symbol'] = 'CORPO',
			['production'] = {'fimse',},
		},
		[30] = {
			['symbol'] = 'A',
			['production'] = {'fim',},
		},
	}
	return glc
end

function terminals_list ()
	--list with all the terminals of the grammar
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

function nonterminals_list ()
	--list with all non-terminals of the grammar
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
	--creates the final file .c
	local file = io.open('program.c', 'w')
	--sets the file as the standard output
	io.output(file)
	--write file
	io.write(content)
	--close file
	io.close(file)
end

function read_file ()
	local code = {}
	--dividing into lines for better error feedback
	for line in io.lines 'font.cafe' do
		table.insert(code, line)
	end
	return code
end

function read_line()
	local chars = {}
	for char in string.gmatch(code[num_row], ".") do
		table.insert(chars, char)
	end
	return chars
end

function return_char()
	if read_new_line then
		array_chars = read_line()
	end

	if array_chars[num_char] == nil then
		if num_row < #code then
			num_row = num_row + 1
			num_char = 1
			read_new_line = true
			return '\n'
		elseif num_row == #code then
			return '\n', true
		end
	else
		read_new_line = false
		num_char = num_char + 1
		return array_chars[num_char-1]
	end
end

function print_table (token_table)
	--prints the tokens found in the file font.cafe
	for i = 1, #token_table do
		print ('------------------------------------')
		print (i)
		print ('Token = '..token_table[i].token)
		print ('Lexeme = '..token_table[i].lexeme)
		print ('Type =', token_table[i].type)
		print ()
	end
end
