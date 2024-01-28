/*definition part*/
%{
	#include<stdio.h>
	int integer=0;
	int floating=0;
	int exponential=0;
	int others=0;
%}

/*Rules Part*/
%%

[+-]?[0-9]+ {
	integer++; 
	fprintf(yyout, "'%s' is an Integer\n", yytext);
}

[+-]?[0-9]*"."[0-9]+ {
	floating++; 
	fprintf(yyout, "'%s' is a Floating Number\n", yytext);
}

[+-]?[0-9]+[Ee][-+]?[0-9]+ {
	exponential++; 
	fprintf(yyout, "%s is an Exponentital\n", yytext);
}

. {others++;}
%%

/*Main part*/
int main()
{
	yyin=fopen("input.c","r");
	//yyout=fopen("output.txt","w");
	
	yylex();

	fprintf(yyout, "Integer number: %d\n", integer);
	fprintf(yyout, "Floating number: %d\n", floating);
	fprintf(yyout, "Exponential number: %d\n", exponential);
		
	return 0;
}
int yywrap()
{
	return 1;
}
