%{
#include <stdio.h>
#include<string.h>
int integer_count = 0;
int float_count = 0;
%}

%%
[0-9]+                    { integer_count++; }
[0-9]+"."[0-9]+           { float_count++; }

.                         { /* ignore other characters */ }
%%

int yywrap(void){}

int main() {
    yylex();
    printf("Integer count: %d\n", integer_count);
    printf("Float count: %d\n", float_count);

    return 0;
}
