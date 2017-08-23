#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "SecurityCore.hpp"
#include "qisystemdispatcher.h"
#include "quickios.h"
#include "qidevice.h"
#include <QScreen>
#include <QQuickView>
#include "StatusBarSetup.h"
#include "source/cpp/misc/pushnotification.h"
#include "NetworkCore.hpp"

static QObject * seccore_qjsvalue_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{

    Q_UNUSED(scriptEngine)
    auto score = new SecurityCore();
    qDebug()<<engine->offlineStoragePath();
    engine->setObjectOwnership(score, QQmlEngine::CppOwnership);
    return score;
}

static QObject * netcore_qjsvalue_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine){
  Q_UNUSED(scriptEngine)
  auto net = new NetworkCore();
  qDebug()<<engine->offlineStoragePath();
  engine->setObjectOwnership(net, QQmlEngine::CppOwnership);
  return net;
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
  //qmlRegisterSingletonType<SecurityCore>("NetworkCore", 1, 0, "NetworkCore", netcore_qjsvalue_singletontype_provider);
  qmlRegisterSingletonType<SecurityCore>("SecurityCore", 1, 0, "SecurityCore", seccore_qjsvalue_singletontype_provider);
  qmlRegisterSingletonType<PushNotificationRegistrationTokenHandler>("com.hw.pushnotification", 1, 0, "PushNotificationRegistrationTokenHandler",
                                                                          PushNotificationRegistrationTokenHandler::pushNotificationRegistrationTokenProvider);
  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("ratio", QVariant::fromValue(m_ratio));
  engine.rootContext()->setContextProperty("fontRatio", QVariant::fromValue(m_ratioFont));
  engine.addImportPath("qrc:///");

  engine.load(QUrl(QLatin1String("qrc:/main.qml")));
  QQuickWindow *window = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
  QuickIOS::setupWindow(window);
  QuickIOS::setStatusBarStyle(QuickIOS::StatusBarStyleLightContent);

  //qDebug()<<  engine.offlineStoragePath();
#ifdef Q_OS_IOS
  setupStatusBar();
#endif

  return app.exec();
}
