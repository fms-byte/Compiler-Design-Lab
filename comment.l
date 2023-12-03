%{
#include <stdio.h>
#include<string.h>
int comment_count = 0;
%}

%%
"/*"[a-zA-Z0-9\n\t ]*"*/" { comment_count++; }
"//"[a-zA-Z0-9\t ]*"\n"   { comment_count++; }

.                         { /* ignore other characters */ }
%%

int yywrap(void){}

int main() {
    yylex();
    printf("Comment count: %d\n", comment_count);

    return 0;
}
