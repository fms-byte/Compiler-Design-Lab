/*definition section*/
%{
	#include<stdio.h>
	int single_comment=0;
	int multi_line_comment=0;
	int others = 0;
	int flag = 0;
	
%}

/*Rules Section*/
%%

"/*"([^*]|\*+[^*/])*\*+"/" {
	multi_line_comment++;
	fprintf(yyout, "%s --> is Multi line comment\n", yytext);
}


[/][/].*"\n" {
	if(flag==0)
	{
		single_comment++; 
		fprintf(yyout, "%s --> is Single line comment\n", yytext);
	}
}

.* {others++;}

%%

/*main section*/
int main()
{
	//Regex: It should begin with /* and end with /.
	//There can le any of of *s but should not have */.[^] tells no *s allowed but its already accounted by the *+ on the left.
	//Hence new line would be recognized by this */

	yyin = fopen("input.c","r");
	//yyout = fopen("output.txt","w");

	yylex();

	fprintf(yyout, "Single line comment: %d\n",single_comment);
	fprintf(yyout, "Multi line comment: %d\n",multi_line_comment);
	return 0;
}
int yywrap()
{
	return 1;
}
