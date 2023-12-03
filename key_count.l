%{
#include <stdio.h>
#include<string.h>
int identifier_count = 0;
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*    { identifier_count++; }

.                         { /* ignore other characters */ }
%%

int yywrap(void){}

int main() {
    yylex();
    printf("Identifier count: %d\n", identifier_count);

    return 0;
}
