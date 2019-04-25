--[[Valmir Torres de Jesus Junior
    date: 23-04-2019
    
    Lexical Utils: Functions utils to Lexical analyzer
]]

local Symbol_table = require("interpreter/common/Symbol_table")

local Lexic_utils = {
    --function that checks if the token is a reserved word
    check_token = function (token)
        -- local symbol_table = Common.reserved_words()
        local temp = token
        local flag = false

        if temp ~= false then
            if temp.token == 'id' then
                --check if it already exists in the symbol table
                for i = 1, #Symbol_table do
                    if Symbol_table[i].lexeme == temp.lexeme then
                        temp = Symbol_table[i]
                        flag = true
                        break
                    end
                end
                --inserts the id not found before in the symbol table
                if flag == false then
                    table.insert(Symbol_table, temp)
                end
            end
        end

        return temp
    end,
    regular_dfa = function ()
        local DFA_SIZE = 22
        local dfa = {}
        for i = 1, DFA_SIZE do
            dfa[i] = {}
        end
    
        for i = 1, DFA_SIZE do
            for j = 1, 21 do
                dfa[i][j] = 1
            end
        end
    
        --state s1
        dfa[1][1] = 2 -- +
        dfa[1][2] = 2 -- -
        dfa[1][3] = 2 -- *
        dfa[1][4] = 2 -- /
        dfa[1][5] = 3 -- Digitos
        dfa[1][6] = 22 -- .
        dfa[1][7] = 9 -- e
        dfa[1][8] = 9 -- E
        dfa[1][9] = 9 -- Literal
        dfa[1][10] = 22 -- _
        dfa[1][11] = 12 -- {
        dfa[1][12] = 22 -- }
        dfa[1][13] = 10 -- "
        dfa[1][14] = 14 -- >
        dfa[1][15] = 21 -- =
        dfa[1][16] = 15 -- <
        dfa[1][17] = 18 -- )
        dfa[1][18] = 19 -- (
        dfa[1][19] = 20 -- ;
        dfa[1][20] = 1 -- space
        dfa[1][21] = 22 -- \ e :
    
        --state s3
        dfa[3][5] = 3
        dfa[3][6] = 4
        dfa[3][7] = 6
        dfa[3][8] = 6
    
        --state s4
        dfa[4][1] = 22
        dfa[4][2] = 22
        dfa[4][3] = 22
        dfa[4][4] = 22
        dfa[4][5] = 5
        for i = 6, 21 do
            dfa[4][i] = 22
        end
    
        --state s5
        dfa[5][5] = 5
        dfa[5][7] = 6
        dfa[5][8] = 6
    
        --state s6
        dfa[6][1] = 7
        dfa[6][2] = 7
        dfa[6][3] = 22
        dfa[6][4] = 22
        dfa[6][5] = 8
        for i = 6, 21 do
            dfa[6][i] = 22
        end
    
        --state s7
        dfa[7][1] = 22
        dfa[7][2] = 22
        dfa[7][3] = 22
        dfa[7][4] = 22
        dfa[7][5] = 8
        for i = 6, 21 do
            dfa[7][i] = 22
        end
    
        --state s8
        dfa[8][5] = 8
    
        --state s9
        dfa[9][5] = 9
        dfa[9][7] = 9
        dfa[9][8] = 9
        dfa[9][9] = 9
        dfa[9][10] = 9
    
        --state s10
        for i = 1, 12 do
            dfa[10][i] = 10
        end
        dfa[10][13] = 11
        for i = 14, 21 do
            dfa[10][i] = 10
        end
    
        --state s12
        for i = 1, 11 do
            dfa[12][i] = 12
        end
        dfa[12][12] = 13
        for i = 13, 21 do
            dfa[12][i] = 12
        end
    
        --state s14
        dfa[14][15] = 16
    
        --state s15
        dfa[15][2] = 17
        dfa[15][14] = 16
        dfa[15][15] = 16
    
        --state s22
        for i = 1, 21 do
            dfa[22][i] = 22
        end
    
        return dfa
    end
}

return Lexic_utils