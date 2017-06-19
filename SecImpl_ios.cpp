#include "SecImplementation.hpp"
#include <security/Security.h>
#include <random>
#include <iostream>

SecImplementation::SecImplementation()
{
  qDebug()<<"ios security";
}

QString SecImplementation::generateSecKey(){
  uint8_t *aesKey = (uint8_t *)calloc(128, sizeof(uint8_t));
  int res = SecRandomCopyBytes(kSecRandomDefault, 128, aesKey);
  if (res == 0){
      QByteArray ba = QByteArray::fromRawData((const char*)aesKey, 128);
      _secKey = ba.toHex();
      return ba.toHex();
    }
  return "";
}

bool SecImplementation::storeSecKey(){
 /* CFMutableDictionaryRef attributes = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
  CFMutableDataRef keyData = CFDataCreateMutable(kCFAllocatorDefault, 128);
  CFDataAppendBytes(keyData, (UInt8*)_secKey.toStdString().c_str(), 128);
  int16_t sint = 128;



  CFErrorRef error = NULL;
  SecAccessControlRef acl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleAfterFirstUnlock, kNilOptions, &error);
  SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                  kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                  kSecAccessControlTouchIDAny | kSecAccessControlPrivateKeyUsage, &error);

  CFMutableDictionaryRef privateKeyAttrDict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
  CFDictionarySetValue(privateKeyAttrDict, kSecAttrAccessControl, sacObject);
  char bPermanent = 1;
  CFNumberRef isPerm = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &bPermanent);
  CFDictionarySetValue(privateKeyAttrDict, kSecAttrIsPermanent, isPerm);


  CFNumberRef len = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt16Type, &sint);
  CFDictionarySetValue(attributes, kSecClassKey, kSecClass);
  CFDictionarySetValue(attributes, kSecAttrApplicationTag, "com.ensoreus.HealthyWave");
  CFDictionarySetValue(attributes, kSecValueData, keyData);
  CFDictionarySetValue(attributes, kSecAttrKeySizeInBits, len);
  CFDictionarySetValue(attributes, kSecAttrAccessControl, acl);
  CFDictionarySetValue(attributes, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
  CFDictionarySetValue(attributes, kSecAttrIsPermanent, isPerm);
  CFDictionarySetValue(attributes, kSecPrivateKeyAttrs, privateKeyAttrDict);

  auto res = SecItemAdd(attributes, nil);
  CFRelease(attributes);
  CFRelease(keyData);
  CFRelease(len);*/
  return  true;//res == errSecSuccess;
}

QString SecImplementation::secKey() const{
  return _secKey;
}

bool SecImplementation::retriveSecKey(){

}
