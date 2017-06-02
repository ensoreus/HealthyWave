#ifndef NETWORKCORE_HPP
#define NETWORKCORE_HPP

#include <QObject>

class NetworkCore : public QObject
{
  Q_OBJECT

  //Q_PROPERTY(QImage avatar READ avatar WRITE setAvatar NOTIFY avatarChanged)

public:
  explicit NetworkCore(QObject *parent = 0);
  //QImage avatar() const;

  Q_INVOKABLE void registrate(const QString& email, const QString& name, const QString& phone);
  Q_INVOKABLE void authorize();

signals:
  //void avatarChanged();
  void authorized();
  void registered();

public slots:
  //void setAvatar(const QImage& img);
};

#endif // NETWORKCORE_HPP
