#include "SecurityCore.hpp"


SecurityCore::SecurityCore(QObject *parent) : QObject(parent)
{
  _impl = new SecImplementation();
}

QString SecurityCore::generateSecKey(){
  return _impl->generateSecKey();
}

bool SecurityCore::storeSecKey(){
  return _impl->storeSecKey();
}

QString SecurityCore::secKey() const{
  return _impl->secKey();
}

bool SecurityCore::retriveSecKey(){
  return _impl->retriveSecKey();
}

QString SecurityCore::hmacMd5(const QString& line, const QString& key){
   QMessageAuthenticationCode hashMaker(QCryptographicHash::Md5);
   qDebug() << key;
   hashMaker.setKey(key.toStdString().c_str());
   hashMaker.addData(line.toStdString().c_str());
   return hashMaker.result().toHex();
}

QString SecurityCore::createUid() const{
  return QUuid::createUuid().toString();
}
