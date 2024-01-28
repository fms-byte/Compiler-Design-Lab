/* Definition Section */
%{
	#include<stdio.h>
	int flag=0;
%}

/*Rules Section */
%%

and|or|but|if|then|nevertheless  { flag=1; }
although|Although|because|Because|before|Before|even|Even|though|Though|if|If|since|Since|until|Until|when|When { flag=2; }
.  { }
\n { }

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

        if (flag == 0) {
            printf("This is a Simple sentence: %s", buffer);
        } else if (flag == 1) {
            printf("This is a Compound sentence: %s", buffer);
        } else {
            printf("This is a Complex sentence: %s", buffer);
        }
    }

    fclose(fp);
    return 0;
}

int yywrap( )
{
	return 1;
}
