%{
#include "y.tab.h"
%}

%%

[ \t]+          ;                   // Ignore whitespace
\n              { return EOL; }     // End of line
[A-Za-z][A-Za-z0-9]*   { yylval.sval = strdup(yytext); return IDENTIFIER; }
[0-9]+          { yylval.ival = atoi(yytext); return NUMBER; }
'+'             { return PLUS; }
'-'             { return MINUS; }
'*'             { return MULTIPLY; }
'/'             { return DIVIDE; }
'='             { return EQUALS; }
"ADD"           { return ADD; }
"SUB"           { return SUB; }
"ADDR"          { return ADDR; }
"SUBR"          { return SUBR; }
"LDA"
"LDX"
"STA"
"STX"
"MUL"
"DIV"
"COMP"
"JLE"
"JGT"



// Add more SIC/XE instructions here

.               { fprintf(stderr, "Unexpected character: %s\n", yytext); return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
