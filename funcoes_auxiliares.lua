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

function print_tabela_tokens (tabela_tokens)
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

function print_tabela_simbolos (tabela_simbolos)
	--Imprime os tokens da tabela de simbolos 
	print ('\n\n------------TABELA DE SIMBOLOS-----------------')
	for i = 1, #tabela_simbolos do
		print ('------------------------------------')
		print (i)
		print ('Token = '..tabela_simbolos[i].token) 
		print ('Lexema = '..tabela_simbolos[i].lexema) 
		print ('Tipo =', tabela_simbolos[i].tipo)
		print ()
	end
end
	

