--[[Valmir Torres de Jesus Junior
	date: 23-04-2019

	The compiler made in Lua that receives a .vt file
	and translates to C language.
]]

-- import packages
local Utils = require("utils/Utils")
local Syntactic = require("interpreter/syntactic/Syntactic")
local Common = require("interpreter/common/Common")

--Global Variables
ERROR = false
VAR_TEMP = 0
symbol_table = Common.reserved_words()
local SIZE_STRING = 256

local start_compiler = function ()
	local num_row = 1
	local file
	--defining the header of program.c
	file = '#include <stdio.h>\ntypedef char lit['..SIZE_STRING..'];\n\nvoid main (void) {\n@'

	file = Syntactic.analyze(file, num_row)

	--create temporary variables
	if VAR_TEMP > 0 then
		file = string.gsub(file, '@', '/*----Temporary variables----*/\n@')
		for i = 1, VAR_TEMP do
			file = string.gsub(file, '@', 'int T'..i..';\n@')
		end
		file = string.gsub(file, '@', '/*-----------------------------*/\n@')
	end
	file = string.gsub(file, '@', '')
	--Finishing the program.c
	file = file..'}\n'
	if not ERROR then
		Utils.create_file(file)
	end
end

--call the function
start_compiler()