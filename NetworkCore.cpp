#include "NetworkCore.hpp"

NetworkCore::NetworkCore(QObject *parent) : QObject(parent)
{
  _networkManager = QSharedPointer<QNetworkAccessManager>(new QNetworkAccessManager());
}

void NetworkCore::registrate(const QString& email, const QString& name, const QString& phone){

}

void NetworkCore::getPinCode(){
  _networkManager->get(QNetworkRequest(QUrl("http://94.130.18.75/debug/hs/GetData/getpincode?phone=+380982559836&securitykey=cb74c34c1ea732b085d3d0c290fc1d21d069075a988780db563836a936c650e5517544787fa5f1d0604eb58a9dda8e3de7ae65f3fabe6dd0fa465d18a6e0f1611dbe84dd2dae43a488221381354cbdb03a314dc1207fdc5f6c310aef385da5ef6c03fa24e64a3cb7d455718e4789ad503171ba51b9cea9ff2bbe9015fe9716aa")));
  //connect(_networkManager, SIGNAL(finished(QNetworkReply *reply)), this, SLOT(gotPinCode(QNetworkReply *reply)));
}

void NetworkCore::gotPinCode(QNetworkReply *reply){
  //qDebug() << reply->
}
