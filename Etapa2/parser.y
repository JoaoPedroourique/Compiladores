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

%start programa

%%

// 3.1 Variaveis Globais

programa: decl { printf("Sucesso\n"); }
 	| func { printf("Funcao\n"); };

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

simple_command: decl_local';'
	| attribuition';'
	| input_op';'
	| output_op';'
	| func_call';'
	| return_op';'
	| break_op';'
	| continue_op';'
	| shift_op';';

// Declaracao de variavel local

decl_local: TK_PR_STATIC TK_PR_CONST type local_list
	| TK_PR_CONST type local_list
	| TK_PR_STATIC type local_list
	| type local_list
	| TK_PR_STATIC TK_PR_CONST type local_list TK_OC_LE value
	| TK_PR_CONST type local_list TK_OC_LE value
	| TK_PR_STATIC type local_list TK_OC_LE value
	| type local_list TK_OC_LE value;
	
value: TK_IDENTIFICADOR
	| literal;
	
literal: TK_LIT_INT 
	| TK_LIT_FLOAT 
	| TK_LIT_CHAR 
	| TK_LIT_FALSE
	| TK_LIT_TRUE 
	| TK_LIT_STRING;

local_list: TK_IDENTIFICADOR 
	| TK_IDENTIFICADOR',' local_list;


attribuition: estrutura '=' expression;

input_op: TK_PR_INPUT TK_IDENTIFICADOR;

output_op: TK_PR_OUTPUT TK_IDENTIFICADOR
	| TK_PR_OUTPUT literal;

return_op: TK_PR_RETURN expression;

break_op: TK_PR_BREAK;

continue_op: TK_PR_CONTINUE;

func_call: TK_IDENTIFICADOR'('params')';

params: param 
	| param',' params;
	
param: %empty
	| literal
	| TK_IDENTIFICADOR
	| expression;
	
shift_op: estrutura TK_OC_SL  TK_LIT_INT
	| estrutura TK_OC_SR  TK_LIT_INT;
	
//control_flow:

expression: arithmetic | logic;

arithmetic: TK_PR_WHILE;

logic: TK_PR_ELSE;

%%



