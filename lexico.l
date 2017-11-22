%option noyywrap
%option yylineno
%{
#include <stdio.h>
#include "parser.h";
#include <iostream>
#include <string>
#include <QString>
#include <QDebug>
#include <QMessageBox>
using namespace std;


%}

ignora " "|\t|\n
caracter [A-Za-z]
digito [0-9]
boleano "true"|"false"

%%

{ignora}*				{;}
"."					{return ('.');}
"{"					{return ('{');}
"}"					{return ('}');}
";"					{return (';');}
","					{return (',');}
")"					{return (')');}
"("					{return ('(');}
"["					{return ('[');}
"]"					{return (']');}
"si"					{return SI;}
"sinou"				        {return SINO;}
"nou"					{return NO;}
"paraque"				{return PARA;}
"mientrastanto"				{return MIENTRAS;}
"todobien"				{return TODOBIEN;}
"bienvenido"				{return BIENVENIDO;}
"int"				        {return T_ENTERO;}
"double"				{return T_DECIMAL;}
"bool"					{return T_BOLEANO;}
"string"				{return T_CADENA;}
"compiladores"                          {return T_COMPILADORES;}
"+"					{return SUMA;}
"-"					{return RESTA;}
"*"					{return MULTIPLICACION;}
"/"					{return DIVISION;}
"++"					{return AUMENTAR;}
"--"					{return DISMINUIR;}
"="					{return ASIGNADOR;}
">"					{return MAYOR;}
"<"					{return MENOR;}
"=="					{return IGUAL;}
">="					{return MAYORIGUAL;}
"<="					{return MENORIGUAL;}
"!="					{return NOIGUAL;}
{digito}+				{return ENTERO;}
{digito}+"."{digito}			{return DECIMAL;}
{boleano}				{return BOLEANDO;}
"\""({digito}|{caracter}|" ")*"\""	{return CADENA;}
{caracter}({caracter}|(digito))*	{return NOMBRECAMPO;}

.                                       {QMessageBox::information(NULL,"ERROR","INCORECTO LEXICO");}
%%



