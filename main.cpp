#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "NetworkCore.hpp"
#include "SecurityCore.hpp"
#include "qisystemdispatcher.h"
#include "quickios.h"
#include "qidevice.h"

static QObject * netcore_qjsvalue_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{

    Q_UNUSED(scriptEngine)
    auto ncore = new NetworkCore();
    engine->setObjectOwnership(ncore, QQmlEngine::CppOwnership);
    return ncore;
}

static QObject * seccore_qjsvalue_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{

    Q_UNUSED(scriptEngine)
    auto score = new SecurityCore();
    qDebug()<<engine->offlineStoragePath();
    engine->setObjectOwnership(score, QQmlEngine::CppOwnership);
    return score;
}

int main(int argc, char *argv[])
{

//#ifdef Q_OS_IOS
//    QGuiApplication app(argc, argv);
//#else
//    QApplication app(argc,argv);
//#endif
QGuiApplication app(argc, argv);
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  //qmlRegisterSingletonType<NetworkCore>("NetCore", 1, 0, "NetCore", netcore_qjsvalue_singletontype_provider);
  qmlRegisterSingletonType<SecurityCore>("SecurityCore", 1, 0, "SecurityCore", seccore_qjsvalue_singletontype_provider);

  QQmlApplicationEngine engine;
  engine.addImportPath("qrc:///");
  QuickIOS::registerTypes();
  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}
