# Compilador em Lua
Trabalho acadêmico feito durante a matéria de Compiladores do curso de Ciência da Computação pela Universidade Federal de Goiás.

Informações do projeto:

* Compilador implementado na linguagem de programação lua, onde interpreta uma linguagem escrita em mgol e converte para linguagem c.

* Gramática livre de contexto da linguagem mgol:
  * S -> P
  * P -> inicio V A
  * V -> varinicio LV
  * LV -> D LV
  * LV -> varfim;
  * D -> id TIPO;
  * TIPO -> int
  * TIPO -> real
  * TIPO -> lit
  * A -> ES A
  * ES -> leia id;
  * ES -> escreva ARG;
  * ARG -> literal
  * ARG -> num
  * ARG -> id
  * A -> CMD A
  * CMD -> id rcb LD;
  * LD -> OPRD opm OPRD
  * LD -> OPRD
  * OPRD -> id
  * OPRD -> num
  * A -> COND A
  * COND -> CABEÇALHO CORPO
  * CABEÇALHO -> se (EXP_R) entao
  * EXP_R -> OPRD opr OPRD
  * CORPO -> ES CORPO
  * CORPO -> CMD CORPO
  * CORPO -> COND CORPO
  * CORPO -> fimse
  * A -> fim
  
* O projeto foi dividido em três fases: Analisador léxico, Analisador sintático e Analisador semântico.
  * Analisador léxico: Foi implementado o DFA (autômato finito deterministico) da linguagem mgol e realizada a identificação de todos os lexemas, definindo sus respectivos token e tipo.
  * Analisador sintático: Foi implementado o autômato LR(0) e a tabela Shift/Reduce a partir deste para realizar a análise em uma abordagem Bottom-Up.
  * Analisador semântico: Ainda não implementado...
