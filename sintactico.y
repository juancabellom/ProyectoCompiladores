%{
#include <iostream>
#include <string>
#include <stdio.h>
#include <algorithm>
#include <QMessageBox>
#include <QString>
int yystopparser=0;
#include "scanner.h"

using namespace std;
void yyerror(char *s);
extern int yylinero;
extern int yyparser;
extern char yyltext;
extern int linea;
extern FILE *yyin;
%}

%token TODOBIEN BIENVENIDO T_COMPILADORES NOMBRECAMPO ENTERO DECIMAL BOLEANDO CADENA T_ENTERO T_DECIMAL T_BOLEANO T_CADENA SUMA RESTA MULTIPLICACION DIVISION AUMENTAR DISMINUIR ASIGNADOR MAYOR MENOR IGUAL MAYORIGUAL MENORIGUAL NOIGUAL SI NO SINO PARA MIENTRAS

%start programa

%%
programa		: principal funciones | principal;

principal		: TODOBIEN BIENVENIDO '(' TODOBIEN ')' '{' lineascodigos '}';

lineascodigos		: lineacodigo |;

lineacodigo		: lineacodigo linea | linea;

linea			: invocarmetodo ';' | crearvariable ';' | cambiarvalor ';' | buclecondicion;

invocarmetodo		: NOMBRECAMPO '(' parametrosenvio ')';

parametrosenvio		: parenvio |;

parenvio		: parenvio ',' penvio | penvio;

penvio			: valor | NOMBRECAMPO;

valor			: ENTERO | DECIMAL | BOLEANDO | CADENA;

crearvariable		: tipodato NOMBRECAMPO | tipodato NOMBRECAMPO asignarvalor;

tipodato		: T_ENTERO | T_DECIMAL | T_BOLEANO | T_CADENA;

asignarvalor		: ASIGNADOR operasignacion | ASIGNADOR valor | ASIGNADOR NOMBRECAMPO;

operasignacion		: aritmetico | invocarmetodo | incredismivariable;

aritmetico		: oprcomun | oprcomun oprcomplemento;

oprcomun		: valor tipoopr valor | valor tipoopr NOMBRECAMPO | NOMBRECAMPO tipoopr valor | NOMBRECAMPO tipoopr NOMBRECAMPO;

tipoopr 		: SUMA | RESTA | MULTIPLICACION | DIVISION;

oprcomplemento		: oprcomplemento oprcom | oprcom;

oprcom			: tipoopr valor | tipoopr NOMBRECAMPO;

incredismivariable	: NOMBRECAMPO indis;

indis			: AUMENTAR | DISMINUIR;

cambiarvalor		: NOMBRECAMPO ASIGNADOR cambvalor;

cambvalor		: valor | operasignacion | NOMBRECAMPO;

buclecondicion		: condicionif | buclefor | buclewhile;

condicionif		: condicionsi | condicionsi condicionno | condicionsi condicionessino condicionno;

condicionsi		: SI '(' condicion ')' '[' lineascodigos ']';

condicion		: valor condicional valor | valor condicional NOMBRECAMPO | NOMBRECAMPO condicional valor | NOMBRECAMPO condicional NOMBRECAMPO;

condicional		: MAYOR | MENOR | IGUAL | MAYORIGUAL | MENORIGUAL | NOIGUAL;

condicionno		: NO '[' lineascodigos ']';

condicionessino		: condicionessino condicionsino | condicionsino;

condicionsino		: SINO '(' condicion ')' '[' lineascodigos ']';

buclefor		: PARA '(' iniciafor ';' condicion ';' incredismivariable ')' '['lineascodigos ']';

iniciafor		: tipodato NOMBRECAMPO asignarvalor;

buclewhile		: MIENTRAS '(' condicion ')' '[' lineascodigos ']';

funciones		: funciones funcion | funcion;

funcion			: tiporetorno NOMBRECAMPO '(' parametrosin ')' '{' lineascodigos '}';

tiporetorno 		: tipodato | TODOBIEN;

parametrosin		: parametros |;

parametros		: parametros ',' parametro | parametro;

parametro		: tipodato NOMBRECAMPO;

%%

void yyerror(char *s){

char* e =strdup(yytext);
std::string *val =new string(yytext,yyleng); 
QString a=val->c_str();
QMessageBox::information(NULL,"ERROR","ERROR SINTACTICO EN:" + a);
}


if(yyparse()==0){
    QMessageBox::information(NULL,"ERROR","SIN ERRORES");

}
