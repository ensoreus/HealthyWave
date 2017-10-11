#ifndef _SHAREMAKER_H_
#define _SHAREMAKER_H_

#include <QQuickItem>

class PlatformShareUtils : public QQuickItem
{
public:
    PlatformShareUtils(QQuickItem *parent = 0) : QQuickItem(parent){}
    virtual ~PlatformShareUtils() {}
    virtual void share(const QString &text, const QUrl &url){ qDebug() << text << url; }
};

class ShareUtils: public QQuickItem{
  
 Q_OBJECT
    PlatformShareUtils* _pShareUtils;
public:
    explicit ShareUtils(QQuickItem *parent = 0);
    Q_INVOKABLE void share(const QString &text, const QUrl &url);
  
};
#endif
