#-------------------------------------------------
#
# Project created by QtCreator 2017-11-16T11:17:58
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ProyectoCompiladores
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    parser.cpp \
    scanner.cpp

HEADERS  += mainwindow.h \
    lexico.l \
    parser.h \
    scanner.h \
    sintactico.y

FORMS    += mainwindow.ui

DISTFILES += \

