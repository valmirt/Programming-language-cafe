--[[Valmir Torres de Jesus Junior
	Compiladores 24-06-2018

	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
]]

dofile('compiler/funcoes_auxiliares.lua')
dofile('compiler/funcoes_lexico.lua')
dofile('compiler/funcoes_sintatico.lua')
dofile('compiler/funcoes_semantico.lua')
dofile('compiler/stack.lua')

--Variáveis globais
erro = false
erro_semantico = false
is_end = false
num_temp = 0
tabela_simbolos = palavras_reservadas()
nao_terminais = atributos_nterminais()

function start_compilador()
	local file
	--Definindo o cabeçalho do programa.c
	file = '#include <stdio.h>\ntypedef char lit[256];\n\nvoid main (void) {\n@'

	file = analisador_sintatico(file)

	--Cria as variáveis temporarias
	if num_temp > 0 then
		file = string.gsub(file, '@', '/*----Variaveis temporarias----*/\n@')
		for i = 1, num_temp do
			file = string.gsub(file, '@', 'int T'..i..';\n@')
		end
		file = string.gsub(file, '@', '/*-----------------------------*/\n@')
	end
	file = string.gsub(file, '@', '')
	--Finalizando o programa.c
	file = file..'}\n'
	--Cria de fato o arquivo.c
	create_file(file)
end

--Chama a função
start_compilador()
