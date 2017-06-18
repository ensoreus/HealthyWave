#ifndef SECIMPL_IOS_HPP
#define SECIMPL_IOS_HPP
#include <QtCore>

class SecImplementation
{
protected:
  SecImplementation();
  QString generateSecKey();
  bool storeSecKey();
  bool retriveSecKey();
  QString secKey() const;
  friend class SecurityCore;
  QString _secKey;
};

#endif // SECIMPL_IOS_HPP
