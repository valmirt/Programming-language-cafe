local Utils = {
    --Creates the final program.c
    create_file = function (content)
        local file = io.open('../build/program.c', 'w')
        --sets the file as the standard output
        io.output(file)
        io.write(content)
        io.close(file)
    end,
    --Read the file font.vt and divide in a table code
    --each line is a line of file
    read_file = function ()
        local code = {}
        --dividing into lines for better error feedback
        for line in io.lines('../font.cafe') do
            table.insert(code, line)
        end
        return code
    end,
    --Read a line from the code table from font.vt
    read_line = function (code, num_row)
        local chars = {}
        for char in string.gmatch(code[num_row], ".") do
            table.insert(chars, char)
        end
        return chars
    end,
    --prints the tokens found in the file font.vt
    print_table = function (token_table)
        for i = 1, #token_table do
            print ('------------------------------------')
            print (i)
            print ('Token = '..token_table[i].token)
            print ('Lexeme = '..token_table[i].lexeme)
            print ('Type =', token_table[i].type)
            print ()
        end
    end
}

return Utils