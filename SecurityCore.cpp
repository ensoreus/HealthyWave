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

QString SecurityCore::hmacMd5(const QString& line){
  QCryptographicHash hashMaker(QCryptographicHash::Md5);
  hashMaker.addData(line.toStdString().c_str());
  return hashMaker.result().toBase64();
}
