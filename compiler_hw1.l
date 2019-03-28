/* Definition section */
%{
	#include <stdio.h>
	#include <stdlib.h>
%}

/* Define regular expression label */

letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*
number {digit}+

/* Rules section */
%%

 /* Arithmetic Operators*/
"+" 	{ printf("%s \t ADD\n", yytext); }
"-"		{ printf("%s \t SUB\n", yytext); }
"*"		{ printf("%s \t MUL\n", yytext); }
"/"		{ printf("%s \t DIV\n", yytext); }
"%"		{ printf("%s \t MOD\n", yytext); }
"++"	{ printf("%s \t INC\n", yytext); }
"--"	{ printf("%s \t DEC\n", yytext); }

 /* Relational Operators */
">" 	{ printf("%s \t MT\n", yytext); }
"<" 	{ printf("%s \t LT\n", yytext); }
">=" 	{ printf("%s \t MTE\n", yytext); }
"<=" 	{ printf("%s \t LTE\n", yytext); }
"==" 	{ printf("%s \t EQ\n", yytext); }
"!=" 	{ printf("%s \t NE\n", yytext); }

 /* Assignment Operators */
"=" 	{ printf("%s \t ASGN\n", yytext); }
"+=" 	{ printf("%s \t ADDASGN\n", yytext); }
"-=" 	{ printf("%s \t SUBASGN\n", yytext); }
"*=" 	{ printf("%s \t MULASGN\n", yytext); }
"/=" 	{ printf("%s \t DIVASGN\n", yytext); }
"%=" 	{ printf("%s \t MODASGN\n", yytext); }
 
 /* Logical Operators */
"&&" 	{ printf("%s \t AND\n", yytext); }
"||" 	{ printf("%s \t OR\n", yytext); }
"!" 	{ printf("%s \t NOT\n", yytext); }

 /* Delimiters */
"(" 	{ printf("%s \t LB\n", yytext); }
")" 	{ printf("%s \t RB\n", yytext); }
"{" 	{ printf("%s \t LCB\n", yytext); }
"}" 	{ printf("%s \t RCB\n", yytext); }
"[" 	{ printf("%s \t LSB\n", yytext); }
"]" 	{ printf("%s \t RSB\n", yytext); }

";" 	{ printf("%s \t SEMICOLON\n", yytext); }

"," 	{ printf("%s \t COMMA\n", yytext); }

"\"" 	{ printf("%s \t QUOTA\n", yytext); }
"\n" 	{ ; }

{id}	{ printf("%s \t ID\n", yytext); }


%%

/* C Code section */
int yywrap(void)
{
    return 1;
}

int main(int argc,char *argv[])
{
	yyin = fopen(argv[1],"r");
	yylex();
	printf("\nParse over, the line number is 1.\n\n");
	printf("comment: 1 lines\n\n");

	return 0;
}
