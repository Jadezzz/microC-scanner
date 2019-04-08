/* Definition section */
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <stdbool.h>

	unsigned int lineNo = 0;
	unsigned int commentNo = 0;
%}

%x c_comment cpp_comment string_const

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
"\"" 	{ 
			printf("%s \t QUOTA\n", yytext); 
			BEGIN(string_const);
		}

 /* Keywords */
"int"	{ printf("%s \t INT\n", yytext); }
"float"	{ printf("%s \t FLOAT\n", yytext); }
"bool"	{ printf("%s \t BOOL\n", yytext); }
"void"	{ printf("%s \t VOID\n", yytext); }
"print"	{ printf("%s \t PRINT\n", yytext); }
"if"	{ printf("%s \t IF\n", yytext); }
"else"	{ printf("%s \t ELSE\n", yytext); }
"for"	{ printf("%s \t FOR\n", yytext); }
"while"	{ printf("%s \t WHILE\n", yytext); }
"true"	{ printf("%s \t TRUE\n", yytext); }
"false"	{ printf("%s \t FALSE\n", yytext); }
"break"	{ printf("%s \t BREAK\n", yytext); }
"string"	{ printf("%s \t STRING\n", yytext); }
"return"	{ printf("%s \t RET\n", yytext); }
"continue"	{ printf("%s \t CONT\n", yytext); }

 /* Discard blanks, tabs and newlines */
[" ", "\t"] 	{;}

"\n" { ++lineNo; }
{id}	{ printf("%s \t ID\n", yytext); }


{number}	{ printf("%s \t I_CONST\n", yytext); }
{number}\.{number}	{ printf("%s \t F_CONST\n", yytext); }

 /* Handle string const */
<string_const>[^\"] { printf("%s", yytext); }
<string_const>"\"" { BEGIN(INITIAL); printf(" \t STR_CONST\n"); printf("\" \t QUOTA\n"); }

 /* Handle C-style comment */
<c_comment>"\n" { ++commentNo; printf("%s", yytext);}
<c_comment>[^*/\n] { printf("%s", yytext); }
<c_comment>"*/" { BEGIN(INITIAL); printf("%s \t C Comment\n", yytext); }
<c_comment>"*/\n" { ++commentNo; BEGIN(INITIAL); printf("*/ \t C Comment\n"); }

 /* Handle C++-style comment */
<cpp_comment>[^\n] { printf("%s", yytext); }
<cpp_comment>"\n" { ++commentNo; BEGIN(INITIAL); printf(" \t C++ Comment\n");}

 /* Encounter C-style comment */
"/*" { BEGIN(c_comment); printf("%s", yytext); }
"/*\n" { BEGIN(c_comment); printf("%s", yytext); ++commentNo;}

 /* Encounter C++-style comment */
 "//" { BEGIN(cpp_comment); printf("%s", yytext); }


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
	lineNo += commentNo;
	printf("\nParse over, the line number is %d.\n\n", lineNo);
	printf("comment: %d lines\n\n", commentNo);

	return 0;
}
