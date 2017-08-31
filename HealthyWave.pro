QT += qml quick network sql

CONFIG += c++11

SOURCES += main.cpp \
    NetworkCore.cpp \
    SecurityCore.cpp \
    source/cpp/misc/pushnotification.cpp \
    ClipboardManager.cpp


RESOURCES += qml.qrc
include(quickios.pri)


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ios:{
     SOURCES += SecImpl_ios.cpp StatusBarSetup.mm
     LIBS+= -framework Security -framework CoreFoundation
    ######## adapt the following value to match your TeamID ########
    MY_DEVELOPMENT_TEAM.value = "Philipp Maluta"
    ################################################################

    MY_DEVELOPMENT_TEAM.name = DEVELOPMENT_TEAM
    QMAKE_MAC_XCODE_SETTINGS += MY_DEVELOPMENT_TEAM

    MY_ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
    MY_ENTITLEMENTS.value = $$PWD/ios/pushnotifications.entitlements
    QMAKE_MAC_XCODE_SETTINGS += MY_ENTITLEMENTS

    QMAKE_IOS_DEPLOYMENT_TARGET=8.0

    # Note for devices: 1=iPhone, 2=iPad, 1,2=Universal.
    QMAKE_IOS_TARGETED_DEVICE_FAMILY = 1

    #QMAKE_INFO_PLIST = $$PWD/ios/Info.plist

    OBJECTIVE_SOURCES += \
                    $$PWD/source/cpp/misc/ios/pushnotification.mm

    CONFIG -= bitcode
}

mac: {
    SOURCES += SecImpl_ios.cpp
    LIBS+= -framework Security
}

android: {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    ################# adapt that accordingly #######################
    ANDROID_JAVA_SOURCES.path = /src/com/ensoreus/hw
    ################################################################

    ANDROID_JAVA_SOURCES.files = $$files($$PWD/source/java/*.java)
    INSTALLS += ANDROID_JAVA_SOURCES
    SOURCES += SecImpl_android.cpp
}


HEADERS += \
    NetworkCore.hpp \
    SecurityCore.hpp \
    NetworkCore.hpp \
    SecImplementation.hpp \
    source/cpp/misc/pushnotification.h \
    ClipboardManager.hpp

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat



