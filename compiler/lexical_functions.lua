--[[Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .coffee file
	and translates to C language.

	-Lexical Functions-
]]

function lexical_analyzer ()
	local lexeme = ''

	--buffer used to walk in DFA
	local buffer = {
		['previous_state'] = nil,
		['current_state'] = 1,
		['entry'] = nil,
	}
	--element that will be sent at the end of the analysis
	local terminal = {
		['token'] = nil,
		['lexeme'] = nil,
		['type'] = nil,
		['is_terminal'] = true,
	}

	--repeat until you return to the initial state or rejection state
	repeat
		--transfers the characters read in the file
		local char, end_f = return_char()

		--end of file
		if end_f then
			end_file = true
			if buffer.current_state == 10 then
				print('Error: Quotes were not closed.')
				error = true
				return nil
			elseif buffer.current_state == 12 then
				print('Error: Keys were not closed.')
				error = true
				return nil
			end
		end
		--Save the previous_state
		buffer.previous_state = buffer.current_state
		buffer.entry = char
		--char +
		if string.byte(buffer.entry) == 43 then
			buffer.current_state = dfa[buffer.current_state][1]
		--char -
		elseif string.byte(buffer.entry) == 45 then
			buffer.current_state = dfa[buffer.current_state][2]
		--char *
		elseif string.byte(buffer.entry) == 42 then
			buffer.current_state = dfa[buffer.current_state][3]
		--char /
		elseif string.byte(buffer.entry) == 47 then
			buffer.current_state = dfa[buffer.current_state][4]
		--char num
		elseif string.byte(buffer.entry) >= 48 and
				string.byte(buffer.entry) <= 57 then
			buffer.current_state = dfa[buffer.current_state][5]
		--char .
		elseif string.byte(buffer.entry) == 46 then
			buffer.current_state = dfa[buffer.current_state][6]
		--char e
		elseif string.byte(buffer.entry) == 101 then
			buffer.current_state = dfa[buffer.current_state][7]
		--char E
		elseif string.byte(buffer.entry) == 69 then
			buffer.current_state = dfa[buffer.current_state][8]
		--char lit
		elseif (string.byte(buffer.entry) >= 65 and string.byte(buffer.entry) <= 90) or
				(string.byte(buffer.entry) >= 97 and string.byte(buffer.entry) <= 122) then
			buffer.current_state = dfa[buffer.current_state][9]
		--char _
		elseif string.byte(buffer.entry) == 95 then
			buffer.current_state = dfa[buffer.current_state][10]
		--char {
		elseif string.byte(buffer.entry) == 123 then
			buffer.current_state = dfa[buffer.current_state][11]
		--char }
		elseif string.byte(buffer.entry) == 125 then
			buffer.current_state = dfa[buffer.current_state][12]
		--char "
		elseif string.byte(buffer.entry) == 34 then
			buffer.current_state = dfa[buffer.current_state][13]
		--char >
		elseif string.byte(buffer.entry) == 62 then
			buffer.current_state = dfa[buffer.current_state][14]
		--char =
		elseif string.byte(buffer.entry) == 61 then
			buffer.current_state = dfa[buffer.current_state][15]
		--char <
		elseif string.byte(buffer.entry) == 60 then
			buffer.current_state = dfa[buffer.current_state][16]
		--char (
		elseif string.byte(buffer.entry) == 40 then
			buffer.current_state = dfa[buffer.current_state][17]
		--char )
		elseif string.byte(buffer.entry) == 41 then
			buffer.current_state = dfa[buffer.current_state][18]
		--char ;
		elseif string.byte(buffer.entry) == 59 then
			buffer.current_state = dfa[buffer.current_state][19]
		--space/ tab/ line break
		elseif string.byte(buffer.entry) == 32 or string.byte(buffer.entry) == 9 or
				string.byte(buffer.entry) == 10 then
			buffer.current_state = dfa[buffer.current_state][20]
		--chars : and \ that go in the commentary or literal
		elseif string.byte(buffer.entry) == 58 or string.byte(buffer.entry) == 92 then
			buffer.current_state = dfa[buffer.current_state][21]
		else
			print ('Line error '..num_row..': invalid character "'..buffer.entry..'".')
			error = true
			return nil
		end

		if buffer.current_state ~= 1 and buffer.current_state ~= 22 then
			--stores the lexeme per character
			lexeme = lexeme..buffer.entry
		else
			if buffer.previous_state ~= 1 then
				if num_char > 1 then
					num_char = num_char - 1
				end
			end
		end
	--stopping condition
	until buffer.current_state == 1 or buffer.current_state == 22

	--checks whether it is end state
	if buffer.current_state == 1 then
		if buffer.previous_state == 1 then
			terminal = false
		elseif buffer.previous_state == 2 then
			terminal.token = 'opm'
			terminal.lexeme = lexeme
			terminal.type = lexeme
			terminal.is_terminal = true
		elseif buffer.previous_state == 3 or buffer.previous_state == 5 or
				buffer.previous_state == 8 then
			terminal.token = 'num'
			terminal.lexeme = lexeme
			terminal.type = 'real'
			terminal.is_terminal = true
		elseif buffer.previous_state == 9 then
			terminal.token = 'id'
			terminal.lexeme = lexeme
			terminal.type = nil
			terminal.is_terminal = true
		elseif buffer.previous_state == 11 then
			terminal.token = 'literal'
			terminal.lexeme = lexeme
			terminal.type = 'literal'
			terminal.is_terminal = true
		elseif buffer.previous_state == 13 then
			terminal.token = 'comentario'
			terminal.lexeme = lexeme
			terminal.type = nil
			terminal.is_terminal = true
		elseif buffer.previous_state == 14 or buffer.previous_state == 15 or
				buffer.previous_state == 16 or buffer.previous_state == 21 then
			terminal.token = 'opr'
			terminal.lexeme = lexeme
			terminal.type = lexeme
			terminal.is_terminal = true
		elseif buffer.previous_state == 17 then
			terminal.token = 'rcb'
			terminal.lexeme = lexeme
			terminal.type = '='
			terminal.is_terminal = true
		elseif buffer.previous_state == 18 then
			terminal.token = 'ab_p'
			terminal.lexeme = lexeme
			terminal.type = lexeme
			terminal.is_terminal = true
		elseif buffer.previous_state == 19 then
			terminal.token = 'fc_p'
			terminal.lexeme = lexeme
			terminal.type = lexeme
			terminal.is_terminal = true
		elseif buffer.previous_state == 20 then
			terminal.token = 'pt_v'
			terminal.lexeme = lexeme
			terminal.type = lexeme
			terminal.is_terminal = true
		end
	else
		print ('Line error '..num_row..': invalid character "'..buffer.entry..'".')
		error = true
		return nil
	end

	terminal = check_token(terminal)
	return terminal
end

function regular_dfa ()
	local DFA_SIZE = 22
	local dfa = {}
	for i = 1, DFA_SIZE do
		dfa[i] = {}
	end

	for i = 1, DFA_SIZE do
		for j = 1, 21 do
			dfa[i][j] = 1
		end
	end

	--state s1
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

	--state s3
	dfa[3][5] = 3
	dfa[3][6] = 4
	dfa[3][7] = 6
	dfa[3][8] = 6

	--state s4
	dfa[4][1] = 22
	dfa[4][2] = 22
	dfa[4][3] = 22
	dfa[4][4] = 22
	dfa[4][5] = 5
	for i = 6, 21 do
		dfa[4][i] = 22
	end

	--state s5
	dfa[5][5] = 5
	dfa[5][7] = 6
	dfa[5][8] = 6

	--state s6
	dfa[6][1] = 7
	dfa[6][2] = 7
	dfa[6][3] = 22
	dfa[6][4] = 22
	dfa[6][5] = 8
	for i = 6, 21 do
		dfa[6][i] = 22
	end

	--state s7
	dfa[7][1] = 22
	dfa[7][2] = 22
	dfa[7][3] = 22
	dfa[7][4] = 22
	dfa[7][5] = 8
	for i = 6, 21 do
		dfa[7][i] = 22
	end

	--state s8
	dfa[8][5] = 8

	--state s9
	dfa[9][5] = 9
	dfa[9][7] = 9
	dfa[9][8] = 9
	dfa[9][9] = 9
	dfa[9][10] = 9

	--state s10
	for i = 1, 12 do
		dfa[10][i] = 10
	end
	dfa[10][13] = 11
	for i = 14, 21 do
		dfa[10][i] = 10
	end

	--state s12
	for i = 1, 11 do
		dfa[12][i] = 12
	end
	dfa[12][12] = 13
	for i = 13, 21 do
		dfa[12][i] = 12
	end

	--state s14
	dfa[14][15] = 16

	--state s15
	dfa[15][2] = 17
	dfa[15][14] = 16
	dfa[15][15] = 16

	--state s22
	for i = 1, 21 do
		dfa[22][i] = 22
	end

	return dfa
end
