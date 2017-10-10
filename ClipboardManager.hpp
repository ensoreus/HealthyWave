#ifndef CLIPBOARDMANAGER_HPP
#define CLIPBOARDMANAGER_HPP
#include <QtCore>
#include <QGuiApplication>
#include <QClipboard>

class ClipboardManager : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool empty READ isEmpty NOTIFY isEmptyChanged)

public:
  explicit ClipboardManager(QObject *parent = 0) : QObject(parent) {
    clipboard = QGuiApplication::clipboard();
    connect(clipboard, SIGNAL(dataChanged()), this, SLOT(textChanged()));
  }

  Q_INVOKABLE void setText(QString text){
    clipboard->setText(text, QClipboard::Clipboard);
    clipboard->setText(text, QClipboard::Selection);
  }

  Q_INVOKABLE QString text(){
    return clipboard->text();
  }

  bool isEmpty() const{
    return clipboard->text().length() == 0;
  }

public slots:
  void textChanged(){
    emit isEmptyChanged();
  }

signals:
  void isEmptyChanged();

private:
  QClipboard *clipboard;
};

#endif // CLIPBOARDMANAGER_HPP
