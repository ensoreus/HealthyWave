#include "NetworkCore.hpp"

NetworkCore::NetworkCore(QObject *parent) : QObject(parent)
{
  _networkManager = QSharedPointer<QNetworkAccessManager>(new QNetworkAccessManager());
}

void NetworkCore::registrate(const QString& email, const QString& name, const QString& phone){

}

void NetworkCore::authorize(){

}
