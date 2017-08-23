#ifndef NETWORKCORE_HPP
#define NETWORKCORE_HPP

#include <QObject>
#include <QtNetwork>

class NetworkCore : public QObject
{
  Q_OBJECT

public:
  explicit NetworkCore(QObject *parent = 0);
  Q_INVOKABLE void registrate(const QString& email, const QString& name, const QString& phone);
  Q_INVOKABLE void getPinCode();

signals:
  void authorized();
  void registered();

public slots:
  void gotPinCode(QNetworkReply *reply);

protected:
  void connectToHost();

private:
  QSharedPointer<QNetworkAccessManager> _networkManager;
};

#endif // NETWORKCORE_HPP
