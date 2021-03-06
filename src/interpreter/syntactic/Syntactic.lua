--[[Valmir Torres de Jesus Junior
	date: 23-04-2019

    Syntactic analyzer: The LR (0) automaton and the Shift / Reduce table
    were implemented to perform the syntactic analysis in a Bottom-Up approach.

	-Syntactic Functions-
]]

--import packages
local Stack = require("utils/Stack")
local Lexic = require("interpreter/lexic/Lexic")
local Syntactic_utils = require("interpreter/syntactic/Syntactic_utils")
local Semantic = require("interpreter/semantic/Semantic")
local Commons = require("interpreter/common/Commons")
local Error = require("system/error/Error")


local Syntactic = {
    analyze = function(content)
        local glc = Syntactic_utils.glc_grammar()
        local terminals_table = Syntactic_utils.terminals_list()
        local nonterminals_table = Syntactic_utils.nonterminals_list()
        local sr_table = Syntactic_utils.syntactic_table()
        local token_table = {}
        local lexical_word
        local reduce_control = false
        local end_file = false

        local stack = Stack.create()
        stack:push(1)

        while true do
            if not reduce_control then
                --Receive table with defined token, lexeme and type
                if not end_file and not Commons.error then
                    lexical_word, end_file = Lexic.analyze()
                    if lexical_word ~= false then table.insert(token_table, lexical_word) end
                    if Commons.error then break end
                elseif end_file then
                    lexical_word = {['token'] = '$'}
                end
            end

            local top = stack:top()

            --Ignore tab, space, \n and comment
            if lexical_word ~= false and lexical_word.token ~= 'comentario' then
                --Defining the number that represents the terminal according
                --to the construction of the table shift / reduce
                local terminal
                for k, v in pairs (terminals_table) do
                    if lexical_word.token == v then
                        terminal = k
                        break
                    end
                end

                if sr_table[top][terminal].action == 'Shift' then
                    reduce_control = false
                    --Stacks the terminal and state
                    stack:push (lexical_word, sr_table[top][terminal].state)
                elseif sr_table[top][terminal].action == 'Reduce' then
                    reduce_control = true
                    local temp_state = sr_table[top][terminal].state
                    --shows the rule to be reduced
                    local rule = glc[sr_table[top][terminal].state].symbol..' ->'
                    for _, v in pairs (glc[sr_table[top][terminal].state].production) do
                        rule = rule..' '..v
                    end
                    print(rule)
                    --CFG rule: alpha -> beta
                    --remove the 2*|beta| stack elements
                    local alpha_name = glc[sr_table[top][terminal].state].symbol
                    local beta = #glc[sr_table[top][terminal].state].production
                    --Retrieving information that will be useful for the semantic part
                    local production = {}
                    local temp = false
                    for _ = 1, (2*beta) do
                        if not temp then
                            stack:pop()
                            temp = true
                        else
                            table.insert(production, stack:pop())
                            temp = false
                        end
                    end
                    --Update the top
                    top = stack:top()
                    --It calls the semantic parser that assigns the semantic
                    --rule driven by syntax
                    content = Semantic.analyze(content, temp_state, production)
                    --Generating the alpha variable with the attributes
                    --token, type and lexeme
                    local alpha = Semantic.alpha_gen(temp_state, alpha_name)
                    local nonterminal
                    for k, v in pairs (nonterminals_table) do
                        if alpha_name == v then
                            nonterminal = k + 22
                            break
                        end
                    end
                    --inserts alpha and table state shift / reduce
                    local state = sr_table[top][nonterminal].state
                    stack:push(alpha, state)
                    if Commons.error then break end
                elseif sr_table[top][terminal].action == 'Accept' then
                    --Accepted all code syntax
                    print('S -> P')
                    print(sr_table[top][terminal].action)
                    break
                else
                    print(top, terminal)
                    Error.print_syntactic_error(Commons.num_row, sr_table[top][terminal].action)
                    Commons.error = true
                    break
                end
            end
        end
        return content
    end
}

return Syntactic