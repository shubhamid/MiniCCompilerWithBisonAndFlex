%{
        #include<stdio.h>
	extern FILE *yyin;
	extern char *yytext;
	extern int count;
%}

%token FOR IF OB CB NUM ID relop PRINTF sc WHILE LB RB arithop EQ STRUCT shorthand TYPE COMMA SCANF HFILE DEFINE MAIN DO SWITCH CASE COLON DEFAULT BREAK STRING AMP

%%

s:	HFILE s
	|DEFINE s
	|Stmt
//	|Function 
	|MainFunc

MainFunc: TYPE MAIN OB CB CompStmt

/* Function Definition block */
//Function: TYPE ID OB CB CompStmt
/*ArgList: ArgList0
	|
ArgList0: ArgList0 COMMA Arg
	|Arg
Arg: TYPE ID*/

Stmt:	ifstmt Stmt
	| ifstmt CompStmt
	| PrintFunc Stmt
	| ScanFunc Stmt
	| WhileStmt Stmt
	| WhileStmt CompStmt
	| ForStmt Stmt
	| ForStmt CompStmt
	| SwitchCase Stmt
	| StructStmt Stmt
	| Assign Stmt
	| DeclarationM Stmt
	| DoWhile Stmt
	| FuncDef CompStmt
	|

CompStmt: LB Stmt RB Stmt

/* Declaration */
DeclarationM: TYPE Declaration
Declaration: ID DeclarationC 
	| ID EQ NUM DeclarationC
	| ID EQ ID DeclarationC

DeclarationC: COMMA Declaration
	| sc 

/* Argument */
ArgumentM: TYPE ID ArgumentC 
	|
ArgumentC: COMMA ArgumentM
	|

/* Struct Statement Block */
StructStmt: STRUCT ID LB DeclarationS RB sc
DeclarationS: DeclarationM DeclarationS
	|

/* Function Call Statement */
FuncCall: ID OB CB

/* Function Def Statement */
FuncDef: TYPE ID OB ArgumentM CB 

/* Switch-Case Statement */
SwitchCase: SWITCH OB ID CB LB SwitchStmt DefaultStmt RB

SwitchStmt: CASE NUM COLON Stmt BREAK sc SwitchStmt
	|	

DefaultStmt: DEFAULT COLON Stmt
	|

/* For Statement Block */
ForStmt: FOR OB Assign sc expr sc AssignF CB

/* While Statement Block */
WhileStmt: WHILE OB expr CB

/* Do-While Statement Block*/
DoWhile: DO LB Stmt RB WhileStmt sc

/* If Statement Block */	
ifstmt:	IF OB expr CB

/* Print Function Block */
PrintFunc: PRINTF OB STRING ArgumentS CB sc

/* Scan Function Block */
ScanFunc: SCANF OB STRING ArgumentS CB sc

/* Arguments for String*/
ArgumentS: COMMA AMP ID ArgumentS
	| COMMA ID ArgumentS
	|

/* Assignment Block */
Assign: ID
	|NUM
	|FuncCall sc
	|FuncCall EQ Assign
	|ID arithop Assign
	|ID EQ Assign
	|ID shorthand Assign
	|NUM shorthand Assign
	|sc

/* For-Assignment Block */
AssignF: ID
	|NUM
	|ID EQ AssignF
	|ID shorthand AssignF
	|NUM shorthand AssignF
	|

/* Expression Block */
expr: 	NUM			
	|ID			
	|NUM relop ID		
	|NUM relop NUM
	|ID relop ID	
	|ID relop NUM
	|ID arithop ID
	|ID arithop NUM
	|

%%

int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	if(!yyparse())
		printf("\nParsing Complete\n");
	fclose(yyin);
    return 0;
}

yyerror()
{
        printf("\nInvalid\nLine = %d \nError: %s\n",count+1,yytext);
}
