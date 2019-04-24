--[[Valmir Torres de Jesus Junior
	date: 23-04-2019

    Semantic analyzer: The table of semantic rules was implemented
    and these rules were attributed after the rule reductions in
    the process of syntactic analysis, thus effecting the application
    of semantic translation directed by the syntax.

	-Syntactic Functions-
]]

--import packages
-- local Common = require("interpreter/common/Common")
local Semantic_utils = require("interpreter/semantic/Semantic_utils")

local nonterminals = Semantic_utils.nonterminal_attributes()

local Semantic = {
    analyze = function (file, rule, production, num_row)
        local terminal = {}
        local n_terminal = {}
        -- local symbol_table = Common.reserved_words()
    
        for i = 1, #production do
            if production[i].is_terminal then
                table.insert(terminal, production[i])
            else table.insert(n_terminal, production[i])
            end
        end
    
        --For each rule of grammar we have a block of semantic rules to be executed
        if rule == 5 then
            file = file..'\n\n\n'
        elseif rule == 6 then
            for i = 1, #symbol_table do
                if symbol_table[i].lexeme == terminal[2].lexeme then
                    symbol_table[i].type = n_terminal[1].type
                    break
                end
            end
            if n_terminal[1].type == 'real' then
                file = file..'double '..terminal[2].lexeme..';\n'
            else file = file..n_terminal[1].type..' '..terminal[2].lexeme..';\n' end
        elseif rule == 7 then
            nonterminals.TIPO.type = symbol_table[11].type
        elseif rule == 8 then
            nonterminals.TIPO.type = symbol_table[13].type
        elseif rule == 9 then
            nonterminals.TIPO.type = symbol_table[12].type
        elseif rule == 11 then
            for i = 1, #symbol_table do
                if symbol_table[i].lexeme == terminal[2].lexeme then
                    if terminal[2].type == 'lit' then
                        file = file..'scanf("%s", '..terminal[2].lexeme..');\n'
                    elseif terminal[2].type == 'int' then
                        file = file..'scanf("%d", &'..terminal[2].lexeme..');\n'
                    elseif terminal[2].type == 'real' then
                        file = file..'scanf("%1f", &'..terminal[2].lexeme..');\n'
                    else
                        print('Line error '..num_row..': variable "'..terminal[2].lexeme..'" not declared.')
                        ERROR = true
                    end
                    break
                end
            end
        elseif rule == 12 then
            if n_terminal[1].type == 'lit' then
                file = file..'printf("%s", '..n_terminal[1].lexeme..');\n'
            elseif n_terminal[1].type == 'int' then
                file = file..'printf("%d", '..n_terminal[1].lexeme..');\n'
            elseif n_terminal[1].type == 'real' then
                file = file..'printf("%.1f", '..n_terminal[1].lexeme..');\n'
            elseif n_terminal[1].type == 'literal' then
                file = file..'printf('..n_terminal[1].lexeme..');\n'
            else
                print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
                ERROR = true
            end
        elseif rule == 13 or rule == 14 then
            nonterminals.ARG.token = terminal[1].token
            nonterminals.ARG.lexeme = terminal[1].lexeme
            nonterminals.ARG.type = terminal[1].type
        elseif rule == 15 then
            local flag = false
            for i = 1, #symbol_table do
                if symbol_table[i].lexeme == terminal[1].lexeme then
                    nonterminals.ARG.token = terminal[1].token
                    nonterminals.ARG.lexeme = terminal[1].lexeme
                    nonterminals.ARG.type = terminal[1].type
                    flag = true
                    break
                end
            end
            if not flag then
                print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
                ERROR = true
            end
        elseif rule == 17 then
            local flag = false
    
            for i = 1, #symbol_table do
                if symbol_table[i].lexeme == terminal[3].lexeme then
                    if symbol_table[i].type == nil then
                        print('Line error '..num_row..': variable "'..terminal[3].lexeme..'" not declared.')
                        ERROR = true
                    else
                        if symbol_table[i].type == n_terminal[1].type or
                            ((symbol_table[i].type == 'int' or symbol_table[i].type == 'real') and
                            (n_terminal[1].type == 'int' or n_terminal[1].type == 'real')) then
                            file = file..symbol_table[i].lexeme..' '..terminal[2].type..' '..n_terminal[1].lexeme..';\n'
                        else
                            print('Line error '..num_row..': different types for assignment.')
                            ERROR = true
                        end
                    end
                    flag = true
                    break
                end
            end
            if not flag then
                print('Line error '..num_row..': variable "'..terminal[3].lexeme..'" not declared.')
                ERROR = true
            end
        elseif rule == 18 then
            if n_terminal[1].type == 'int' or n_terminal[1].type == 'real' and
                n_terminal[2].type == 'int' or n_terminal[2].type == 'real' then
                VAR_TEMP = VAR_TEMP + 1
                local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme
                nonterminals.LD.type = n_terminal[1].type
                nonterminals.LD.lexeme = 'T'..VAR_TEMP
                file = file..'T'..VAR_TEMP..' = '..t..';\n'
    
                nonterminals.OPRD.is_used = false
                nonterminals.OPRD2.is_used = false
                nonterminals.OPRD1.is_used = false
                nonterminals.OPRD3.is_used = false
            else
                print('Line error '..num_row..': different types for assignment.')
                ERROR = true
            end
        elseif rule == 19 then
            nonterminals.LD.token = n_terminal[1].token
            nonterminals.LD.lexeme = n_terminal[1].lexeme
            nonterminals.LD.type = n_terminal[1].type
    
            nonterminals.OPRD.is_used = false
            nonterminals.OPRD2.is_used = false
            nonterminals.OPRD1.is_used = false
            nonterminals.OPRD3.is_used = false
        elseif rule == 20 then
            local flag = false
    
            for i = 1, #symbol_table do
                if symbol_table[i].lexeme == terminal[1].lexeme then
                    if symbol_table[i].type == nil then
                        print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
                        ERROR = true
                    else
                        if not nonterminals.OPRD.is_used then
                            nonterminals.OPRD.lexeme = terminal[1].lexeme
                            nonterminals.OPRD.type = terminal[1].type
                            nonterminals.OPRD.token = terminal[1].token
                            nonterminals.OPRD.is_used = true
                        else
                            nonterminals.OPRD2.lexeme = terminal[1].lexeme
                            nonterminals.OPRD2.type = terminal[1].type
                            nonterminals.OPRD2.token = terminal[1].token
                            nonterminals.OPRD2.is_used = true
                        end
                    end
                    flag = true
                    break
                end
            end
            if not flag then
                print('Line error '..num_row..': variable "'..terminal[1].lexeme..'" not declared.')
                ERROR = true
            end
        elseif rule == 21 then
            if not nonterminals.OPRD1.is_used then
                nonterminals.OPRD1.lexeme = terminal[1].lexeme
                nonterminals.OPRD1.type = terminal[1].type
                nonterminals.OPRD1.token = terminal[1].token
                nonterminals.OPRD1.is_used = true
            else
                nonterminals.OPRD3.lexeme = terminal[1].lexeme
                nonterminals.OPRD3.type = terminal[1].type
                nonterminals.OPRD3.token = terminal[1].token
                nonterminals.OPRD3.is_used = true
            end
        elseif rule == 23 then
            file = file..'}\n'
        elseif rule == 24 then
            file = file..'if ('..n_terminal[1].lexeme..') {\n'
        elseif rule == 25 then
            if n_terminal[1].type == 'int' or n_terminal[1].type == 'real' and
                n_terminal[2].type == 'int' or n_terminal[2].type == 'real' then
                VAR_TEMP = VAR_TEMP + 1
                local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme
    
                nonterminals.EXP_R.lexeme = 'T'..VAR_TEMP
                file = file..'T'..VAR_TEMP..' = '..t..';\n'
    
                nonterminals.OPRD.is_used = false
                nonterminals.OPRD2.is_used = false
                nonterminals.OPRD1.is_used = false
                nonterminals.OPRD3.is_used = false
            else
                print('Line error '..num_row..': different types for assignment.')
                ERROR = true
            end
        end
    
        return file
    end,
    alpha_gen = function (temp_state, alpha_name)
        if temp_state ~= 20 and temp_state ~= 21 then
            return nonterminals[alpha_name]
        else
            if temp_state == 20 then
                if nonterminals.OPRD.is_used and not nonterminals.OPRD2.is_used then
                    return nonterminals.OPRD
                elseif nonterminals.OPRD2.is_used and nonterminals.OPRD.is_used then
                    return nonterminals.OPRD2
                end
            elseif temp_state == 21 then
                if nonterminals.OPRD1.is_used and not nonterminals.OPRD3.is_used then
                    return nonterminals.OPRD1
                elseif nonterminals.OPRD3.is_used and nonterminals.OPRD1.is_used then
                    return nonterminals.OPRD3
                end
            end
        end
    end
}

return Semantic