--[[Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .cafe file
	and translates to C language.
]]

dofile('compiler/auxiliary_functions.lua')
dofile('compiler/lexical_functions.lua')
dofile('compiler/syntactic_functions.lua')
dofile('compiler/semantic_functions.lua')
dofile('compiler/stack.lua')

--Global Variables
error = false
end_file = false
num_temp = 0
num_char = 1
num_row = 1
read_new_line = true
symbol_table = reserved_words()
nonterminals = nonterminal_attributes()
dfa = regular_dfa()
code = read_file()
array_chars = {}
SIZE_STRING = 256

function start_compiler()
	local file
	--defining the header of program.c
	file = '#include <stdio.h>\ntypedef char lit['..SIZE_STRING..'];\n\nvoid main (void) {\n@'

	file = syntactic_analyzer(file)

	--create temporary variables
	if num_temp > 0 then
		file = string.gsub(file, '@', '/*----Temporary variables----*/\n@')
		for i = 1, num_temp do
			file = string.gsub(file, '@', 'int T'..i..';\n@')
		end
		file = string.gsub(file, '@', '/*-----------------------------*/\n@')
	end
	file = string.gsub(file, '@', '')
	--Finishing the program.c
	file = file..'}\n'
	if not error then
		create_file(file)
	end
end

--call the function
start_compiler()
