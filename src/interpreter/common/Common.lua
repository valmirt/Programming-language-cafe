local Common = {
    reserved_words = function ()
        local symbol_table = {
            [1] = {
                ['token'] = 'inicio',
                ['lexeme'] = 'inicio',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [2] = {
                ['token'] = 'varinicio',
                ['lexeme'] = 'varinicio',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [3] = {
                ['token'] = 'varfim',
                ['lexeme'] = 'varfim',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [4] = {
                ['token'] = 'escreva',
                ['lexeme'] = 'escreva',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [5] = {
                ['token'] = 'leia',
                ['lexeme'] = 'leia',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [6] = {
                ['token'] = 'se',
                ['lexeme'] = 'se',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [7] = {
                ['token'] = 'entao',
                ['lexeme'] = 'entao',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [8] = {
                ['token'] = 'senao',
                ['lexeme'] = 'senao',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [9] = {
                ['token'] = 'fimse',
                ['lexeme'] = 'fimse',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [10] = {
                ['token'] = 'fim',
                ['lexeme'] = 'fim',
                ['type'] = nil,
                ['is_terminal'] = true,
            },
            [11] = {
                ['token'] = 'int',
                ['lexeme'] = 'int',
                ['type'] = 'int',
                ['is_terminal'] = true,
            },
            [12] = {
                ['token'] = 'lit',
                ['lexeme'] = 'lit',
                ['type'] = 'lit',
                ['is_terminal'] = true,
            },
            [13] = {
                ['token'] = 'real',
                ['lexeme'] = 'real',
                ['type'] = 'real',
                ['is_terminal'] = true,
            },
        }
    
        return symbol_table
    end
}

return Common