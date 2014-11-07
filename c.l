%{
        #include"y.tab.h"
	int count=0;
%}

%%
\/\/.*							{}
"/*"([^*]|[\n]|(\*+([^*/]|[\n])))*"*/" 			{}
"\n" 							{count=count+1;}
"\t"							{}
" "							{}
"#include"[<\"][a-zA-Z.]*".h"[>\"]			{return HFILE;}
"#define "[a-zA-Z]*" "[0-9]*				{return DEFINE;}
\".*\"							{return STRING;}
"main"							{return MAIN;}
"scanf"							{return SCANF;}
"printf"						{return PRINTF;}
"if" 							{return IF;}
"do"							{return DO;}
"while"							{return WHILE;}
"for"							{return FOR;}
"switch"						{return SWITCH;}
"case"							{return CASE;}
"break"							{return BREAK;}
"default"						{return DEFAULT;}
"struct"						{return STRUCT;}
"int"|"char"|"void"|"float"|"double"			{return TYPE;}
"(" 				{return OB;}
")" 				{return CB;}
"{"				{return LB;}
"}"				{return RB;}
[_a-zA-Z][_0-9a-zA-Z]*		{return ID;}
","				{return COMMA;}
":"				{return COLON;}
";"				{return sc;}
"%"				{return AMP;}
"++"|"--"			{return shorthand;}
"+"|"-"|"*"|"/"			{return arithop;}
">="|"<="|">"|"<"|"=="|"!=" 	{return relop;}
"="				{return EQ;}
[0-9]+ 				{return NUM;}
. 				{return yytext[0];}

%%



