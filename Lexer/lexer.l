%{
    #include <stdio.h>
    #include <stdbool.h>
    #include <stdlib.h>
    #include <string.h>
    int others = 0;
    int keyword = 0;
    int identifier = 0;
    int space = 0;
    int line = 0;
    int single_comment = 0;
    int multi_comment = 0;
    int flag = 0;
    int key = 0;
    int operator = 0;
    int decimal = 0;
    int exponent = 0;
    int floating = 0;
    bool isKeyword(char* str);
%}

%option noyywrap

%%
include {key++;}

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"stdio.h"|"conio.h"|"printf"|"scanf"|"main" {
  printf("Token: Keyword, Value: %s\n", yytext);
  keyword++;
}

"/*" {
    if(flag==0) flag = 1;
}

"*/" {
    if(flag==1) flag = 0;
    multi_comment++;
}

"//".*"\n" {
    if(flag==0) single_comment++;
}

[a-zA-Z_][a-zA-Z0-9_]* {
  if (isKeyword(yytext)) {
    printf("Token: Keyword, Value: %s\n", yytext);
    keyword++;
  } else {
    printf("Token: Identifier, Value: %s\n", yytext);
    identifier++;
  }
}

"+"|"-"|"*"|"/"|"%"|"="|"=="|"<="|">="|"<"|">"|"&"|"|"|"&&"|"||" {
    if(flag==0){
      printf("Token: Operator, Value: %s\n", yytext);
      operator++;
    }
}

[+-]?[0-9]+ {
    if(flag==0){
        printf("Token: Integer Number, Value: %s\n", yytext);
        decimal++;
    }
}

[+-]?[0-9]*"."[0-9]+ {
    if(flag==0){
        printf("Token: Floating Number, Value: %s\n", yytext);
        floating++;
    }
}

[+-]?[0-9]+[Ee][-+]?[0-9]+ {
    if(flag==0){
        printf("Token: Exponential Number, Value: %s\n", yytext);
        exponent++;
    }
}

" " {
    printf("Token: White Space, Value: %s\n", yytext);
    space++;
}

"\n" {
    printf("Token: New Line, Value: %s\n", yytext);
    line++;
}

. {
  printf("Token: Unidentified, Value: %s\n", yytext);
  others++;
}

%%

bool isKeyword(char* str) {
  const char* keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "int", "long", "register", "return", "short", "signed", "sizeof", "static",
    "struct", "main", "switch", "typedef", "union", "unsigned", "void", "volatile", "while","stdio.h","conio.h","printf","scanf","include"
  };
  for (int i = 0; i < sizeof(keywords) / sizeof(keywords[0]); i++) {
    if (strcmp(str, keywords[i]) == 0) {
      return true;
    }
  }
  return false;
}
int main() {
  FILE *file = fopen("input.txt", "r");
  if (!file) {
    fprintf(stderr, "Error opening file\n");
    return 1;
  }

  yyin = file;
  yylex();

  fclose(file);

  printf("\nTotal Keywords: %d\n", keyword+(key*2));
  printf("Total Identifiers: %d\n", identifier);
  printf("Total Integers: %d\n", decimal);
  printf("Total Floats: %d\n",  floating);
  printf("Total Exponential: %d\n", exponent);
  printf("Total Operators: %d\n", operator-(2*key));
  printf("Total Single Line Comment: %d\n", single_comment);
  printf("Total Multi-line Comment: %d\n", multi_comment);
  printf("Total Space: %d\n", space);
  printf("Total New Line: %d\n", line);
  printf("Total Unidentified: %d\n", others);

  return 0;
}


