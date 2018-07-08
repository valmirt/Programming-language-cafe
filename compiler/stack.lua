--[[Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .cafe file
	and translates to C language.

    -Stack Table-
    Available at: http://lua-users.org/wiki/SimpleStack
]]

-- GLOBAL
Stack = {}

function Stack:Create()
    local t = {}
    -- entry table
    t._et = {}

    function t:push(...)
        if ... then
            local targs = {...}
            -- add values
            for _,v in ipairs(targs) do
                table.insert(self._et, v)
            end
        end
    end

    function t:pop(num)
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

    --return the entries
    function t:getn()
        return #self._et
    end

    --return the value from the top of the stack
    function t:top()
        return self._et[#self._et]
    end

    --list the values of the stack
    function t:list()
        for i,v in pairs(self._et) do
        print(i, v)
        end
    end
    return t
end
