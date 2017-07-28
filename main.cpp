#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "SecurityCore.hpp"
#include "qisystemdispatcher.h"
#include "quickios.h"
#include "qidevice.h"
#include <QScreen>
#include <QQuickView>

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
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

#ifdef Q_OS_DARWIN
  qreal m_ratio = 1;
  qreal m_ratioFont = 1;
#else
  qreal refDpi = 160.;
  //  qreal refHeight = 1776.;
  //  qreal refWidth = 1080.;
qreal refHeight = 736.;
qreal refWidth = 414.;
  QRect rect = QGuiApplication::primaryScreen()->geometry();
  qreal height = qMax(rect.width(), rect.height());
  qreal width = qMin(rect.width(), rect.height());
  qreal dpi = QGuiApplication::primaryScreen()->logicalDotsPerInch();
  qreal m_ratio = qMin(height/refHeight, width/refWidth);
  qreal m_ratioFont = qMin(height*refDpi/(dpi*refHeight), width*refDpi/(dpi*refWidth));
#endif

  app.setOrganizationName("SEOTM");
  app.setOrganizationDomain("seotm.com");
  app.setApplicationName("HealthyWave");

  QuickIOS::registerTypes();
  qmlRegisterSingletonType<SecurityCore>("SecurityCore", 1, 0, "SecurityCore", seccore_qjsvalue_singletontype_provider);
  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("ratio", QVariant::fromValue(m_ratio));
  engine.rootContext()->setContextProperty("fontRatio", QVariant::fromValue(m_ratioFont));
  engine.addImportPath("qrc:///");
  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}
