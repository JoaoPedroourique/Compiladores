%{
#include "parser.tab.h"
int cur_line = 1;
int yyerror (char const *s) {
fprintf (stderr, "%s in line %d\n", s, cur_line);
return yyparse();
}
%}

%option noyywrap
white [ \t]+
especiais [,;:\(\)\[\]\{\}+\-|*/<>=!&%#\^.$]
linebreak [\r\n|\r|\n]
identifier [a-zA-Z_][a-zA-Z0-9_]*
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer}){exponent}?
character "'".{1}"'"
stringliteral "\"".*"\""
singlelinecomment \/\/.*
multiplelinecomment \/\*(.|{linebreak})*\*\/

%%

{singlelinecomment} { }
{multiplelinecomment} { 
    for(int i = 0; i < yyleng; i++) { 
        if(yytext[i] == '\n') {
            cur_line += 1;
            }
        }
}
">>" { return TK_OC_SL;}
"<<" { return TK_OC_SR;}
"==" { return TK_OC_EQ;}
"!=" { return TK_OC_NE;}
"<=" { return TK_OC_LE;}
">=" { return TK_OC_GE;}
"&&" { return TK_OC_AND;}
"||" { return TK_OC_OR;}
{especiais} { return *yytext; }
{white} { }
{linebreak} { cur_line += 1; }
{integer} { return TK_LIT_INT;}
{real} { return TK_LIT_FLOAT;}
true { return TK_LIT_TRUE;}
false { return TK_LIT_FALSE;}
{character} { return TK_LIT_CHAR;}
{stringliteral} { return TK_LIT_STRING;}
int { return TK_PR_INT; }
float { return TK_PR_FLOAT; }
bool { return TK_PR_BOOL; }
char { return TK_PR_CHAR; }
string { return TK_PR_STRING; }
if { return TK_PR_IF; }
then { return TK_PR_THEN; }
else { return TK_PR_ELSE; }
while { return TK_PR_WHILE; }
do { return TK_PR_DO; }
input { return TK_PR_INPUT; }
output { return TK_PR_OUTPUT; }
return { return TK_PR_RETURN; }
const { return TK_PR_CONST; }
static { return TK_PR_STATIC; }
foreach { return TK_PR_FOREACH; }
for { return TK_PR_FOR; }
switch { return TK_PR_SWITCH; }
case { return TK_PR_CASE; }
break { return TK_PR_BREAK; }
continue { return TK_PR_CONTINUE; }
class { return TK_PR_CLASS; }
private { return TK_PR_PRIVATE; }
public { return TK_PR_PUBLIC; }
protected { return TK_PR_PROTECTED; }
end { return TK_PR_END; }
default { return TK_PR_DEFAULT; }
{identifier} { return TK_IDENTIFICADOR; }
. return TOKEN_ERRO;
%%
