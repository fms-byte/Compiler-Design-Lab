%{
	#include <stdio.h>
	int v = 0;
	int other=0;
%}

%%

"Am"|"Is"|"Are"|"Was"|"Were"|"Be"|"Been"|"Being" {
	v++;
	printf("Found 'to be' verb: %s\n", yytext);
}

[" "]"am"|"is"|"are"|"was"|"were"|"be"|"been"|"being" {
	v++;
	printf("Found 'to be' verb: %s\n", yytext);
}

. {other++;}
%%

int main()
{
	/* yyin and yyout as pointer of File type */
	extern FILE *yyin, *yyout;
 	
	/* yyin points to the file input.c and opens it in read mode*/
	yyin = fopen("sentex.txt", "r");
	
	/* yyout points to the file output.txt and opens it in write mode*/
	//yyout = fopen("output.txt", "w");

	yylex();
	//fprintf(yyout, "Number of verb is %d\n", v);	
	printf("Number of verb: %d\n", v);

	return 0;
}
int yywrap()
{
	return 1;
}