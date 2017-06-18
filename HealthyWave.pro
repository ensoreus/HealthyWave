QT += qml quick network

CONFIG += c++11

SOURCES += main.cpp \
    NetworkCore.cpp \
    SecurityCore.cpp


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ios:{
     SOURCES += SecImpl_ios.cpp
     LIBS+= -framework Security -framework CoreFoundation
    MY_ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
    MY_ENTITLEMENTS.value = $$PWD/HealthyWave.entitlements
    QMAKE_MAC_XCODE_SETTINGS += MY_ENTITLEMENTS
    APP_QML_FILES.files = $$PWD/HealthyWave.entitlements
    APP_QML_FILES.path = Contents/Resources
    QMAKE_BUNDLE_DATA += APP_QML_FILES
}
mac: {
    SOURCES += SecImpl_ios.cpp
    LIBS+= -framework Security -framework CoreFoundation

    MY_ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
    MY_ENTITLEMENTS.value = Contents/HealthyWave.entitlements
    QMAKE_MAC_XCODE_SETTINGS += MY_ENTITLEMENTS

    APP_QML_FILES.files = $$PWD/HealthyWave.entitlements
    APP_QML_FILES.path = Contents
    QMAKE_BUNDLE_DATA += APP_QML_FILES
}

android: {
    SOURCES += SecImpl_android.cpp
    LIBS += -lcrypto
}

HEADERS += \
    NetworkCore.hpp \
    SecurityCore.hpp \
    SecImplementation.hpp


