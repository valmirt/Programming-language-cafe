local Semantic_utils = {
    --Defines the non-terminal attributes of the grammar
    nonterminal_attributes = function ()
        local nonterminals = {
            ['S'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['P'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['V'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['LV'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['D'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['TIPO'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['A'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['ES'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['ARG'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['CMD'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['LD'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['OPRD'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
                ['is_used'] = false,
            },
            ['OPRD2'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
                ['is_used'] = false,
            },
            ['OPRD1'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
                ['is_used'] = false,
            },
            ['OPRD3'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
                ['is_used'] = false,
            },
            ['COND'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['CABECALHO'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['EXP_R'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
            ['CORPO'] = {
                ['token'] = nil,
                ['lexeme'] = nil,
                ['type'] = nil,
                ['is_terminal'] = false,
            },
        }

        return nonterminals
    end
}

return Semantic_utils