
#include "sharepicker.hpp"

#if defined(Q_OS_IOS)
#include "sharepicker_ios.hpp"
#elif defined(Q_OS_ANDROID)
#include "sharepicker_android.hpp"
#endif

ShareUtils::ShareUtils(QQuickItem *parent)  
    : QQuickItem(parent)
{
#if defined(Q_OS_IOS)
    _pShareUtils = new IosSharePicker(this);
#elif defined(Q_OS_ANDROID)
    _pShareUtils = new AndroidShareUtils(this);
#else
    _pShareUtils = new PlatformShareUtils(this);
#endif
}

void ShareUtils::share(const QString &text, const QUrl &url)  
{
    _pShareUtils->share(text, url);
}
