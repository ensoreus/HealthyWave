#include "SecImplementation.hpp"
#include <random>

SecImplementation::SecImplementation()
{
  qDebug()<<"android";
}

QString SecImplementation::generateSecKey(){
  std::random_device rd;  //Will be used to obtain a seed for the random number engine
  std::mt19937 gen(rd()); //Standard mersenne_twister_engine seeded with rd()
  std::uniform_int_distribution<> dis(0, 15);
  QByteArray ba;
  for (int n = 0; n < 128; n++){
      char digit = dis(gen);
      ba.append(digit);
    }
  //qDebug() << ba.toHex() << '\n';
  return ba.toHex();
}

bool SecImplementation::storeSecKey(){
  return true;
}

QString SecImplementation::secKey() const{
  return _secKey;
}

bool SecImplementation::retriveSecKey(){
  return true;
}
