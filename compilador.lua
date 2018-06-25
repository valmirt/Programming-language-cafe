--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
]]

dofile('funcoes_auxiliares.lua')
dofile('funcoes_lexico.lua')
dofile('funcoes_sintatico.lua')
dofile('funcoes_semantico.lua')
dofile('stack.lua')

erro = false
is_end = false
--Popula a tabela de simbolos com as palavras reservadas
tabela_simbolos = palavras_reservadas()

function start_compilador()
	local file 
	--Definindo o cabeçalho do programa .c
	file = '#include <stdio.h>\ntypedef char literal[256];\nvoid main (void) {\n'
	
	file = analisador_sintatico(file)
	
	--Cria de fato o arquivo .c
	create_file(file)
end

--Chama a função
start_compilador()
