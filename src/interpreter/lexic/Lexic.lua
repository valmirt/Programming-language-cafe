--[[Valmir Torres de Jesus Junior
    date: 23-04-2019

    Lexical analyzer: The DFA (finite deterministic automaton)
    of the .vt language was implemented and all the lexemes were
    identified, defining their respective token and type.
]]

--import packages
local Lexic_utils = require("interpreter/lexic/Lexic_utils")
local Utils = require("utils/Utils")
local Commons = require("interpreter/common/Commons")
local Error = require("system/error/Error")

local read_new_line = true
local array_chars
local num_char = 1
local code = Utils.read_file()
local dfa = Lexic_utils.regular_dfa()

local return_char = function ()
    if read_new_line then
        array_chars = Utils.read_line(code, Commons.num_row)
    end
    if array_chars[num_char] == nil then
        if Commons.num_row < #code then
            Commons.num_row = Commons.num_row + 1
            num_char = 1
            read_new_line = true
            return '\n', false
        elseif Commons.num_row == #code then
            return '\n', true
        end
    else
        read_new_line = false
        num_char = num_char + 1
        return array_chars[num_char-1], false
    end
end


local Lexic = {
    analyze = function ()
        local lexeme = ''
        --buffer used to walk in DFA
        local buffer = {
            ['previous_state'] = nil,
            ['current_state'] = 1,
            ['entry'] = nil,
        }
        --element that will be sent at the end of the analysis
        local terminal = {
            ['token'] = nil,
            ['lexeme'] = nil,
            ['type'] = nil,
            ['is_terminal'] = true,
        }
        --if the file end in the line 67 it will be true
        local end_f = false

        --repeat until you return to the initial state or rejection state
        repeat
            --transfers the characters read in the file
            local char
            char, end_f = return_char()

            --end of file
            if end_f then
                if buffer.current_state == 10 then
                    print('Error: Quotes were not closed.')
                    Commons.error = true
                    return nil, end_f
                elseif buffer.current_state == 12 then
                    print('Error: Keys were not closed.')
                    Commons.error = true
                    return nil, end_f
                end
            end
            --Save the previous_state
            buffer.previous_state = buffer.current_state
            buffer.entry = char
            --char +
            if string.byte(buffer.entry) == 43 then
                buffer.current_state = dfa[buffer.current_state][1]
            --char -
            elseif string.byte(buffer.entry) == 45 then
                buffer.current_state = dfa[buffer.current_state][2]
            --char *
            elseif string.byte(buffer.entry) == 42 then
                buffer.current_state = dfa[buffer.current_state][3]
            --char /
            elseif string.byte(buffer.entry) == 47 then
                buffer.current_state = dfa[buffer.current_state][4]
            --char num
            elseif string.byte(buffer.entry) >= 48 and
                    string.byte(buffer.entry) <= 57 then
                buffer.current_state = dfa[buffer.current_state][5]
            --char .
            elseif string.byte(buffer.entry) == 46 then
                buffer.current_state = dfa[buffer.current_state][6]
            --char e
            elseif string.byte(buffer.entry) == 101 then
                buffer.current_state = dfa[buffer.current_state][7]
            --char E
            elseif string.byte(buffer.entry) == 69 then
                buffer.current_state = dfa[buffer.current_state][8]
            --char lit
            elseif (string.byte(buffer.entry) >= 65 and string.byte(buffer.entry) <= 90) or
                    (string.byte(buffer.entry) >= 97 and string.byte(buffer.entry) <= 122) then
                buffer.current_state = dfa[buffer.current_state][9]
            --char _
            elseif string.byte(buffer.entry) == 95 then
                buffer.current_state = dfa[buffer.current_state][10]
            --char {
            elseif string.byte(buffer.entry) == 123 then
                buffer.current_state = dfa[buffer.current_state][11]
            --char }
            elseif string.byte(buffer.entry) == 125 then
                buffer.current_state = dfa[buffer.current_state][12]
            --char "
            elseif string.byte(buffer.entry) == 34 then
                buffer.current_state = dfa[buffer.current_state][13]
            --char >
            elseif string.byte(buffer.entry) == 62 then
                buffer.current_state = dfa[buffer.current_state][14]
            --char =
            elseif string.byte(buffer.entry) == 61 then
                buffer.current_state = dfa[buffer.current_state][15]
            --char <
            elseif string.byte(buffer.entry) == 60 then
                buffer.current_state = dfa[buffer.current_state][16]
            --char (
            elseif string.byte(buffer.entry) == 40 then
                buffer.current_state = dfa[buffer.current_state][17]
            --char )
            elseif string.byte(buffer.entry) == 41 then
                buffer.current_state = dfa[buffer.current_state][18]
            --char ;
            elseif string.byte(buffer.entry) == 59 then
                buffer.current_state = dfa[buffer.current_state][19]
            --space/ tab/ line break
            elseif string.byte(buffer.entry) == 32 or string.byte(buffer.entry) == 9 or
                    string.byte(buffer.entry) == 10 then
                buffer.current_state = dfa[buffer.current_state][20]
            --chars : and \ that go in the commentary or literal
            elseif string.byte(buffer.entry) == 58 or string.byte(buffer.entry) == 92 then
                buffer.current_state = dfa[buffer.current_state][21]
            else
                Error.print_lexic_error(Commons.num_row, buffer.entry)
                Commons.error = true
                return nil, end_f
            end

            if buffer.current_state ~= 1 and buffer.current_state ~= 22 then
                --stores the lexeme per character
                lexeme = lexeme..buffer.entry
            else
                if buffer.previous_state ~= 1 then
                    if num_char > 1 then
                        num_char = num_char - 1
                    end
                end
            end
        --stopping condition
        until buffer.current_state == 1 or buffer.current_state == 22

        --checks whether it is end state
        if buffer.current_state == 1 then
            if buffer.previous_state == 1 then
                terminal = false
            elseif buffer.previous_state == 2 then
                terminal.token = 'opm'
                terminal.lexeme = lexeme
                terminal.type = lexeme
                terminal.is_terminal = true
            elseif buffer.previous_state == 3 or buffer.previous_state == 5 or
                    buffer.previous_state == 8 then
                terminal.token = 'num'
                terminal.lexeme = lexeme
                terminal.type = 'real'
                terminal.is_terminal = true
            elseif buffer.previous_state == 9 then
                terminal.token = 'id'
                terminal.lexeme = lexeme
                terminal.type = nil
                terminal.is_terminal = true
            elseif buffer.previous_state == 11 then
                terminal.token = 'literal'
                terminal.lexeme = lexeme
                terminal.type = 'literal'
                terminal.is_terminal = true
            elseif buffer.previous_state == 13 then
                terminal.token = 'comentario'
                terminal.lexeme = lexeme
                terminal.type = nil
                terminal.is_terminal = true
            elseif buffer.previous_state == 14 or buffer.previous_state == 15 or
                    buffer.previous_state == 16 or buffer.previous_state == 21 then
                terminal.token = 'opr'
                terminal.lexeme = lexeme
                terminal.type = lexeme
                terminal.is_terminal = true
            elseif buffer.previous_state == 17 then
                terminal.token = 'rcb'
                terminal.lexeme = lexeme
                terminal.type = '='
                terminal.is_terminal = true
            elseif buffer.previous_state == 18 then
                terminal.token = 'ab_p'
                terminal.lexeme = lexeme
                terminal.type = lexeme
                terminal.is_terminal = true
            elseif buffer.previous_state == 19 then
                terminal.token = 'fc_p'
                terminal.lexeme = lexeme
                terminal.type = lexeme
                terminal.is_terminal = true
            elseif buffer.previous_state == 20 then
                terminal.token = 'pt_v'
                terminal.lexeme = lexeme
                terminal.type = lexeme
                terminal.is_terminal = true
            end
        else
            Error.print_lexic_error(Commons.num_row, buffer.entry)
            Commons.error = true
            return nil, end_f
        end

        terminal = Lexic_utils.check_token(terminal)
        return terminal, end_f
    end
}

return Lexic