/*Definition part*/
%{
	#include<stdio.h>
	int bl = 0;
	int gp = 0;
	int robi = 0;
	int air = 0;
	int tele = 0;
	int others = 0;
%}

/*Rules part*/
%%

"019"[0-9]+ {
	bl++;
	fprintf(yyout, "%s is a Banglalink number\n", yytext);
}
"01"[7|3][0-9]+ {
	gp++;
	fprintf(yyout, "%s is a Grameen number\n", yytext);
}
"018"[0-9]+ {
	robi++;
	fprintf(yyout, "%s is a Robi number\n", yytext);
}
"016"[0-9]+ {
	air++;
	fprintf(yyout, "%s is an Airtel number\n", yytext);
}
"015"[0-9]+ {
	tele++;
	fprintf(yyout, "%s is a Teletalk number\n", yytext);
}

[ \n\t] {others++;}
. {others++;}
%%

/*main part*/
int main()
{
	yyin=fopen("demo.txt","r");
	//yyout = fopen("output.txt","w");

	yylex();
	printf("Banglalink Number: %d\n", bl);
	printf("Grameen Number: %d\n", gp);
	printf("Robi Number: %d\n", robi);
	printf("Airtel Number: %d\n", air);
	printf("Teletalk Number: %d\n", tele);

	return 0;
}
int yywrap()
{
	return 1;
}
