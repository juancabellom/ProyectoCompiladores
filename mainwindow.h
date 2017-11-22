#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void on_ButtonAnaliza_clicked();
    void CrearArchivo(QString texto);

    void on_actionFile_triggered();

    bool on_actionSave_As_triggered();

    bool on_action_Save_triggered();

    void on_ButtonAnaliza_toggled(bool checked);

private:
    Ui::MainWindow *ui;
    bool saveFile();
    QString curFile;
    bool maybeSave();
};

#endif // MAINWINDOW_H
