#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QString>
#include <iostream>
#include <QFile>
#include<QFileDialog>
#include <QTextStream>
#include <fstream>
#include <QDebug>
#include<QMessageBox>
#include "parser.h"

using namespace std;

extern int yyrestart( FILE* archivo);
extern int yyparse();

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::CrearArchivo(QString texto){

    ofstream fichero;

    fichero.open("entrada.txt",ofstream::out|ofstream::trunc);
    fichero << texto.toStdString() <<endl;
    fichero.close();
}



void MainWindow::on_ButtonAnaliza_clicked()
{
    CrearArchivo(ui->CodigoFuente->toPlainText());
    FILE* input=fopen("entrada.txt","rt");
    yyrestart(input);

    if(!yyrestart){

        char* e= "hola";

        QMessageBox::information(NULL,"ERROR","Error al abrir el archivo");
    }
    yyparse();

}

void MainWindow::on_actionFile_triggered()
{
    if(maybeSave()){

        QString fileName=QFileDialog::getOpenFileName(this, "TextEdito - Open File","/home/juan/Documentos","Text files (* .txt);; All Files (*.*)");

   if(!fileName.isEmpty()){

   QFile file(fileName);
   if(file.open(QFile::ReadOnly)){
       ui->CodigoFuente->setPlainText(file.readAll());
   }

   else{
       QMessageBox::warning(this, "TextEditor",tr("Cannot read File %1.\nError: %2").arg(fileName).arg(file.errorString()));
   }

   }

    }

}

bool MainWindow::maybeSave(){

    if(ui->CodigoFuente->document()->isModified()){

        QMessageBox::StandardButton ret=QMessageBox::warning(this,"TextEditor",tr("The Document has bean Modified""Do you to save your changes?"),QMessageBox::Yes | QMessageBox::No | QMessageBox::Cancel);

        if(ret==QMessageBox::Yes){

            return on_action_Save_triggered();
        }
        else if(ret==QMessageBox::Cancel)

        return false;
    }


   return true;


}

bool MainWindow::on_actionSave_As_triggered()
{

    QString fileName=QFileDialog::getSaveFileName(this, "TextEditor - Save as","/home/juan/Documentos","Text files (*.txt);;All files (*.*)");
    if(!fileName.isEmpty()){
        curFile=fileName;
        return saveFile();
    }
    return false;
}

bool MainWindow::saveFile(){

    QFile file(curFile);
    if(file.open(QFile::WriteOnly)){
        file.write(ui->CodigoFuente->toPlainText().toUtf8());
        return true;
    }
    else{

        QMessageBox::warning(this, "TextEditor",tr("cannot write file %1.\nError %2").arg(curFile).arg(file.errorString()));

        return false;
    }

}

bool MainWindow::on_action_Save_triggered()
{
    if(curFile.isEmpty()){
        return on_actionSave_As_triggered();
    }
    else{

       return saveFile();
    }
}
