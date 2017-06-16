#include "SecImplementation.hpp"
#include <security/Security.h>

SecImplementation::SecImplementation()
{
  qDebug()<<"ios security";
}

QString SecImplementation::generateSecKey() const{
  uint8_t *aesKey = (uint8_t *)calloc(128, sizeof(uint8_t));
  int res = SecRandomCopyBytes(kSecRandomDefault, 128, aesKey);
  if (res != 0){
      QByteArray ba = QByteArray::fromRawData((const char*)aesKey, res);
      return ba.toHex();
    }
  return "";
}

bool SecImplementation::storeSecKey(){
  return true;
}

QString SecImplementation::secKey() const{
  return "64734673467364";
}
