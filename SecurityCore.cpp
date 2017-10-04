#include "SecurityCore.hpp"
#include <QByteArray>
#include <QImage>
#include <QDataStream>

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
  hashMaker.setKey(key.toStdString().c_str());
  hashMaker.addData(line.toStdString().c_str());
  return hashMaker.result().toHex();
}

QString SecurityCore::base64Image(const QString& path){
  QUrl url(path);
  QFile picfile(url.toLocalFile());
  qDebug()<< "base64Image: " << url.toLocalFile();

  if(!picfile.open(QIODevice::ReadOnly)){
      return "";
    }
  QString bs64;
  QByteArray barray;
  while (!picfile.atEnd()) {
      QByteArray baChunk = picfile.readLine();
      barray.append(baChunk);
    }
  QImage img;
  img.loadFromData(barray);
  QImage simg;
  if(img.size().width() > img.size().height()){
      simg = img.scaledToWidth(200);
    }else{
      simg = img.scaledToHeight(200);
    }

  QByteArray smallPicArray;
  QBuffer buffer(&smallPicArray);
  buffer.open(QBuffer::ReadWrite);
  simg.save(&buffer, "PNG");
  bs64 = smallPicArray.toBase64();
  return bs64;
}

QString SecurityCore::tempDir() const{
    auto path = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
    QUrl  pathurl(path);
    pathurl.setScheme("file");
    return pathurl.toString();
}

QString SecurityCore::saveBase64(const QString& ba){
  QByteArray barray = ba.toUtf8();
  QString tmpPath = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
  //qDebug()<< barray;
  QImage img = QImage::fromData(barray, "PNG");
  QString avUrl = tmpPath + "/av.png";
  QUrl pathurl(avUrl);
  pathurl.setScheme("file");
  img.save(avUrl, "PNG");
  return pathurl.toString();
}

QString SecurityCore::createUid() const{
  return QUuid::createUuid().toString();
}

