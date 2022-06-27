%{
#include "tokens.h"
int cur_line = 1;
%}

%option noyywrap
white [ \t]+
especiais [,;:\(\)\[\]\{\}+\-|*/<>=!&%#\^.$]
linebreak [\r\n|\r|\n]
int ^[i][n][t]$
float ^[f][l][o][a][t]$
bool ^[b][o][o][l]$
char ^[c][h][a][r]$
string ^[s][t][r][i][n][g]$
if ^[i][f]$
then ^[t][h][e][n]$
else ^[e][l][s][e]$
while ^[w][h][i][l][e]$
do ^[d][o]$
input ^[i][n][p][u][t]$
output ^[o][u][t][p][u][t]$
return ^[r][e][t][u][r][n]$
const ^[c][o][n][s][t]$
static ^[s][t][a][t][i][c]$
foreach ^[f][o][r][e][a][c][h]$
for ^[f][o][r]$
switch ^[s][w][i][t][c][h]$
case ^[c][a][s][e]$
break ^[b][r][e][a][k]$
continue ^[c][o][n][t][i][n][u][e]$
class ^[c][l][a][s][s]$
private ^[p][r][i][v][a][t][e]$
public ^[p][u][b][l][i][c]$
protected ^[p][r][o][t][e][c][t][e][d]$
end ^[e][n][d]$
default ^[d][e][f][a][u][l][t]$
identifier ^[a-zA-Z_][a-zA-Z0-9_]*$
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?

%%

(^[>][>]$) { return TK_OC_SL;}
{especiais} { return *yytext; }
{white} { }
{linebreak} { printf("Linha quebrada %d \n", cur_line); cur_line += 1; }
{int} { return TK_PR_INT; }
{float} { return TK_PR_FLOAT; } 
{bool} { return TK_PR_BOOL; } 
{char} { return TK_PR_CHAR; } 
{string} { return TK_PR_STRING; } 
{if} { return TK_PR_IF; } 
{then} { return TK_PR_THEN; } 
{else} { return TK_PR_ELSE; } 
{while} { return TK_PR_WHILE; } 
{do} { return TK_PR_DO; } 
{input} { return TK_PR_INPUT; } 
{output} { return TK_PR_OUTPUT; } 
{return} { return TK_PR_RETURN; } 
{const} { return TK_PR_CONST; } 
{static} { return TK_PR_STATIC; } 
{foreach} { return TK_PR_FOREACH; } 
{for} { return TK_PR_FOR; } 
{switch} { return TK_PR_SWITCH; } 
{case} { return TK_PR_CASE; } 
{break} { return TK_PR_BREAK; } 
{continue} { return TK_PR_CONTINUE; } 
{class} { return TK_PR_CLASS; } 
{private} { return TK_PR_PRIVATE; } 
{public} { return TK_PR_PUBLIC; } 
{protected} { return TK_PR_PROTECTED; } 
{end} { return TK_PR_END; } 
{default} { return TK_PR_DEFAULT; } 
{identifier} { return TK_IDENTIFICADOR; }
. return TOKEN_ERRO;
%%