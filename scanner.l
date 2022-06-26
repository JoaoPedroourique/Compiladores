%{
#include "tokens.h"
int cur_line = 1;
%}

%option noyywrap
especiais [,;:\(\)\[\]\{\}+\-|*/<>=!&%#\^.$]
linebreak [\r\n]
int [\b(int)\b]
float [\b(float)\b]
bool [\b(bool)\b]
char [\b(char)\b]
string [\b(string)\b]
if [\b(if)\b]
then [\b(then)\b]
else [\b(else)\b]
while [\b(while)\b]
do [\b(do)\b]
input [\b(input)\b]
output [\b(output)\b]
return [\b(return)\b]
const [\b(const)\b]
static [\b(static)\b]
foreach [\b(foreach)\b]
for [\b(for)\b]
switch [\b(switch)\b]
case [\b(case)\b]
break [\b(break)\b]
continue [\b(continue)\b]
class [\b(class)\b]
private [\b(private)\b]
public [\b(public)\b]
protected [\b(protected)\b]
end [\b(end)\b]
default [\b(default)\b]
identifier [a-zA-Z_][a-zA-Z_0-9_]*
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?

%%


{especiais} { return *yytext; }
linebreak { printf("Linha quebrada %d \n", cur_line); cur_line += 1; }
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
identifier { return TK_IDENTIFICADOR; }
. return TOKEN_ERRO;
%%