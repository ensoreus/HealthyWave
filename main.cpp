#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "NetworkCore.hpp"
#include "SecurityCore.hpp"

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
    engine->setObjectOwnership(score, QQmlEngine::CppOwnership);
    return score;
}

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  qmlRegisterSingletonType<NetworkCore>("NetCore", 1, 0, "NetCore", netcore_qjsvalue_singletontype_provider);
  qmlRegisterSingletonType<SecurityCore>("SecurityCore", 1, 0, "SecurityCore", seccore_qjsvalue_singletontype_provider);
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}
