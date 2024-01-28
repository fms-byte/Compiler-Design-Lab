/* Definition Section */
%{
	#include<stdio.h>
	int others = 0;
	int keyword = 0;
	int id = 0;
%}

/*Rules Section*/
%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"string"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"stdio.h"|"conio.h"|"string.h"|"printf"|"scanf"|"main"|"include" {
keyword++;
//fprintf(yyout, "%s is keyword\n", yytext);
printf("'%s' is Keyword\n", yytext);
}

[A-Za-z­_][a-zA-Z0-9_]* {
id++; 
//fprintf(yyout, "%s is identifier\n", yytext);
printf("'%s' is Identifier\n", yytext);
}

. {others++;}

%%

/* Main Section. 
"int"|"double"|"float"|"char"|"do"|"while"|"main"|"return"|"printf"|"scanf"|"include"|"stdio.h" */
int main()
{
	/* yyin and yyout as pointer of File type */
	extern FILE *yyin, *yyout;
 	
	/* yyin points to the file input.c and opens it in read mode*/
	yyin = fopen("input.c", "r");
	
	/* yyout points to the file output.txt and opens it in write mode*/
	//yyout = fopen("output.txt", "w");

	yylex();
	//fprintf(yyout, "Number of identifier is %d\n", id);	
	//fprintf(yyout, "Number of keywords is %d\n", keyword);
	printf("Number of keywords: %d\n", keyword);
	printf("Number of identifier: %d\n", id);

	return 0;
}
int yywrap()
{
	return 1;
}
