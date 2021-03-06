local Syntactic_utils = {
    --Shift / Reduce Syntactic Table
    syntactic_table = function ()
        --Creating the syntactic table from the LR(0) automaton
        local shift_reduce_table = {}
        for i = 1, 59 do
            shift_reduce_table[i] = {}
        end

        --Initializing the array shift_reduce_table
        --index 1-21 = terminais
        --index 22-36 = nonterminais
        for i = 1, 59 do
            --Table with description of the syntactic errors to aid in the debugging of the .cafe programmer
            shift_reduce_table[i][1] = { ['action'] = ' Bad syntax... inicio disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][2] = { ['action'] = ' Bad syntax... varinicio disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][3] = { ['action'] = ' Bad syntax... varfim disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][4] = { ['action'] = ' Bad syntax... caractere ; disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][5] = { ['action'] = ' Bad syntax... declaração inteiro incorreta.', ['state'] = nil,}
            shift_reduce_table[i][6] = { ['action'] = ' Bad syntax... declaração real incorreta.', ['state'] = nil,}
            shift_reduce_table[i][7] = { ['action'] = ' Bad syntax... declaração literal incorreta.', ['state'] = nil,}
            shift_reduce_table[i][8] = { ['action'] = ' Bad syntax... operação leia disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][9] = { ['action'] = ' Bad syntax... id disposto de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][10] = { ['action'] = ' Bad syntax... operação escreva incorreta.', ['state'] = nil,}
            shift_reduce_table[i][11] = { ['action'] = ' Bad syntax... literal descrito de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][12] = { ['action'] = ' Bad syntax... número descrito de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][13] = { ['action'] = ' Bad syntax... descrito na atribuição.', ['state'] = nil,}
            shift_reduce_table[i][14] = { ['action'] = ' Bad syntax... operador aritmético incorreto.', ['state'] = nil,}
            shift_reduce_table[i][15] = { ['action'] = ' Bad syntax... estrutura de seleção incorreta.', ['state'] = nil,}
            shift_reduce_table[i][16] = { ['action'] = ' Bad syntax... caractere ( descrito de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][17] = { ['action'] = ' Bad syntax... caractere ) descrito de forma incorreta.', ['state'] = nil,}
            shift_reduce_table[i][18] = { ['action'] = ' Bad syntax... estrutura de seleção incorreta.', ['state'] = nil,}
            shift_reduce_table[i][19] = { ['action'] = ' Bad syntax... operador relacional incorreto.', ['state'] = nil,}
            shift_reduce_table[i][20] = { ['action'] = ' Bad syntax... estrutura de seleção incorreta.', ['state'] = nil,}
            shift_reduce_table[i][21] = { ['action'] = ' Bad syntax... fim disposto de forma incorreta', ['state'] = nil,}
            shift_reduce_table[i][22] = { ['action'] = ' Bad syntax...', ['state'] = nil,}
            for j = 23, 36 do
                shift_reduce_table[i][j] = { ['action'] = ' Bad syntax...', ['state'] = nil,}
            end
        end

        --state 1
        shift_reduce_table[1][1] = { ['action'] = 'Shift', ['state'] = 3,} --terminal inicio
        shift_reduce_table[1][23] = { ['action'] = nil, ['state'] = 2,} --nonterminal P

        --state 2 --reduce state--
        shift_reduce_table[2][22] = { ['action'] = 'Accept', ['state'] = true,} -- terminal $

        --state 3
        shift_reduce_table[3][2] = { ['action'] = 'Shift', ['state'] = 5,} --terminal varinicio
        shift_reduce_table[3][24] = { ['action'] = nil, ['state'] = 4,} --nonterminal V

        --state 4
        shift_reduce_table[4][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[4][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[4][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[4][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[4][21] = { ['action'] = 'Shift', ['state'] = 10,} -- terminal fim
        shift_reduce_table[4][25] = { ['action'] = nil, ['state'] = 6,} --nonterminal A
        shift_reduce_table[4][29] = { ['action'] = nil, ['state'] = 7,} --nonterminal ES
        shift_reduce_table[4][31] = { ['action'] = nil, ['state'] = 8,} --nonterminal CMD
        shift_reduce_table[4][34] = { ['action'] = nil, ['state'] = 9,} --nonterminal COND
        shift_reduce_table[4][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO


        --state 5
        shift_reduce_table[5][3] = { ['action'] = 'Shift', ['state'] = 18,} --termial varfim
        shift_reduce_table[5][9] = { ['action'] = 'Shift', ['state'] = 19,} --termial id
        shift_reduce_table[5][26] = { ['action'] = nil, ['state'] = 16,} --nonterminal LV
        shift_reduce_table[5][27] = { ['action'] = nil, ['state'] = 17,} --nonterminal D

        --state 6 --reduce state--
        shift_reduce_table[6][22] = { ['action'] = 'Reduce', ['state'] = 2,} --termial $

        --state 7
        shift_reduce_table[7][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[7][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[7][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[7][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[7][21] = { ['action'] = 'Shift', ['state'] = 10,} -- terminal fim
        shift_reduce_table[7][25] = { ['action'] = nil, ['state'] = 20,} --nonterminal A
        shift_reduce_table[7][29] = { ['action'] = nil, ['state'] = 7,} --nonterminal ES
        shift_reduce_table[7][31] = { ['action'] = nil, ['state'] = 8,} --nonterminal CMD
        shift_reduce_table[7][34] = { ['action'] = nil, ['state'] = 9,} --nonterminal COND
        shift_reduce_table[7][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO

        --state 8
        shift_reduce_table[8][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[8][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[8][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[8][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[8][21] = { ['action'] = 'Shift', ['state'] = 10,} -- terminal fim
        shift_reduce_table[8][25] = { ['action'] = nil, ['state'] = 21,} --nonterminal A
        shift_reduce_table[8][29] = { ['action'] = nil, ['state'] = 7,} --nonterminal ES
        shift_reduce_table[8][31] = { ['action'] = nil, ['state'] = 8,} --nonterminal CMD
        shift_reduce_table[8][34] = { ['action'] = nil, ['state'] = 9,} --nonterminal COND
        shift_reduce_table[8][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO

        --state 9
        shift_reduce_table[9][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[9][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[9][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[9][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[9][21] = { ['action'] = 'Shift', ['state'] = 10,} -- terminal fim
        shift_reduce_table[9][25] = { ['action'] = nil, ['state'] = 22,} --nonterminal A
        shift_reduce_table[9][29] = { ['action'] = nil, ['state'] = 7,} --nonterminal ES
        shift_reduce_table[9][31] = { ['action'] = nil, ['state'] = 8,} --nonterminal CMD
        shift_reduce_table[9][34] = { ['action'] = nil, ['state'] = 9,} --nonterminal COND
        shift_reduce_table[9][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO

        --state 10 --reduce state--
        shift_reduce_table[10][22] = { ['action'] = 'Reduce', ['state'] = 30,} --termial $

        --state 11
        shift_reduce_table[11][9] = { ['action'] = 'Shift', ['state'] = 23,} -- terminal id

        --state 12
        shift_reduce_table[12][9] = { ['action'] = 'Shift', ['state'] = 27,} -- terminal id
        shift_reduce_table[12][11] = { ['action'] = 'Shift', ['state'] = 25,} -- terminal literal
        shift_reduce_table[12][12] = { ['action'] = 'Shift', ['state'] = 26,} -- terminal num
        shift_reduce_table[12][30] = { ['action'] = nil, ['state'] = 24,} --nonterminal ARG

        --state 13
        shift_reduce_table[13][13] = { ['action'] = 'Shift', ['state'] = 28,} -- terminal rcb

        --state 14
        shift_reduce_table[14][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[14][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[14][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[14][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[14][20] = { ['action'] = 'Shift', ['state'] = 58,} -- terminal fimse
        shift_reduce_table[14][29] = { ['action'] = nil, ['state'] = 30,} --nonterminal ES
        shift_reduce_table[14][31] = { ['action'] = nil, ['state'] = 31,} --nonterminal CMD
        shift_reduce_table[14][34] = { ['action'] = nil, ['state'] = 32,} --nonterminal COND
        shift_reduce_table[14][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO
        shift_reduce_table[14][37] = { ['action'] = nil, ['state'] = 29,} --nonterminal CORPO

        --state 15
        shift_reduce_table[15][16] = { ['action'] = 'Shift', ['state'] = 33,} -- terminal (

        --state 16 --reduce state
        shift_reduce_table[16][8] = { ['action'] = 'Reduce', ['state'] = 3,} --termial leia
        shift_reduce_table[16][9] = { ['action'] = 'Reduce', ['state'] = 3,} --termial id
        shift_reduce_table[16][10] = { ['action'] = 'Reduce', ['state'] = 3,} --termial escreva
        shift_reduce_table[16][15] = { ['action'] = 'Reduce', ['state'] = 3,} --termial se
        shift_reduce_table[16][21] = { ['action'] = 'Reduce', ['state'] = 3,} --termial fim

        --state 17
        shift_reduce_table[17][3] = { ['action'] = 'Shift', ['state'] = 18,} -- terminal varfim
        shift_reduce_table[17][9] = { ['action'] = 'Shift', ['state'] = 19,} -- terminal id
        shift_reduce_table[17][26] = { ['action'] = nil, ['state'] = 34,} --nonterminal LV
        shift_reduce_table[17][27] = { ['action'] = nil, ['state'] = 17,} --nonterminal D

        --state 18
        shift_reduce_table[18][4] = { ['action'] = 'Shift', ['state'] = 35,} -- terminal ;

        --state 19
        shift_reduce_table[19][5] = { ['action'] = 'Shift', ['state'] = 37,} -- terminal varfim
        shift_reduce_table[19][6] = { ['action'] = 'Shift', ['state'] = 38,} -- terminal varfim
        shift_reduce_table[19][7] = { ['action'] = 'Shift', ['state'] = 39,} -- terminal varfim
        shift_reduce_table[19][28] = { ['action'] = nil, ['state'] = 36,} --nonterminal TIPO

        --state 20 --reduce state--
        shift_reduce_table[20][22] = { ['action'] = 'Reduce', ['state'] = 10,} --termial $

        --state 21 --reduce state--
        shift_reduce_table[21][22] = { ['action'] = 'Reduce', ['state'] = 16,} --termial $

        --state 22 --reduce state--
        shift_reduce_table[22][22] = { ['action'] = 'Reduce', ['state'] = 22,} --termial $

        --state 23
        shift_reduce_table[23][4] = { ['action'] = 'Shift', ['state'] = 40,} -- terminal ;

        --state 24
        shift_reduce_table[24][4] = { ['action'] = 'Shift', ['state'] = 59,} -- terminal ;

        --state 25 --reduce state
        shift_reduce_table[25][4] = { ['action'] = 'Reduce', ['state'] = 13,} --termial ;

        --state 26 --reduce state
        shift_reduce_table[26][4] = { ['action'] = 'Reduce', ['state'] = 14,} --termial ;

        --state 27 --reduce state
        shift_reduce_table[27][4] = { ['action'] = 'Reduce', ['state'] = 15,} --termial ;

        --state 28
        shift_reduce_table[28][9] = { ['action'] = 'Shift', ['state'] = 43,} -- terminal id
        shift_reduce_table[28][12] = { ['action'] = 'Shift', ['state'] = 44,} -- terminal num
        shift_reduce_table[28][32] = { ['action'] = nil, ['state'] = 41,} --nonterminal LD
        shift_reduce_table[28][33] = { ['action'] = nil, ['state'] = 42,} --nonterminal OPRD

        --state 29 --reduce state
        shift_reduce_table[29][8] = { ['action'] = 'Reduce', ['state'] = 23,} --termial leia
        shift_reduce_table[29][9] = { ['action'] = 'Reduce', ['state'] = 23,} --termial id
        shift_reduce_table[29][10] = { ['action'] = 'Reduce', ['state'] = 23,} --termial escreva
        shift_reduce_table[29][15] = { ['action'] = 'Reduce', ['state'] = 23,} --termial se
        shift_reduce_table[29][20] = { ['action'] = 'Reduce', ['state'] = 23,} --termial fimse
        shift_reduce_table[29][21] = { ['action'] = 'Reduce', ['state'] = 23,} --termial fim

        --state 30
        shift_reduce_table[30][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[30][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[30][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[30][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[30][20] = { ['action'] = 'Shift', ['state'] = 58,} -- terminal fimse
        shift_reduce_table[30][29] = { ['action'] = nil, ['state'] = 30,} --nonterminal ES
        shift_reduce_table[30][31] = { ['action'] = nil, ['state'] = 31,} --nonterminal CMD
        shift_reduce_table[30][34] = { ['action'] = nil, ['state'] = 32,} --nonterminal COND
        shift_reduce_table[30][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO
        shift_reduce_table[30][37] = { ['action'] = nil, ['state'] = 45,} --nonterminal CORPO

        --state 31
        shift_reduce_table[31][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[31][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[31][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[31][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[31][20] = { ['action'] = 'Shift', ['state'] = 58,} -- terminal fimse
        shift_reduce_table[31][29] = { ['action'] = nil, ['state'] = 30,} --nonterminal ES
        shift_reduce_table[31][31] = { ['action'] = nil, ['state'] = 31,} --nonterminal CMD
        shift_reduce_table[31][34] = { ['action'] = nil, ['state'] = 32,} --nonterminal COND
        shift_reduce_table[31][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO
        shift_reduce_table[31][37] = { ['action'] = nil, ['state'] = 46,} --nonterminal CORPO

        --state 32
        shift_reduce_table[32][8] = { ['action'] = 'Shift', ['state'] = 11,} --terminal leia
        shift_reduce_table[32][9] = { ['action'] = 'Shift', ['state'] = 13,} --terminal id
        shift_reduce_table[32][10] = { ['action'] = 'Shift', ['state'] = 12,} --terminal escreva
        shift_reduce_table[32][15] = { ['action'] = 'Shift', ['state'] = 15,} -- terminal se
        shift_reduce_table[32][20] = { ['action'] = 'Shift', ['state'] = 58,} -- terminal fimse
        shift_reduce_table[32][29] = { ['action'] = nil, ['state'] = 30,} --nonterminal ES
        shift_reduce_table[32][31] = { ['action'] = nil, ['state'] = 31,} --nonterminal CMD
        shift_reduce_table[32][34] = { ['action'] = nil, ['state'] = 32,} --nonterminal COND
        shift_reduce_table[32][35] = { ['action'] = nil, ['state'] = 14,} --nonterminal CABEÇALHO
        shift_reduce_table[32][37] = { ['action'] = nil, ['state'] = 47,} --nonterminal CORPO

        --state 33
        shift_reduce_table[33][9] = { ['action'] = 'Shift', ['state'] = 43,} -- terminal id
        shift_reduce_table[33][12] = { ['action'] = 'Shift', ['state'] = 44,} -- terminal num
        shift_reduce_table[33][33] = { ['action'] = nil, ['state'] = 49,} --nonterminal OPRD
        shift_reduce_table[33][36] = { ['action'] = nil, ['state'] = 48,} --nonterminal EXP_R

        --state 34 --reduce state
        shift_reduce_table[34][8] = { ['action'] = 'Reduce', ['state'] = 4,} --termial leia
        shift_reduce_table[34][9] = { ['action'] = 'Reduce', ['state'] = 4,} --termial id
        shift_reduce_table[34][10] = { ['action'] = 'Reduce', ['state'] = 4,} --termial escreva
        shift_reduce_table[34][15] = { ['action'] = 'Reduce', ['state'] = 4,} --termial se
        shift_reduce_table[34][21] = { ['action'] = 'Reduce', ['state'] = 4,} --termial fim

        --state 35 --reduce state
        shift_reduce_table[35][8] = { ['action'] = 'Reduce', ['state'] = 5,} --termial leia
        shift_reduce_table[35][9] = { ['action'] = 'Reduce', ['state'] = 5,} --termial id
        shift_reduce_table[35][10] = { ['action'] = 'Reduce', ['state'] = 5,} --termial escreva
        shift_reduce_table[35][15] = { ['action'] = 'Reduce', ['state'] = 5,} --termial se
        shift_reduce_table[35][21] = { ['action'] = 'Reduce', ['state'] = 5,} --termial fim

        --state 36
        shift_reduce_table[36][4] = { ['action'] = 'Shift', ['state'] = 50,} --termial ;

        --state 37 --reduce state
        shift_reduce_table[37][4] = { ['action'] = 'Reduce', ['state'] = 7,} --termial ;

        --state 38 --reduce state
        shift_reduce_table[38][4] = { ['action'] = 'Reduce', ['state'] = 8,} --termial ;

        --state 39 --reduce state
        shift_reduce_table[39][4] = { ['action'] = 'Reduce', ['state'] = 9,} --termial ;

        --state 40 --reduce state
        shift_reduce_table[40][8] = { ['action'] = 'Reduce', ['state'] = 11,} --termial leia
        shift_reduce_table[40][9] = { ['action'] = 'Reduce', ['state'] = 11,} --termial id
        shift_reduce_table[40][10] = { ['action'] = 'Reduce', ['state'] = 11,} --termial escreva
        shift_reduce_table[40][15] = { ['action'] = 'Reduce', ['state'] = 11,} --termial se
        shift_reduce_table[40][20] = { ['action'] = 'Reduce', ['state'] = 11,} --termial fimse
        shift_reduce_table[40][21] = { ['action'] = 'Reduce', ['state'] = 11,} --termial fim

        --state 41
        shift_reduce_table[41][4] = { ['action'] = 'Shift', ['state'] = 51,} --termial ;

        --state 42 --reduce state
        shift_reduce_table[42][4] = { ['action'] = 'Reduce', ['state'] = 19,} --termial ;
        shift_reduce_table[42][14] = { ['action'] = 'Shift', ['state'] = 52,} --termial opm

        --state 43 --reduce state
        shift_reduce_table[43][4] = { ['action'] = 'Reduce', ['state'] = 20,} --termial ;
        shift_reduce_table[43][14] = { ['action'] = 'Reduce', ['state'] = 20,} --termial opm
        shift_reduce_table[43][17] = { ['action'] = 'Reduce', ['state'] = 20,} --termial )
        shift_reduce_table[43][19] = { ['action'] = 'Reduce', ['state'] = 20,} --termial opr

        --state 44 --reduce state
        shift_reduce_table[44][4] = { ['action'] = 'Reduce', ['state'] = 21,} --termial ;
        shift_reduce_table[44][14] = { ['action'] = 'Reduce', ['state'] = 21,} --termial opm
        shift_reduce_table[44][17] = { ['action'] = 'Reduce', ['state'] = 21,} --termial )
        shift_reduce_table[44][19] = { ['action'] = 'Reduce', ['state'] = 21,} --termial opr

        --state 45 --reduce state
        shift_reduce_table[45][8] = { ['action'] = 'Reduce', ['state'] = 26,} --termial leia
        shift_reduce_table[45][9] = { ['action'] = 'Reduce', ['state'] = 26,} --termial id
        shift_reduce_table[45][10] = { ['action'] = 'Reduce', ['state'] = 26,} --termial escreva
        shift_reduce_table[45][15] = { ['action'] = 'Reduce', ['state'] = 26,} --termial se
        shift_reduce_table[45][20] = { ['action'] = 'Reduce', ['state'] = 26,} --termial fimse
        shift_reduce_table[45][21] = { ['action'] = 'Reduce', ['state'] = 26,} --termial fim

        --state 46 --reduce state
        shift_reduce_table[46][8] = { ['action'] = 'Reduce', ['state'] = 27,} --termial leia
        shift_reduce_table[46][9] = { ['action'] = 'Reduce', ['state'] = 27,} --termial id
        shift_reduce_table[46][10] = { ['action'] = 'Reduce', ['state'] = 27,} --termial escreva
        shift_reduce_table[46][15] = { ['action'] = 'Reduce', ['state'] = 27,} --termial se
        shift_reduce_table[46][20] = { ['action'] = 'Reduce', ['state'] = 27,} --termial fimse
        shift_reduce_table[46][21] = { ['action'] = 'Reduce', ['state'] = 27,} --termial fim

        --state 47 --reduce state
        shift_reduce_table[47][8] = { ['action'] = 'Reduce', ['state'] = 28,} --termial leia
        shift_reduce_table[47][9] = { ['action'] = 'Reduce', ['state'] = 28,} --termial id
        shift_reduce_table[47][10] = { ['action'] = 'Reduce', ['state'] = 28,} --termial escreva
        shift_reduce_table[47][15] = { ['action'] = 'Reduce', ['state'] = 28,} --termial se
        shift_reduce_table[47][20] = { ['action'] = 'Reduce', ['state'] = 28,} --termial fimse
        shift_reduce_table[47][21] = { ['action'] = 'Reduce', ['state'] = 28,} --termial fim

        --state 48
        shift_reduce_table[48][17] = { ['action'] = 'Shift', ['state'] = 53,} --termial )

        --state 49
        shift_reduce_table[49][19] = { ['action'] = 'Shift', ['state'] = 54,} --termial opr

        --state 50 --reduce state
        shift_reduce_table[50][3] = { ['action'] = 'Reduce', ['state'] = 6,} --termial varfim
        shift_reduce_table[50][9] = { ['action'] = 'Reduce', ['state'] = 6,} --termial id

        --state 51 --reduce state
        shift_reduce_table[51][8] = { ['action'] = 'Reduce', ['state'] = 17,} --termial leia
        shift_reduce_table[51][9] = { ['action'] = 'Reduce', ['state'] = 17,} --termial id
        shift_reduce_table[51][10] = { ['action'] = 'Reduce', ['state'] = 17,} --termial escreva
        shift_reduce_table[51][15] = { ['action'] = 'Reduce', ['state'] = 17,} --termial se
        shift_reduce_table[51][20] = { ['action'] = 'Reduce', ['state'] = 17,} --termial fimse
        shift_reduce_table[51][21] = { ['action'] = 'Reduce', ['state'] = 17,} --termial fim

        --state 52
        shift_reduce_table[52][9] = { ['action'] = 'Shift', ['state'] = 43,} -- terminal id
        shift_reduce_table[52][12] = { ['action'] = 'Shift', ['state'] = 44,} -- terminal num
        shift_reduce_table[52][33] = { ['action'] = nil, ['state'] = 55,} --nonterminal OPRD

        --state 53
        shift_reduce_table[53][18] = { ['action'] = 'Shift', ['state'] = 56,} -- terminal entao

        --state 54
        shift_reduce_table[54][9] = { ['action'] = 'Shift', ['state'] = 43,} -- terminal id
        shift_reduce_table[54][12] = { ['action'] = 'Shift', ['state'] = 44,} -- terminal num
        shift_reduce_table[54][33] = { ['action'] = nil, ['state'] = 57,} --nonterminal OPRD

        --state 55 --reduce state
        shift_reduce_table[55][4] = { ['action'] = 'Reduce', ['state'] = 18,} --termial ;

        --state 56 --reduce state
        shift_reduce_table[56][8] = { ['action'] = 'Reduce', ['state'] = 24,} --termial leia
        shift_reduce_table[56][9] = { ['action'] = 'Reduce', ['state'] = 24,} --termial id
        shift_reduce_table[56][10] = { ['action'] = 'Reduce', ['state'] = 24,} --termial escreva
        shift_reduce_table[56][15] = { ['action'] = 'Reduce', ['state'] = 24,} --termial se
        shift_reduce_table[56][20] = { ['action'] = 'Reduce', ['state'] = 24,} --termial fimse

        --state 57 --reduce state
        shift_reduce_table[57][17] = { ['action'] = 'Reduce', ['state'] = 25,} --termial )

        --state 58 --reduce state
        shift_reduce_table[58][8] = { ['action'] = 'Reduce', ['state'] = 29,} --termial leia
        shift_reduce_table[58][9] = { ['action'] = 'Reduce', ['state'] = 29,} --termial id
        shift_reduce_table[58][10] = { ['action'] = 'Reduce', ['state'] = 29,} --termial escreva
        shift_reduce_table[58][15] = { ['action'] = 'Reduce', ['state'] = 29,} --termial se
        shift_reduce_table[58][20] = { ['action'] = 'Reduce', ['state'] = 29,} --termial fimse
        shift_reduce_table[58][21] = { ['action'] = 'Reduce', ['state'] = 29,} --termial fim

        --state 59 --reduce state
        shift_reduce_table[59][8] = { ['action'] = 'Reduce', ['state'] = 12,} --termial leia
        shift_reduce_table[59][9] = { ['action'] = 'Reduce', ['state'] = 12,} --termial id
        shift_reduce_table[59][10] = { ['action'] = 'Reduce', ['state'] = 12,} --termial escreva
        shift_reduce_table[59][15] = { ['action'] = 'Reduce', ['state'] = 12,} --termial se
        shift_reduce_table[59][20] = { ['action'] = 'Reduce', ['state'] = 12,} --termial fimse
        shift_reduce_table[59][21] = { ['action'] = 'Reduce', ['state'] = 12,} --termial fim

        return shift_reduce_table
    end,
    glc_grammar = function ()
        --cafe Language Context-Free Grammar
        local glc = {
            [1] = {
                ['symbol'] = 'S',
                ['production'] = {'P',},
            },
            [2] = {
                ['symbol'] = 'P',
                ['production'] = {'inicio', 'V', 'A',},
            },
            [3] = {
                ['symbol'] = 'V',
                ['production'] = {'varinicio', 'LV',},
            },
            [4] = {
                ['symbol'] = 'LV',
                ['production'] = {'D', 'LV',},
            },
            [5] = {
                ['symbol'] = 'LV',
                ['production'] = {'varfim', 'pt_v',},
            },
            [6] = {
                ['symbol'] = 'D',
                ['production'] = {'id', 'TIPO', 'pt_v',},
            },
            [7] = {
                ['symbol'] = 'TIPO',
                ['production'] = {'int',},
            },
            [8] = {
                ['symbol'] = 'TIPO',
                ['production'] = {'real',},
            },
            [9] = {
                ['symbol'] = 'TIPO',
                ['production'] = {'lit',},
            },
            [10] = {
                ['symbol'] = 'A',
                ['production'] = {'ES', 'A',},
            },
            [11] = {
                ['symbol'] = 'ES',
                ['production'] = {'leia', 'id', 'pt_v',},
            },
            [12] = {
                ['symbol'] = 'ES',
                ['production'] = {'escreva', 'ARG', 'pt_v',},
            },
            [13] = {
                ['symbol'] = 'ARG',
                ['production'] = {'literal',},
            },
            [14] = {
                ['symbol'] = 'ARG',
                ['production'] = {'num',},
            },
            [15] = {
                ['symbol'] = 'ARG',
                ['production'] = {'id',},
            },
            [16] = {
                ['symbol'] = 'A',
                ['production'] = {'CMD', 'A',},
            },
            [17] = {
                ['symbol'] = 'CMD',
                ['production'] = {'id', 'rcb', 'LD', 'pt_v',},
            },
            [18] = {
                ['symbol'] = 'LD',
                ['production'] = {'OPRD', 'opm', 'OPRD',},
            },
            [19] = {
                ['symbol'] = 'LD',
                ['production'] = {'OPRD',},
            },
            [20] = {
                ['symbol'] = 'OPRD',
                ['production'] = {'id',},
            },
            [21] = {
                ['symbol'] = 'OPRD',
                ['production'] = {'num',},
            },
            [22] = {
                ['symbol'] = 'A',
                ['production'] = {'COND', 'A',},
            },
            [23] = {
                ['symbol'] = 'COND',
                ['production'] = {'CABECALHO', 'CORPO',},
            },
            [24] = {
                ['symbol'] = 'CABECALHO',
                ['production'] = {'se', 'ab_p', 'EXP_R', 'fc_p', 'entao',},
            },
            [25] = {
                ['symbol'] = 'EXP_R',
                ['production'] = {'OPRD', 'opr', 'OPRD',},
            },
            [26] = {
                ['symbol'] = 'CORPO',
                ['production'] = {'ES', 'CORPO',},
            },
            [27] = {
                ['symbol'] = 'CORPO',
                ['production'] = {'CMD', 'CORPO',},
            },
            [28] = {
                ['symbol'] = 'CORPO',
                ['production'] = {'COND', 'CORPO',},
            },
            [29] = {
                ['symbol'] = 'CORPO',
                ['production'] = {'fimse',},
            },
            [30] = {
                ['symbol'] = 'A',
                ['production'] = {'fim',},
            },
        }
        return glc
    end,
    terminals_list = function ()
        --list with all the terminals of the grammar
        local glc = {
            [1] = 'inicio',
            [2] = 'varinicio',
            [3] = 'varfim',
            [4] = 'pt_v',
            [5] = 'int',
            [6] = 'real',
            [7] = 'lit',
            [8] = 'leia',
            [9] = 'id',
            [10] = 'escreva',
            [11] = 'literal',
            [12] = 'num',
            [13] = 'rcb',
            [14] = 'opm',
            [15] = 'se',
            [16] = 'ab_p',
            [17] = 'fc_p',
            [18] = 'entao',
            [19] = 'opr',
            [20] = 'fimse',
            [21] = 'fim',
            [22] = '$',
        }
        return glc
    end,
    nonterminals_list = function ()
        --list with all non-terminals of the grammar
        local glc = {
            [1] = 'P',
            [2] = 'V',
            [3] = 'A',
            [4] = 'LV',
            [5] = 'D',
            [6] = 'TIPO',
            [7] = 'ES',
            [8] = 'ARG',
            [9] = 'CMD',
            [10] = 'LD',
            [11] = 'OPRD',
            [12] = 'COND',
            [13] = 'CABECALHO',
            [14] = 'EXP_R',
            [15] = 'CORPO',
        }
        return glc
    end
}

return Syntactic_utils