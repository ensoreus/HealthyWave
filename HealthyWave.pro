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

ios:{ SOURCES += SecImpl_ios.cpp
        LIBS+= -framework Security
}
mac: { SOURCES += SecImpl_ios.cpp
        LIBS+= -framework Security
}
android: SOURCES += SecImpl_android.cpp

HEADERS += \
    NetworkCore.hpp \
    SecurityCore.hpp \
    SecImplementation.hpp

