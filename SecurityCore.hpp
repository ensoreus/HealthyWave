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
  Q_INVOKABLE QString hmacMd5(const QString& line, const QString& key);
  Q_INVOKABLE QString createUid() const;
  Q_INVOKABLE QString base64Image(const QString& path);
  Q_INVOKABLE QString saveBase64(const QString& ba);
  Q_INVOKABLE QString tempDir() const;

signals:
  void secKeyChanged();
  void secKeyGenerated();

private:
  SecImplementation* _impl;
#ifdef Q_OS_ANDROID
  QString and_tempDir() const;
#endif
};

#endif // SECURITYCORE_HPP
