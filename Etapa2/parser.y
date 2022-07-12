%{
#include <stdio.h>
int yylex(void);
void yyerror (char const *s);
%}
%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_CHAR
%token TK_PR_STRING
%token TK_PR_IF
%token TK_PR_THEN
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_DO
%token TK_PR_INPUT
%token TK_PR_OUTPUT
%token TK_PR_RETURN
%token TK_PR_CONST
%token TK_PR_STATIC
%token TK_PR_FOREACH
%token TK_PR_FOR
%token TK_PR_SWITCH
%token TK_PR_CASE
%token TK_PR_BREAK
%token TK_PR_CONTINUE
%token TK_PR_CLASS
%token TK_PR_PRIVATE
%token TK_PR_PUBLIC
%token TK_PR_PROTECTED
%token TK_PR_END
%token TK_PR_DEFAULT
%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_OC_SL
%token TK_OC_SR
%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_LIT_CHAR
%token TK_LIT_STRING
%token TK_IDENTIFICADOR
%token TOKEN_ERRO
%define parse.lac full
%define parse.error detailed
%right '&'
%right '#'
%right '*'

%start programa

%%

programa: %empty
	| decl programa { printf("Sucesso\n"); }
 	| func programa { printf("Funcao\n"); };

// 3.1 Variaveis Globais

decl: TK_PR_STATIC type list
	| type list;

estrutura: TK_IDENTIFICADOR'['TK_LIT_INT']' 
	| TK_IDENTIFICADOR;
	
type: TK_PR_INT 
	| TK_PR_FLOAT 
	| TK_PR_CHAR 
	| TK_PR_BOOL 
	| TK_PR_STRING;

list: estrutura';' 
	| estrutura',' list;


// 3.2 e 3.3 Funcoes e blocos de comando

func: TK_PR_STATIC func_aux
    |  func_aux;

func_aux: type TK_IDENTIFICADOR'('param_list')' command_block;

param_list: %empty
    | func_param
    | func_param',' param_list;

func_param: TK_PR_CONST type TK_IDENTIFICADOR
    | type TK_IDENTIFICADOR;

command_block: '{'command_list'}';

command_list: %empty
    | simple_command command_list;

// 3.4 Comandos simples

simple_command: local_decl';'
	| attribution';'
	| input_op';'
	| output_op';'
	| func_call';'
	| return_op';'
	| break_op';'
	| continue_op';'
	| shift_op';'
	| cond_flow';'
	| iter_flow';';

// Declaracao de variavel local

local_decl: TK_PR_STATIC TK_PR_CONST type local_list
	| TK_PR_CONST type local_list
	| TK_PR_STATIC type local_list
	| type local_list;
	
value: TK_IDENTIFICADOR
	| literal;
	
literal: literal_numeric
	| literal_alphabetic
	| literal_boolean;
	
literal_numeric: TK_LIT_INT 
	| TK_LIT_FLOAT; 
	
literal_alphabetic: TK_LIT_CHAR
	| TK_LIT_STRING;

literal_boolean: TK_LIT_FALSE
	| TK_LIT_TRUE;

local_list: local_decl_aux local_list_aux;

local_list_aux: %empty 
	| ',' local_decl_aux local_list_aux;

local_decl_aux: TK_IDENTIFICADOR
	| TK_IDENTIFICADOR TK_OC_LE value

// Comando de Atribuicao

attribution: estrutura '=' expression;

// Comandos de entrada e saida

input_op: TK_PR_INPUT TK_IDENTIFICADOR;

output_op: TK_PR_OUTPUT TK_IDENTIFICADOR
	| TK_PR_OUTPUT literal;

// Chamada de funcao

func_call: TK_IDENTIFICADOR'('params')';

params: param 
	| param',' params;
	
param: %empty
	| literal_alphabetic
	| literal_boolean
	| expression;

// Comando de Retorno, Break, Continue

return_op: TK_PR_RETURN expression;

break_op: TK_PR_BREAK;

continue_op: TK_PR_CONTINUE;

// Comandos de shift
	
shift_op: estrutura TK_OC_SL  TK_LIT_INT
	| estrutura TK_OC_SR  TK_LIT_INT;
	
// 3.5 Expr. aritmeticas, logicas

expression: arithmetic 
	| logic
	| ternary;

arithmetic: arithmetic_operand {printf("bunda");}
	| un_arithmetic_operator arithmetic_operand
	| un_arithmetic_operator arithmetic_operand bin_arithmetic_operator arithmetic
	| arithmetic_operand bin_arithmetic_operator arithmetic
	| '(' arithmetic ')' {printf("cu");};

arithmetic_operand: estrutura
	| literal_numeric
	| func_call;
	
bin_arithmetic_operator: '+'
	| '-'
	| '*'
	| '/'
	| '%'
	| '^';

un_arithmetic_operator: '+'
	| '-'
	| '&'
	| '*'
	| '#';
	
un_logic_operator: '!'
	| '?';
	
bin_logic_operator: '|'
	| '&'
	| '|''|'
	| '&''&';
	
relational_op: TK_OC_LE
	| TK_OC_EQ
	| TK_OC_GE
	| TK_OC_NE
	| '>'
	| '<';

ternary: arithmetic '?' arithmetic ':' arithmetic
	| logic '?' arithmetic ':' arithmetic
	| logic '?' logic ':' arithmetic;

logic: arithmetic relational_op arithmetic
	| un_logic_operator arithmetic_operand logic
	| arithmetic_operand bin_logic_operator arithmetic_operand logic;

// Comandos de controle de fluxo

cond_flow: TK_PR_IF '(' expression')' command_block
	| TK_PR_IF '(' expression')' command_block TK_PR_ELSE command_block;

iter_flow: TK_PR_FOR '(' attribution ':' expression ':' attribution')' command_block
	| TK_PR_WHILE '(' expression')' TK_PR_DO command_block;
%%



