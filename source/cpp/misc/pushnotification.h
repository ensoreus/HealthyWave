#ifndef PUSHNOTIFICATION_H
#define PUSHNOTIFICATION_H

#include <QObject>
#include <QQmlEngine>

class PushNotificationRegistrationTokenHandler : public QObject{
    Q_OBJECT
    Q_PROPERTY(QString gcmRegistrationToken READ getGcmRegistrationToken NOTIFY gcmRegistrationTokenChanged)
    Q_PROPERTY(QString apnsRegistrationToken READ getAPNSRegistrationToken WRITE setAPNSRegistrationToken NOTIFY apnsRegistrationTokenChanged)
    Q_PROPERTY(QString lastNotification READ getLastNotification WRITE setLastNotification NOTIFY lastNotificationChanged)

public:
    PushNotificationRegistrationTokenHandler(QObject* parent = 0);
    //singleton type provider function for Qt Quick
    static QObject* pushNotificationRegistrationTokenProvider(QQmlEngine *engine, QJSEngine *scriptEngine);
    //singleton object provider for C++
    static PushNotificationRegistrationTokenHandler* instance();
    void setGcmRegistrationToken(const QString& gcmRegistrationToken);
    QString getGcmRegistrationToken();
    QString getAPNSRegistrationToken() const;
    QString getLastNotification();
    void setAPNSRegistrationToken(const QString& apnsToken);
    void setLastNotification(const QString& message);
    ~PushNotificationRegistrationTokenHandler();
signals:
    void gcmRegistrationTokenChanged();
    void apnsRegistrationTokenChanged();
    void lastNotificationChanged();
    void registeredChanged();
private:
    QString m_gcmToken;
    QString m_apnsToken;
    QString m_lastNotification;
};


#endif // PUSHNOTIFICATION_H
