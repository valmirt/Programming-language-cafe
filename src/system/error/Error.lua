local Commons = require("interpreter/common/Commons")

local Error = {
    print_lexic_error = function (_row, _char, error)
        local row = _row or Commons.num_row
        local char = _char or ''
        local err = error or 'Error on line '..row..': Invalid character "'..char..'".'
        print(err)
    end,
    print_syntactic_error = function(_row, _error)
        local row = _row
        local error = _error or 'Sorry! Something is wrong... try again.'
        local err = 'Error on line '..row..':'.. error
        print(err)
    end,
    print_semantic_error = function (_row, _type, _var, _error)
        local row = _row or Commons.num_row
        local type = _type or 3
        local var = _var or ''
        local error = _error or ' Sorry! Something is wrong... try again.'
        local err = {
            [1] = 'Error on line '..row..':'..': variable "'..var..'" not declared.',
            [2] = 'Error on line '..row..':'..': different types for assignment.',
            [3] = 'Error on line '..row..':'.. error
        }
        print(err[type])
    end
}

return Error