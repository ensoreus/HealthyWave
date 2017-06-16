#ifndef SECIMPL_IOS_HPP
#define SECIMPL_IOS_HPP
#include <QtCore>

class SecImplementation
{
protected:
  SecImplementation();
  QString generateSecKey() const;
  bool storeSecKey();
  QString secKey() const;
  friend class SecurityCore;
};

#endif // SECIMPL_IOS_HPP
