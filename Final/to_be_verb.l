/* Definition Section */
%{
	#include<stdio.h>
	int flag = 0;
%}

/*Rules Section */
%%

is|am|are|was|were|be|been|being  { flag = 1; }
.  {}
\n { return 0; }

%%

int main()
{
	FILE *fp = fopen("sentence.txt", "r");
    if (fp == NULL) {
        printf("Error opening file!\n");
        return 1;
    }

    char buffer[1000];

    while (fgets(buffer, sizeof(buffer), fp)) { 
        flag = 0;
        yy_scan_string(buffer);
        yylex();

        if(flag == 1)
		printf("It is a 'to be' verb sentence: %s", buffer);
	else
		printf("It is not a 'to be' verb sentence: %s", buffer);
    }
}

int yywrap( )
{
	return 1;
}
