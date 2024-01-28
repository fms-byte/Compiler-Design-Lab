/*Definition Section*/
%{
	#include<stdio.h>
	int ch=0;
	int word=0;
	int space=0;
	int line=0;
	int others = 0;
%}

/*Rules Section*/
%%

[a-zA-Z] {
	ch++; 
	fprintf(yyout, "['%s' is a Character] ", yytext);
}

[a-zA-Z]+ {
	word++; 
	fprintf(yyout, "['%s' is a Word] ", yytext);
}

" " {
	space++; 
	fprintf(yyout, "[Space] ", yytext);
}

"\n" {
	line++; 
	fprintf(yyout, "[A New line]\n\n");
}

. { others++; }

%%

/*Main Section*/
int main()
{
	yyin = fopen("input.c","r");
	//yyout = fopen("output.txt","w");
	yylex();
	fprintf(yyout, "Char: %d\nWord: %d\nSpace: %d\nLine: %d", ch, word, space, line);
	return 0;
}
int yywrap()
{
	return 1;
}
