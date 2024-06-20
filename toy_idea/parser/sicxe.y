%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%token EOL ADD SUB ADDR SUBR
%token PLUS MINUS MULTIPLY DIVIDE EQUALS

%%

program:
    lines
    ;

lines:
    lines line
    | /* empty */
    ;

line:
    instruction EOL
    | error EOL { yyerrok; }
    ;

instruction:
    IDENTIFIER EQUALS expression { printf("Assignment: %s = %d\n", $1, $3); }
    | operation
    ;

operation:
    ADD { printf("Operation: ADD\n"); }
    | SUB { printf("Operation: SUB\n"); }
    | ADDR { printf("Operation: ADDR\n"); }
    | SUBR { printf("Operation: SUBR\n"); }
    ;

expression:
    term
    | expression PLUS term { $$ = $1 + $3; }
    | expression MINUS term { $$ = $1 - $3; }
    ;

term:
    factor
    | term MULTIPLY factor { $$ = $1 * $3; }
    | term DIVIDE factor { $$ = $1 / $3; }
    ;

factor:
    NUMBER
    | IDENTIFIER { $$ = lookup_symbol($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int lookup_symbol(char *s) {
    // This is a placeholder. Implement symbol lookup here.
    return 0;
}

int main(void) {
    return yyparse();
}
