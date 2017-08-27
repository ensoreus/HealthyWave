#ifndef CLIPBOARDMANAGER_HPP
#define CLIPBOARDMANAGER_HPP
#include <QtCore>
#include <QGuiApplication>
#include <QClipboard>

class ClipboardManager : public QObject
{
  Q_OBJECT
 public:
     explicit ClipboardManager(QObject *parent = 0) : QObject(parent) {
         clipboard = QGuiApplication::clipboard();
     }

     Q_INVOKABLE void setText(QString text){
         clipboard->setText(text, QClipboard::Clipboard);
         clipboard->setText(text, QClipboard::Selection);
     }

    Q_INVOKABLE QString text(){
        return clipboard->text();
    }



 private:
     QClipboard *clipboard;
};

#endif // CLIPBOARDMANAGER_HPP
