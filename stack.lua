--[[Valmir Torres de Jesus Junior		128745
	Compiladores 31-05-2018
		
	Compilador feito em lua que dado um arquivo em Mgol é convertido
	para linguagem C.
	
	-Stack Table-
	Disponível em: http://lua-users.org/wiki/SimpleStack
]]

-- GLOBAL
Stack = {}

-- Cria a tabela com as funções de pilha
function Stack:Create()
    -- tabela que representa a pilha
    local t = {}
    -- entry table
    t._et = {}

    -- insere valores na pilha
    function t:push(...)
        if ... then
            local targs = {...}
            -- add values
            for _,v in ipairs(targs) do
                table.insert(self._et, v)
            end
        end
    end

    -- remove um valor da pilha
    function t:pop(num)
        --pega um valor da pilha
        local num = num or 1
        -- return table
        local entries = {}

        -- get values into entries
        for i = 1, num do
            -- get last entry
            if #self._et ~= 0 then
                table.insert(entries, self._et[#self._et])
                -- remove last value
                table.remove(self._et)
            else
                break
            end
        end
        -- return unpacked entries
        return table.unpack(entries)
    end

    --recupera as entradas
    function t:getn()
        return #self._et
    end

    -- lista os valores da pilha
    function t:list()
        for i,v in pairs(self._et) do
        print(i, v)
        end
    end
    return t
end
