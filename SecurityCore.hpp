#ifndef SECURITYCORE_HPP
#define SECURITYCORE_HPP

#include <QObject>
#include "SecImplementation.hpp"

class SecurityCore : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QString secKey READ secKey NOTIFY secKeyChanged)

public:
  explicit SecurityCore(QObject *parent = 0);
  Q_INVOKABLE QString generateSecKey();
  Q_INVOKABLE bool storeSecKey();
  QString secKey() const;
  Q_INVOKABLE bool retriveSecKey();

signals:
  void secKeyChanged();
  void secKeyGenerated();

private:
  SecImplementation* _impl;
};

#endif // SECURITYCORE_HPP
