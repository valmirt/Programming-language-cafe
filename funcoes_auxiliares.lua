--[[Valmir Torres de Jesus Junior		128745
	Compiladores 30-05-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Funções auxiliares-
]]

function le_arquivo (i)
	--abre o arquivo mgol.txt 
	local file = io.open('Mgol.txt', 'r')
	--seta o arquivo como entrada padrão 
	io.input(file)
	--salva arquivo em uma variável
	local string = io.read(i)
	--fecha o arquivo
	io.close(file)
	
	return string
end

function compara_final ()
	--abre o arquivo mgol.txt 
	local file = io.open('Mgol.txt', 'r')
	--seta o arquivo como entrada padrão 
	io.input(file)
	--salva arquivo em uma variável
	local string = io.read('*a')
	--fecha o arquivo
	io.close(file)
	
	return string
end
