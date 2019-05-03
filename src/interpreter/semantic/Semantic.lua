--[[Valmir Torres de Jesus Junior
	date: 23-04-2019

    Semantic analyzer: The table of semantic rules was implemented
    and these rules were attributed after the rule reductions in
    the process of syntactic analysis, thus effecting the application
    of semantic translation directed by the syntax.

	-Semantic Functions-
]]

--import packages
local Symbol_table = require("interpreter/common/Symbol_table")
local Semantic_utils = require("interpreter/semantic/Semantic_utils")
local Commons = require("interpreter/common/Commons")
local Error = require("system/error/Error")

local nonterminals = Semantic_utils.nonterminal_attributes()

local Semantic = {
    analyze = function (file, rule, production)
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
            for i = 1, #Symbol_table do
                if Symbol_table[i].lexeme == terminal[2].lexeme then
                    Symbol_table[i].type = n_terminal[1].type
                    break
                end
            end
            if n_terminal[1].type == 'real' then
                file = file..'double '..terminal[2].lexeme..';\n'
            else file = file..n_terminal[1].type..' '..terminal[2].lexeme..';\n' end
        elseif rule == 7 then
            nonterminals.TIPO.type = Symbol_table[11].type
        elseif rule == 8 then
            nonterminals.TIPO.type = Symbol_table[13].type
        elseif rule == 9 then
            nonterminals.TIPO.type = Symbol_table[12].type
        elseif rule == 11 then
            for i = 1, #Symbol_table do
                if Symbol_table[i].lexeme == terminal[2].lexeme then
                    if terminal[2].type == 'lit' then
                        file = file..'scanf("%s", '..terminal[2].lexeme..');\n'
                    elseif terminal[2].type == 'int' then
                        file = file..'scanf("%d", &'..terminal[2].lexeme..');\n'
                    elseif terminal[2].type == 'real' then
                        file = file..'scanf("%1f", &'..terminal[2].lexeme..');\n'
                    else
                        --Not declared error
                        Error.print_semantic_error(Commons.num_row, 1, terminal[2].lexeme)
                        Commons.error = true
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
                --Not declared error
                Error.print_semantic_error(Commons.num_row, 1, terminal[1].lexeme)
                Commons.error = true
            end
        elseif rule == 13 or rule == 14 then
            nonterminals.ARG.token = terminal[1].token
            nonterminals.ARG.lexeme = terminal[1].lexeme
            nonterminals.ARG.type = terminal[1].type
        elseif rule == 15 then
            local flag = false
            for i = 1, #Symbol_table do
                if Symbol_table[i].lexeme == terminal[1].lexeme then
                    nonterminals.ARG.token = terminal[1].token
                    nonterminals.ARG.lexeme = terminal[1].lexeme
                    nonterminals.ARG.type = terminal[1].type
                    flag = true
                    break
                end
            end
            if not flag then
                --Not declared error
                Error.print_semantic_error(Commons.num_row, 1, terminal[1].lexeme)
                Commons.error = true
            end
        elseif rule == 17 then
            local flag = false

            for i = 1, #Symbol_table do
                if Symbol_table[i].lexeme == terminal[3].lexeme then
                    if Symbol_table[i].type == nil then
                        --Not declared error
                        Error.print_semantic_error(Commons.num_row, 1, terminal[3].lexeme)
                        Commons.error = true
                    else
                        if Symbol_table[i].type == n_terminal[1].type or
                            ((Symbol_table[i].type == 'int' or Symbol_table[i].type == 'real') and
                            (n_terminal[1].type == 'int' or n_terminal[1].type == 'real')) then
                            file = file..Symbol_table[i].lexeme..' '..terminal[2].type..' '..n_terminal[1].lexeme..';\n'
                        else
                            --Different types assignment
                            Error.print_semantic_error(Commons.num_row, 2)
                            Commons.error = true
                        end
                    end
                    flag = true
                    break
                end
            end
            if not flag then
                --Not declared error
                Error.print_semantic_error(Commons.num_row, 1, terminal[3].lexeme)
                Commons.error = true
            end
        elseif rule == 18 then
            if n_terminal[1].type == 'int' or n_terminal[1].type == 'real' and
                n_terminal[2].type == 'int' or n_terminal[2].type == 'real' then
                Commons.number_var = Commons.number_var + 1
                local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme
                nonterminals.LD.type = n_terminal[1].type
                nonterminals.LD.lexeme = 'T'..Commons.number_var
                file = file..'T'..Commons.number_var..' = '..t..';\n'

                nonterminals.OPRD.is_used = false
                nonterminals.OPRD2.is_used = false
                nonterminals.OPRD1.is_used = false
                nonterminals.OPRD3.is_used = false
            else
                --Different types assignment
                Error.print_semantic_error(Commons.num_row, 2)
                Commons.error = true
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

            for i = 1, #Symbol_table do
                if Symbol_table[i].lexeme == terminal[1].lexeme then
                    if Symbol_table[i].type == nil then
                        --Not declared error
                        Error.print_semantic_error(Commons.num_row, 1, terminal[1].lexeme)
                        Commons.error = true
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
                --Not declared error
                Error.print_semantic_error(Commons.num_row, 1, terminal[1].lexeme)
                Commons.error = true
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
                Commons.number_var = Commons.number_var + 1
                local t = n_terminal[2].lexeme..' '..terminal[1].type..' '..n_terminal[1].lexeme

                nonterminals.EXP_R.lexeme = 'T'..Commons.number_var
                file = file..'T'..Commons.number_var..' = '..t..';\n'

                nonterminals.OPRD.is_used = false
                nonterminals.OPRD2.is_used = false
                nonterminals.OPRD1.is_used = false
                nonterminals.OPRD3.is_used = false
            else
                --Different types assignment
                Error.print_semantic_error(Commons.num_row, 2)
                Commons.error = true
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